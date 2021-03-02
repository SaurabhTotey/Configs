#!/bin/bash

rm -rf configs
mkdir configs

for module in $(jq -c '.[]' modules.json)
do
	name=$(echo $module | jq -r '.name')
	source_path_string=$(echo $module | jq -r '.path')
	source_path=${source_path_string/#~/$HOME}
	target_path=configs/$name
	if [ -d $source_path ]; then
		ln -s $source_path $target_path
	else
		mkdir $target_path
		let file_name=${source_path##*/}
		ln -s $source_path $target_path/$file_name
	fi
done
