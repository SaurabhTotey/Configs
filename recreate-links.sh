#!/bin/bash

rm -rf configs
mkdir configs

for module in $(jq -c '.[]' modules.json)
do
	echo "$module"
done
