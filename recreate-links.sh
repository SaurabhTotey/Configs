#!/bin/bash

for module in $(jq -c '.[]' modules.json)
do
	name=$(echo $module | jq -r '.name')
	target_path=$(echo $module | jq -r '.path')
	target_path=${target_path/#~/$HOME}
	cd configs/$name
	for file_to_symlink in *; do
		sudo ln -sf "$(pwd)/$file_to_symlink" $target_path
	done
	cd ../..
done
