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
  local no_ext_no_prefix=$(echo "$file" | sed -e 's/\.[^.]*$//' -e 's/^[0-9]*_//')
  local w_spaces=$(echo "$no_ext_no_prefix" | sed 's/-\|_/ /g')
  local camel=$(fn_camel "$w_spaces")
  echo "$camel"
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

PRODUCTS=/readthedocs/Products
PRODUCT_NAME="$1"
PRODUCT_DIR="$PRODUCTS/$PRODUCT_NAME"
toctree_file="$PRODUCT_NAME"'_toctree.rst'

if [ -z "$PRODUCT_NAME" ]; then
  echo "[ERROR] Missing product name argument. Exiting with non-zero status."
  echo
  echo "Usage: $0 <product_name>"
  echo
  exit 1
fi

PRODUCT_NAME_CAMEL="$(head -n 1 $toctree_file | sed 's/\n//')"
echo "[DEBUG] PRODUCT_NAME_CAMEL = $PRODUCT_NAME_CAMEL"

if [ -n "$(git status -s . | grep '^??' | grep $toctree_file)" ]; then
  echo
  echo "Generating untracked toctree file $toctree_file"     
  
                                                        # NOTE: > new file
  echo                                                          > $toctree_file

  # Need this to be an h1 header
  fn_header "$PRODUCT_NAME_CAMEL"                              >> $toctree_file

  echo                                                         >> $toctree_file
  echo '.. toctree::'                                          >> $toctree_file
  echo '   :maxdepth: 2'                                       >> $toctree_file
  echo "   :caption: $PRODUCT_NAME_CAMEL"                      >> $toctree_file
  echo                                                         >> $toctree_file
else
  echo
  echo "Altering existing tracked toctree file $toctree_file"
fi

echo "Processing entries first in $PRODUCT_DIR:"

declare -a sorted_files
for gdocfile in `find $PRODUCT_DIR -type f -regex '.*\.docx'`; do
  gdocbase="$(basename $gdocfile)"
  rstfile="$(echo $gdocfile | sed -e 's/\.docx$/\.rst/')"
  mdfile="$(echo $gdocfile | sed -e 's/\.docx$/\.md/')"
  rstbase="$(basename $rstfile)"
  title="$(fn_title $rstfile)"
  echo "[DEBUG] title = $title"

  echo "$(fn_header $title)" > $rstfile
  w2m "$gdocfile" > "$mdfile"
  pandoc --from markdown --to rst $mdfile -o $rstfile.tmp
  cat $rstfile.tmp >> $rstfile
  rm $rstfile.tmp
  sorted_files+=("$rstfile")
done

IFS=$'\n' sorted_files=($(sort <<<"${sorted_files[*]}"))
echo "Sorted rst files = ${sorted_files[@]}"

# Now use the sorted files to iterate in sorted order through collected
# rstfiles and add to the TOC with titles.
for rstfile in "${sorted_files[@]}"; do
  rstbase="$(basename $rstfile)"
  title="$(fn_title $rstfile)"

  entry='   '$title' <'$PRODUCT_NAME/$rstbase'>'
  found=$(cat $toctree_file | grep "$entry")

  if [ -z "$found" ]; then
    echo "$entry" >> $toctree_file
  else
    echo "[WARN] Entry '$entry' already found in file $toctree_file"
  fi
done

