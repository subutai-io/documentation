#!/bin/bash

rm index.rst

find . -type f -regex '.*\.docx' | xargs rm
for md in `find . -type f -regex '.*\.md'`; do
  if [ -n "$(tail -n 3 $md | grep ORIGIN | grep gdocs)" ]; then
    echo "Removing generated Markdown file $md"
    rm "$md"
  fi
done
