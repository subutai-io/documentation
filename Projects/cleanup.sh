#!/bin/bash

for proj_dir in `find /readthedocs/Projects -type d`; do
  if [ "$proj_dir" == "/readthedocs/Projects" ]; then
    continue;
  fi

  proj_name="$(basename $proj_dir)"
  echo [DEBUG] proj_name = $proj_name
  cd $proj_dir
  git checkout .
  cd ..
done

# TODO check if it's committed, and if so just checkout removing edits
# TODO delete only ones that are generated and not committed 
# find $PROJECTS_DIR -type f -regex '.*\.rst' | xargs rm

