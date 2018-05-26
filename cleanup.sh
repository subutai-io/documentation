#!/bin/bash

. /readthedocs/functions.sh

# top level index.rst is generated
rm -f index.rst

# git restore or remove each rst file in the top level
find . -type f -regex '.*\.\(rst\)$' | while read -r docfile; do 
  git_clean "$docfile"
done

# checkout everything that might have been modified
git checkout /readthedocs/Products

# descend into Projects directories and clean up
cd Projects
for proj_dir in `find /readthedocs/Projects -type d`; do
  if [ "$proj_dir" == "/readthedocs/Projects" ]; then
    continue;
  fi

  proj_name="$(basename $proj_dir)"
  debug proj_name = $proj_name
  cd $proj_dir
  for docfile in `find . -type f -regex '.*\.\(rst\)$'`; do
    git_clean "$docfile"
  done
  cd ..
done

# descend into Blueprints directories and clean up
cd Blueprints
for bp_dir in `find /readthedocs/Blueprints -type d`; do
  if [ "$bp_dir" == "/readthedocs/Blueprints" ]; then
    continue;
  fi

  bp_name="$(basename $bp_dir)"
  debug bp_name = $bp_name
  cd $bp_dir
  for docfile in `find . -type f -regex '.*\.\(rst\)$'`; do
    git_clean "$docfile"
  done
  cd ..
done

cd /readthedocs