#!/bin/bash

jq -c '.[]' modules.json | while IFS='' read -r module;do
	name=$(echo "$module" | jq -r '.name')
	target_path=$(echo "$module" | jq -r '.path')
	target_path=${target_path/#~/$HOME}
	cd configs/"$name" || exit
	shopt -s dotglob
	for file_to_symlink in *; do
		sudo ln -sf "$(pwd)/$file_to_symlink" "$target_path/$file_to_symlink"
	done
	shopt -u dotglob
	cd ../..
done
