#!/bin/bash

jq -c '.[]' modules.json | while IFS='' read -r module;do
	name=$(echo "$module" | jq -r '.name')
	setup_command=$(echo "$module" | jq -r '.setup')
	[[ "$setup_command" == "null" ]] && continue
	echo "Executing setup command for $name."
	sh -c "$setup_command"
done
