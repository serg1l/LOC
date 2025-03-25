#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

files="${1:-$(pwd)}"
count=0

process_dir(){
    local current="${1}"

    for file in "$current"/*; do
        if [ -f "$file" ]; then
            lines=$(bat < "$file" | wc -l)
            count=$((count + lines))
	    echo "$file lines: $lines"
        elif [ -d "$file" ]; then
		echo $'\nentering in subdirectory' "$file"
	    echo "--------------"
            process_dir "$file"
        fi
    done
}

process_dir "$files"

echo "---------------"
echo "total: $count"
