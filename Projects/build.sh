#!/bin/bash

for proj_dir in `find /readthedocs/Projects -type d`; do
  if [ "$proj_dir" == "/readthedocs/Projects" ]; then
    continue;
  fi

  proj_name="$(basename $proj_dir)"
  echo "project dir  = $proj_dir"
  echo "project name = $proj_name"

  ./toctree.sh $proj_name
done
