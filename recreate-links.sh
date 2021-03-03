#!/bin/bash

for module in $(jq -c '.[]' modules.json)
do
	name=$(echo $module | jq -r '.name')
	target_path=$(echo $module | jq -r '.path')
	target_path=${target_path/#~/$HOME}
	cd configs/$name
	for file_to_symlink in *; do
		echo $file_to_symlink
		#TODO: actually create the symlink
	done
	cd ../..
done
