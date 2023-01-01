#!/bin/bash
# set -x
set -e

array_common=(1,2,3,4,5)
declare -A array_map
array_map["cpp"]="c++"
array_map["java"]="java"
for val in $array_common
do
echo $val
done