#!/bin/bash

# delete all rst files not tracked in git
for rstfile in `find . -type f -regex '.*\.rst$'`; do
  git status -s $rstfile
  if [ -n "$(git status -s $rstfile | grep '^??')" ]; then
    echo "Deleting untracked (generated) restructuredText file: $rstfile"
    rm $rstfile
  else
    echo "Skipping git tracked restructuredText file: $rstfile"
  fi
done

# if user asks delete all gdocs files: don't want to download all the time
if [ "$1" == "gdocs" ]; then
  echo 'Deleting all gdocs (docx files), you will need to download again.'
  find . -type f -regex '.*\.docx$' | xargs rm
fi

# 3. do a git checkout to refresh changed files in git
git checkout /readthedocs/Products

