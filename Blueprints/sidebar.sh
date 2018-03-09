#!/bin/bash

. /readthedocs/functions.sh

BPS=/readthedocs/Blueprints
BP_NAME="$1"
BP_DIR="$BPS/$BP_NAME"

if [ -z "$BP_NAME" ]; then
  echo "[ERROR] Missing blueprint name argument. Exiting with non-zero status."
  echo
  echo "Usage: $0 <blueprint_name>"
  echo
  exit 1
fi

WIKI_URL=''
CONFIG_FILE="$(cat $BP_DIR/.git | awk -F':' '{print $2}' | sed -e 's/ //g' -e 's@\.\./@@' )/config"
GIT_URL="$(cat $CONFIG_FILE | egrep 'url = .*github.com.*\.wiki\.git$' | awk -F'=' '{print $2}' | sed -e 's/ //g')"
BP_URL="$(echo $GIT_URL | sed -e 's/\.wiki\.git$//')"
WIKI_URL="$BP_URL/wiki"

echo "[DEBUG] CONFIG_FILE = $CONFIG_FILE"
echo "[DEBUG] GIT_URL = $GIT_URL"
echo "[DEBUG] BP_URL = $BP_URL"
echo "[DEBUG] WIKI_URL = $WIKI_URL"

sidebar_base="_Sidebar.md"
sidebar_file="$BP_DIR/$sidebar_base"

declare -A uniq_paths
declare -A base2path
declare -A skipped
skipped=(
    [Home.md]=true
    [_Sidebar.md]=true
    [_Footer.md]=true
    [_Header.md]=true
    [$sidebar_base]=true
)

for mdfile in `find $BP_DIR -type f -regex '.*\.md'`; do
  mdbase="$(basename $mdfile)"

  # Skip files some wiki files
  if [ "${skipped[$mdbase]}" ]; then
    echo "[DEBUG] Skipping $mdfile"
    continue
  fi

  parent_path='/Uncategorized'
  if [ -n "$(tail -n 5 $mdfile | grep PARENT_PATH)" ]; then
    parent_path="$(tail -n 5 $mdfile | grep PARENT_PATH | awk -F':' '{print $2}' | sed -e 's/^ //g' -e 's/ $//g')"
  fi
  
  base2path+=([$mdbase]=$parent_path)

  if [ ! "${uniq_paths[$parent_path]}" ]; then
    uniq_paths+=([$parent_path]=true)
  fi

  echo "[DEBUG] $mdbase parent_path = $parent_path"
done

echo
echo "Generating sidebar file $sidebar_file"
echo > $sidebar_file

#
# ----------------------------------------------------------------------------
# Process the root entries
# ----------------------------------------------------------------------------
#

echo
echo "Processing / entries first:"
echo

declare -a sorted_bases
for base in "${!base2path[@]}"; do
  if [ "/" == "${base2path["$base"]}" ]; then
    sorted_bases+=($base)
  fi
done

IFS=$'\n' sorted_bases=($(sort <<<"${sorted_bases[*]}"))
echo "Sorted bases = ${sorted_bases[@]}"

for base in "${sorted_bases[@]}"; do
  no_ext="$(echo $base | sed -e 's/\.md$//')"
  title="$(echo $no_ext | sed -e 's/-/ /g')"
  encoded="$(urlencode $no_ext)"

  if [ "/" == "${base2path["$base"]}" ]; then
    entry='[**'$title'**]('$WIKI_URL/$encoded')'
    echo "$entry" >> $sidebar_file
    echo          >> $sidebar_file
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

  sorted_bases=()
  for base in "${!base2path[@]}"; do
    if [ "$path" == "${base2path["$base"]}" ]; then
      sorted_bases+=($base)
    fi
  done

  IFS=$'\n' sorted_bases=($(sort <<<"${sorted_bases[*]}"))
  echo "Sorted bases = ${sorted_bases[@]}"

  rootless_path="$(echo $path | sed -e 's@^/@@')"
  echo '<details><summary><a href='$WIKI_URL$path'><b>'$rootless_path'</b></a></summary>' >> $sidebar_file
  echo '   ' >> $sidebar_file

  for base in "${sorted_bases[@]}"; do
    no_ext="$(echo $base | sed -e 's/\.md$//')"
    title="$(echo $no_ext | sed -e 's/-/ /g')"
    encoded="$(urlencode $no_ext)"
    
    if [ "$path" == "${base2path[$base]}" ]; then
      entry='['$title']('$WIKI_URL/$encoded')'
      echo "   $entry    " >> $sidebar_file
      echo "[DEBUG] $base file matches path $path"
    fi
  done

  echo '</details>' >> $sidebar_file
  echo              >> $sidebar_file
done

