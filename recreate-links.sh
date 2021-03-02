#!/bin/bash

rm -rf configs
mkdir configs

for module in $(jq -c '.[]' modules.json)
do
	name="$(echo "$module" | jq '.name')"
	source_path="$(echo "$module" | jq '.path')"
	echo "$name $source_path"
done
