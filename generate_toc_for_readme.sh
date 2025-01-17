#!/bin/bash

generate_toc() {
    local dir=$1
    local base_dir=$(pwd)

    for file in "$dir"/*; do
        if [ -d "$file" ]; then
            local dir_name=$(basename "$file")
            echo "- $dir_name"
            echo "  $(generate_toc "$file")"
        elif [ -f "$file" ] && [[ $file == *.md ]]; then
            local title=$(basename "$file" .md)
            local link=$(echo "$file" | sed "s|^$base_dir/||")
            local encoded_link=$(python -c "import urllib.parse; print(urllib.parse.quote('''$link'''))")
            echo "  - [$title]($encoded_link)"
        fi
    done
}

generate_toc .