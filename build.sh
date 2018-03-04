#!/bin/bash

cd /readthedocs
. ./functions.sh

if [ "$1" == "nodownload" ]; then
  info "Skipping Google Drive downloads: nodownload argument provided."
  ./cleanup.sh
else
  ./cleanup.sh gdocs
  ./download.sh
fi 

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
  # w2m "$gdocfile" > "$mdfile"
  pandoc --from docx --to rst "$gdocfile" -o "$rstfile.tmp"
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

cd /readthedocs/_build/html
for html in `find . -type f -regex '.*\.html'`; do
  cat "$html" | sed -e 's@<img @<img class="img-responsive" @' > "$html.tmp";
  cp -f "$html.tmp" "$html"
  rm "$html.tmp" 
done
