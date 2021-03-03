#!/bin/bash

for module in $(jq -c '.[]' modules.json)
do
	name=$(echo $module | jq -r '.name')
	source_path_string=$(echo $module | jq -r '.path')
	source_path=${source_path_string/#~/$HOME}
	target_path=configs/$name
	if [ -d $source_path ]; then
		echo "TODO"
	else
		echo "TODO"
	fi
done
