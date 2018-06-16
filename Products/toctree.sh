#!/bin/bash

. /readthedocs/functions.sh

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

if [ ! -f $toctree_file -o -n "$(git status -s . | grep '^??' | grep $toctree_file)" ]; then
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
for mdfile in `find $PRODUCT_DIR -type f -regex '.*\.md'`; do
  rstfile="$(convert_md $mdfile)"
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

