#!/bin/bash

output_file="../data/weblogs/weblogs.log"

#if [ -f "$output_file" ]; then
#  rm $output_file
#else
#  echo "clickstream data will be writte to $output_file ..."
#fi

./generate-clickstream-data.sh $1 > $output_file
