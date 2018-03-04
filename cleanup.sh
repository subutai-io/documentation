#!/bin/bash

. /readthedocs/functions.sh

rm -f index.rst

# does not work in the submodules need to do this again
# inside each submodule below to get the proper results
for docfile in `find . -type f -regex '.*\.\(rst\|md\)$'`; do
  git_clean "$docfile"
done

# if user asks delete all gdocs files: don't want to download all the time
if [ "$1" == "gdocs" ]; then
  gdocs_clean
fi

for md in `find . -type f -regex '.*\.md'`; do
  if [ -n "$(tail -n 5 $md | grep ORIGIN | grep gdocs)" ]; then
    debug "Removing generated Markdown file $md"
    rm "$md"
  fi
done

git checkout /readthedocs/Products

cd Projects
for proj_dir in `find /readthedocs/Projects -type d`; do
  if [ "$proj_dir" == "/readthedocs/Projects" ]; then
    continue;
  fi

  proj_name="$(basename $proj_dir)"
  echo [DEBUG] proj_name = $proj_name
  cd $proj_dir
  for docfile in `find . -type f -regex '.*\.\(rst\|md\)$'`; do
    git_clean "$docfile"
  done
  cd ..
done
cd /readthedocs