#!/bin/bash

for gdoc in `find . -type f -regex '.*\.docx'`; do
  mdfile="$(echo $gdoc | sed -e 's/\.docx$/\.md/')"
  echo "Converting $gdoc to markdown ..."
  cat > "$mdfile" <<-EOF
<!--
ORIGIN: gdocs
DATE: $(date)
-->
EOF
  w2m "$gdoc" >> "$mdfile"
done

