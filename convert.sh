#!/bin/bash

for gdoc in `find . -type f -regex '.*\.docx'`; do
  mdfile="$(echo $gdoc | sed -e 's/\.docx$/\.md/')"
  rstfile="$(echo $gdoc | sed -e 's/\.docx$/\.rst/')"
  echo "Converting $gdoc to markdown ..."
  w2m "$gdoc" > "$mdfile"
  echo "Converting $gdoc to reStructuredText ..."
  w2m "$gdoc" > "$rstfile"

  if [ -z "$(head -n 1 $mdfile | egrep '^# ')" ]; then
    basefile="$(basename $mdfile)"
    title='# '"$(echo $basefile | sed -e 's/\.md//' -e 's/_/ /g')"
    echo "$title"  > "$mdfile.new"
    cat "$mdfile" >> "$mdfile.new"
    rm "$mdfile"
    mv "$mdfile.new" "$mdfile"
  fi
  if [ -z "$(head -n 1 $rstfile | egrep '^# ')" ]; then
    basefile="$(basename $rstfile)"
    title='# '"$(echo $basefile | sed -e 's/\.md//' -e 's/_/ /g')"
    echo "$title"  > "$rstfile.new"
    cat "$rstfile" >> "$rstfile.new"
    rm "$rstfile"
    mv "$rstfile.new" "$rstfile"
  fi

  cat >> "$mdfile" <<-EOF
<!--
ORIGIN: gdocs
DATE: $(date)
-->
EOF
  cat >> "$rstfile" <<-EOF
<!--
ORIGIN: gdocs
DATE: $(date)
-->
EOF

done
