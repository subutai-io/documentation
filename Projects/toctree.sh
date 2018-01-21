#!/bin/bash

function camel() {
  echo "$1" | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1'
}

PROJECTS=/readthedocs/Projects
PROJECT_NAME="$1"
PROJECT_DIR="$PROJECTS/$PROJECT_NAME"

if [ -z "$PROJECT_NAME" ]; then
  echo "[ERROR] Missing project name argument. Exiting with non-zero status."
  echo
  echo "Usage: $0 <project_name>"
  echo
  exit 1
fi

WIKI_URL=''
CONFIG_FILE="$(cat $PROJECT_DIR/.git | awk -F':' '{print $2}' | sed -e 's/ //g' -e 's@\.\./@@' )/config"
GIT_URL="$(cat $CONFIG_FILE | egrep 'url = .*github.com.*\.wiki\.git$' | awk -F'=' '{print $2}' | sed -e 's/ //g')"
PROJECT_URL="$(echo $GIT_URL | sed -e 's/\.wiki\.git$//')"
WIKI_URL="$PROJECT_URL/wiki"
PROJECT_NAME_CAMEL="$(camel $PROJECT_NAME)"

echo "[DEBUG] CONFIG_FILE = $CONFIG_FILE"
echo "[DEBUG] GIT_URL = $GIT_URL"
echo "[DEBUG] PROJECT_URL = $PROJECT_URL"
echo "[DEBUG] WIKI_URL = $WIKI_URL"

sidebar_base="_Sidebar.md"
sidebar_file="$PROJECT_DIR/$sidebar_base"
toctree_file=$PROJECT_NAME'_toctree.rst'

declare -A uniq_paths
declare -A rst2ppath
declare -A skipped
skipped=(
    [Home.md]=true
    [_Sidebar.md]=true
    [_Footer.md]=true
    [_Header.md]=true
    [$sidebar_base]=true
)

for mdfile in `find $PROJECT_DIR -type f -regex '.*\.md'`; do
  mdbase="$(basename $mdfile)"

  # Skip files some wiki files
  if [ "${skipped[$mdbase]}" ]; then
    echo "[DEBUG] Skipping $mdfile"
    continue
  fi

  no_ext="$(echo $mdbase | sed -e 's/\.md$//')"
  rstfile="$(echo $mdfile | sed -e 's/\.md$/\.rst/')"
  rstbase="$no_ext"'.rst'
  title="$(echo $no_ext | sed -e 's/-/ /g')"
  title="$(camel $title)"
  
  match=$(head -n 1 $mdfile | grep -i '# '"$title")
  if [ -z "$match" ]; then
    cp "$mdfile" "$mdfile"'.tmp'
    echo "# $title"      > "$mdfile"
    echo                >> "$mdfile"
    cat "$mdfile"'.tmp' >> "$mdfile"
    rm -f "$mdfile"'.tmp'
  fi

  echo "[DEBUG] no_ext = $no_ext"
  parent_path='/Uncategorized'
  if [ -n "$(tail -n 5 $mdfile | grep PARENT_PATH)" ]; then
    parent_path="$(tail -n 5 $mdfile | grep PARENT_PATH | awk -F':' '{print $2}' | sed -e 's/^ //g' -e 's/ $//g')"
  fi
  
  rst2ppath+=([$rstfile]=$parent_path)

  if [ ! "${uniq_paths[$parent_path]}" ]; then
    uniq_paths+=([$parent_path]=true)
  fi

  echo "[DEBUG] $rstbase parent_path = $parent_path"
  echo "[DEBUG] converting $rstbase"

  pandoc --from markdown --to rst $mdfile -o $rstfile
done

echo
echo "Generating toctree file $toctree_file"
echo                                                          > $toctree_file
echo ".. _$PROJECT_NAME-section:"                            >> $toctree_file
echo                                                         >> $toctree_file
echo '.. toctree::'                                          >> $toctree_file
echo '   :maxdepth: 2'                                       >> $toctree_file
echo "   :caption: Subutai $PROJECT_NAME_CAMEL"              >> $toctree_file
echo                                                         >> $toctree_file

#
# ----------------------------------------------------------------------------
# Process the root entries
# ----------------------------------------------------------------------------
#

echo
echo "Processing / entries first:"
echo

declare -a sorted_files
for rstfile in "${!rst2ppath[@]}"; do
  if [ "/" == "${rst2ppath["$rstfile"]}" ]; then
    sorted_files+=($rstfile)
  fi
done

IFS=$'\n' sorted_files=($(sort <<<"${sorted_files[*]}"))
echo "Sorted rst files = ${sorted_files[@]}"

for rstfile in "${sorted_files[@]}"; do
  rstbase="$(basename $rstfile)"
  no_ext="$(echo $rstbase | sed -e 's/\.rst$//')"
  title="$(echo $no_ext | sed -e 's/-/ /g')"
  title="$(camel $title)"

  if [ "/" == "${rst2ppath["$rstfile"]}" ]; then
    entry='   '$title' <'$PROJECT_NAME/$rstbase'>'
    echo "$entry" >> $toctree_file
    echo "[DEBUG] $base file matches path $path"
  fi
done

#
# ----------------------------------------------------------------------------
# Process the non-root entries
# ----------------------------------------------------------------------------
#

for path in "${!uniq_paths[@]}"; do
  # Skipping / since this was already handled in the loop above
  if [ "$path" == "/" ]; then
    echo "skipping path when it is /"
    continue
  else 
    echo "path is $path"
  fi

  echo
  echo "Processing Path $path Entries:"
  echo

  sorted_files=()
  for rstfile in "${!rst2ppath[@]}"; do
    if [ "$path" == "${rst2ppath["$rstfile"]}" ]; then
      sorted_files+=($rstfile)
    fi
  done

  IFS=$'\n' sorted_files=($(sort <<<"${sorted_files[*]}"))
  echo "Sorted rst files = ${sorted_files[@]}"

  rootless_path="$(echo $path | sed -e 's@^/@@')"
  sub_toctree_file=$rootless_path'_'$PROJECT_NAME'_toctree.rst'

  echo
  echo "Generating toctree file $sub_toctree_file"
  echo                                                        > $sub_toctree_file
  echo ".. _$rootless_path-$PROJECT_NAME-section:"           >> $sub_toctree_file
  echo                                                       >> $sub_toctree_file
  echo '.. toctree::'                                        >> $sub_toctree_file
  echo '   :maxdepth: 2'                                     >> $sub_toctree_file
  echo "   :caption: $PROJECT_NAME_CAMEL $rootless_path"     >> $sub_toctree_file
  echo                                                       >> $sub_toctree_file

  for rstfile in "${sorted_files[@]}"; do
    rstbase="$(basename $rstfile)"
    no_ext="$(echo $rstbase | sed -e 's/\.rst$//')"
    title="$(echo $no_ext | sed -e 's/-/ /g')"
    title="$(camel $title)"
    
    if [ "$path" == "${rst2ppath[$rstfile]}" ]; then
      entry='   '$title' <'$PROJECT_NAME/$rstbase'>'
      echo "$entry" >> $sub_toctree_file
      echo "[DEBUG] $base file matches path $path"
    fi
  done

  echo              >> $sub_toctree_file
  echo '   '$rootless_path' <'$sub_toctree_file'>' >> $toctree_file 
done
