#!/bin/bash

rm -rf configs
mkdir configs

for module in $(jq -c '.[]' modules.json)
do
	name=$(echo $module | jq -r '.name')
	source_path_string=$(echo $module | jq -r '.path')
	source_path=${source_path_string/#~/$HOME}
	if [ -d $source_path ]; then
		echo "dir"
	else
		echo "file"
	fi
done
