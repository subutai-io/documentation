#!/bin/bash

PROJECTS_DIR=/readthedocs/Projects

find $PROJECTS_DIR -type f -regex '.*\.rst' | xargs rm
