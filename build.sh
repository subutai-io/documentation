#!/bin/bash

pushd .

cd /readthedocs
./download.sh

cd /readthedocs/Products
./build.sh

cd /readthedocs/Projects
./build.sh

cd /readthedocs
make clean
make html

popd

