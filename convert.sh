#!/bin/bash

for gdoc in `find . -type f -regex '.*\.docx'`; do
  mdfile="$(echo $gdoc | sed -e 's/\.docx$/\.md/')"
  echo "Converting $gdoc to markdown ..."
  w2m "$gdoc" > "$mdfile"

  if [ -z "$(head -n 1 $mdfile | egrep '^# ')" ]; then
    basefile="$(basename $mdfile)"
    title='# '"$(echo $basefile | sed -e 's/\.md//' -e 's/_/ /g')"
    echo "$title"  > "$mdfile.new"
    cat "$mdfile" >> "$mdfile.new"
    rm "$mdfile"
    mv "$mdfile.new" "$mdfile"
  fi

  cat >> "$mdfile" <<-EOF
<!--
ORIGIN: gdocs
DATE: $(date)
-->
EOF

done
