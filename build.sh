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

cd /readthedocs
./download.sh

cd /readthedocs/Products
./build.sh

cd /readthedocs/Projects
./build.sh

cd /readthedocs

#
# Build the main index.rst file
#

cat > ./index.rst <<-EOF
Subutai Documentation
=====================

Join the Subutai Horde! Be part of the P2P Cloud Crowd.

.. _1:

.. toctree::
   :maxdepth: 2
   :caption: General

EOF

declare -a sorted_files
for gdocfile in `find . -maxdepth 1 -type f -regex '.*\.docx'`; do
  gdocbase="$(basename $gdocfile)"
  rstfile="$(echo $gdocfile | sed -e 's/\.docx$/\.rst/')"
  mdfile="$(echo $gdocfile | sed -e 's/\.docx$/\.md/')"
  rstbase="$(basename $rstfile)"
  title="$(fn_title $rstfile)"
  echo "[DEBUG] title = $title"

  fn_header "$title" > $rstfile
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

  entry='   '$title' <'$rstbase'>'
  found=$(cat index.rst | grep "$entry")

  if [ -z "$found" ]; then
    echo "$entry" >> index.rst
  else
    echo "[WARN] Entry '$entry' already found in file index.rst"
  fi
done

cat ./index_body >> ./index.rst
make clean
make html

