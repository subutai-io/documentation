#!/bin/bash

# ARG $1: a word or a string of whitespace separated words
# OUTPUT: Converts any string of words to captitalize first letter of each word
function fn_camel() {
  echo "$1" | awk '{for(i=1;i<=NF;i++)sub(/./,toupper(substr($i,1,1)),$i)}1'
}

# ARG $1: takes a file with or without a path and generates a title
# OUTPUT: the title with camel hump notation
function fn_title() {
  local file=$(basename "$1")
  local no_ext=$(echo "$file" | sed 's/\.[^.]*$//')
  fn_camel $(echo "$no_ext" | sed 's/-\|_/ /g')
}

# ARG $1: the title to generate the h1 header for
# OUTPUT: the two lined md/rst compat h1 header for the title:
#
# 'Test Header for Title'
# '====================='
#
function fn_header() {
  local title="$1"
  local num="$(echo ${#title})"
  v=$(printf "%-${num}s" "=")
  echo "$title"
  echo "${v// /=}"
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

# 
# ----------------------------------------------------------------------------
# MD->RST Conversion Loop
# ----------------------------------------------------------------------------
# A few things are being done here that need to be noted:
#
#   1. We are looping through all the dot.md file paths under the
#      Projects directory and calculating:
#        (a) the base file name without path
#        (b) the base file name without path and without extension
#        (c) the title of the file by breaking appart file words
#        (d) the rstfile equivalent of mdfile (swap rst for md file extension)
#        (e) the rstbase equivalent of mdbase (swap rst for md file extension)
#   2. RTD wants a title at the begining of the files given to it, we
#      check if the title is there and if not inject the title we calculated
#   3. We read the end of the file looking for PARENT_PATH and if we find it
#      we put the PARENT_PATH into a hash using the rstfile as the key
#   4. We also populate the hash 'uniq_paths' with unique parent paths
#      we encounter. We do not use the value. This is done so we know the
#      set of groups of entries we will have to generate separate sub-toctrees
#      for, without PARENT_PATH we put the RST in as Uncategorized
#   5. Lastly we use pandoc to generate the RST file from the MD file
#

for mdfile in `find $PROJECT_DIR -type f -regex '.*\.md'`; do
  # (1) start
  mdbase="$(basename $mdfile)"

  # Skip files some wiki files
  if [ "${skipped[$mdbase]}" ]; then
    echo "[DEBUG] Skipping $mdfile"
    continue
  fi

  rstfile="$(echo $mdfile | sed -e 's/\.md$/\.rst/')"
  rstbase="$(basename $rstfile)"
  title="$(fn_title $rstfile)"
  
  # (2) start
  match=$(head -n 1 $mdfile | grep -i '# '"$title")
  if [ -z "$match" ]; then
    cp "$mdfile" "$mdfile"'.tmp'
    echo "# $title"      > "$mdfile"
    echo                >> "$mdfile"
    cat "$mdfile"'.tmp' >> "$mdfile"
    rm -f "$mdfile"'.tmp'
  fi

  # (3) start
  parent_path='/Uncategorized'
  if [ -n "$(tail -n 5 $mdfile | grep PARENT_PATH)" ]; then
    parent_path="$(tail -n 5 $mdfile | grep PARENT_PATH | awk -F':' '{print $2}' | sed -e 's/^ //g' -e 's/ $//g')"
  fi
  
  rst2ppath+=([$rstfile]=$parent_path)

  # (4) start
  if [ ! "${uniq_paths[$parent_path]}" ]; then
    uniq_paths+=([$parent_path]=true)
  fi

  echo "[DEBUG] $rstbase parent_path = $parent_path"
  echo "[DEBUG] converting $rstbase"

  # (5)
  pandoc --from markdown --to rst $mdfile -o $rstfile
done

#
# ----------------------------------------------------------------------------
# Process the root entries
# ----------------------------------------------------------------------------
#
# This will generate the toctree file for the project. It operates in two
# modes depending on the presence of the file in git. If it is in git, then
# we presume changes have been made to the file that the authors want kept
# rather than be overwritten. If present we append entries to the existing
# content in the file. If not present we generate its section header and
# its toctree entry.
#

if [ -n "$(git status -s . | grep '^??' | grep $toctree_file)" ]; then
  echo
  echo "Generating untracked toctree file $toctree_file"     
  
                                                        # NOTE: > new file
  echo                                                          > $toctree_file

  # Need this to be an h1 header
  fn_header "$(fn_title $PROJECT_NAME)"                        >> $toctree_file

  echo                                                         >> $toctree_file
  echo '.. toctree::'                                          >> $toctree_file
  echo '   :maxdepth: 2'                                       >> $toctree_file
  echo "   :caption: Subutai $PROJECT_NAME_CAMEL"              >> $toctree_file
  echo                                                         >> $toctree_file
else
  echo
  echo "Altering existing tracked toctree file $toctree_file"
fi

echo "Processing root entries first:"

# Quick loop to filter and collect rstfiles and sort them, the filtering
# is on the root PARENT_PATH value, not in some category i.e. CLI in agent
declare -a sorted_files
for rstfile in "${!rst2ppath[@]}"; do
  if [ "/" == "${rst2ppath["$rstfile"]}" ]; then
    sorted_files+=($rstfile)
  fi
done
IFS=$'\n' sorted_files=($(sort <<<"${sorted_files[*]}"))
echo "Sorted rst files = ${sorted_files[@]}"

# Now use the sorted files to iterate in sorted order through collected
# root elements and add to the TOC as root entries. Others processed below.
for rstfile in "${sorted_files[@]}"; do
  rstbase="$(basename $rstfile)"
  title="$(fn_title $rstfile)"

  if [ "/" == "${rst2ppath["$rstfile"]}" ]; then
    entry='   '$title' <'$PROJECT_NAME/$rstbase'>'
    found=$(cat $toctree_file | grep "$entry")

    if [ -z "$found" ]; then
      echo "$entry" >> $toctree_file
    else
      echo "[WARN] Entry '$entry' already found in file $toctree_file"
    fi
    
    echo "[DEBUG] $base file matches path $path"
  fi
done

#
# ----------------------------------------------------------------------------
# Process the non-root entries
# ----------------------------------------------------------------------------
#
# Here we create separate table of content tree files for each non-root entry.
# Meaning for mdfiles files categorized under like /CLI for the agent CLI
# commands for example or other categories we create a separate toctree listing. 
#
# We skip all the root entries we already processed in the above loop. Also we
# now start using the uniq_paths hash whose keys keep unique PARENT_PATH 
# elements for us. For each one we will generate a separate toc tree file and
# fill it in with the files of the same PARENT_PATH.
#

for path in "${!uniq_paths[@]}"; do
  # Skipping / since this was already handled in the loop above
  if [ "$path" == "/" ]; then
    echo "[INFO] Skipping root paths"
    continue
  fi

  echo
  echo "[DEBUG] Processing Path $path Entries:"
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

  if [ -n "$(git status -s . | grep '^??' | grep $sub_toctree_file)" ]; then
    echo
    echo "[DEBUG] Generating untracked toctree file $sub_toctree_file" 

    # Need this to be an h1 header                        NOTE: > new file
    fn_header "$(fn_title $rootless_path'_'$PROJECT_NAME)"      > $sub_toctree_file
    echo                                                       >> $sub_toctree_file
    echo '.. toctree::'                                        >> $sub_toctree_file
    echo '   :maxdepth: 2'                                     >> $sub_toctree_file
    echo "   :caption: $PROJECT_NAME_CAMEL $rootless_path"     >> $sub_toctree_file
    echo                                                       >> $sub_toctree_file
  else
    echo
    echo "Altering existing tracked toctree file $sub_toctree_file"
  fi

  for rstfile in "${sorted_files[@]}"; do
    rstbase="$(basename $rstfile)"
    title="$(fn_title $title)"
    
    if [ "$path" == "${rst2ppath[$rstfile]}" ]; then
      entry='   '$title' <'$PROJECT_NAME/$rstbase'>'
      found=$(cat $sub_toctree_file | grep "$entry")

      if [ -z "$found" ]; then
        echo "$entry" >> $sub_toctree_file
      else
        echo "[WARN] Entry '$entry' already found in file $sub_toctree_file"
      fi
    fi
  done

  # last line in sub toctree file for the items
  echo              >> $sub_toctree_file

  # now add the sub toctree file as an entry into the project toctree file
  entry='   '$rootless_path' <'$sub_toctree_file'>'
  found=$(cat $toctree_file | grep "$entry")

  if [ -z "$found" ]; then
    echo "$entry" >> $toctree_file 
  else
    echo "[WARN] Entry '$entry' already found in file $toctree_file"
  fi
done
