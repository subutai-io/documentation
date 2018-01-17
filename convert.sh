#!/bin/bash

for gdoc in "`find . -type f -regex '.*\.docx'`"; do
  echo "gdoc = $gdoc"
  mdfile="$(echo $gdoc | sed -e 's/\.docx$/\.md/')"
  echo "w2m $gdoc"' > '$mdfile
done

