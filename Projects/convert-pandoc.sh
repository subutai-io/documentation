#!/bin/bash

PROJECTS=/readthedocs/Projects
PROJECT_NAME="$1"
PROJECT_DIR="$PROJECTS/$PROJECT_NAME"

if [ -z "$PROJECT_NAME" ]; then
  echo "[ERROR] Missing project name argument. Exiting with non-zero status."
  echo
  echo "Usage: $0 <project_name>"
  echo
  exit 1
fi
  
for mdfile in `find $PROJECT_DIR -type f -regex '.*\.md'`; do
  mdbase="$(basename $mdfile)"
  rstfile="$(echo $mdfile | sed -e 's/\.md$/\.rst/')"
  pandoc --from markdown --to rst $mdfile -o $rstfile
done

