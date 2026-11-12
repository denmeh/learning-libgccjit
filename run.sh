#!/usr/bin/env bash
set -euo pipefail

project_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
cd "$project_dir"

sources=( *.c )
if [[ ! -e "${sources[0]}" ]]; then
    echo "No C source files found in $project_dir" >&2
    exit 1
fi

if (( $# > 1 )); then
    echo "Usage: $0 [source-name]" >&2
    exit 2
fi

if (( $# == 1 )); then
    selected="$1"
    selected="${selected%.c}"
    source=""
    for candidate in "${sources[@]}"; do
        if [[ "${candidate%.c}" == "$selected" ]]; then
            source="$candidate"
            break
        fi
    done
    if [[ -z "$source" ]]; then
        echo "Unknown source '$1'. Available: ${sources[*]}" >&2
        exit 2
    fi
else
    echo "Choose a C example:"
    for i in "${!sources[@]}"; do
        printf '  %d) %s\n' "$((i + 1))" "${sources[$i]}"
    done
    read -r -p "> " choice
    if [[ ! "$choice" =~ ^[0-9]+$ ]] || (( choice < 1 || choice > ${#sources[@]} )); then
        echo "Invalid selection" >&2
        exit 2
    fi
    source="${sources[$((choice - 1))]}"
fi

mkdir -p build
program="build/${source%.c}"
compiler="${CC:-gcc}"
echo "Compiling $source..."
"$compiler" "$source" -o "$program" -lgccjit
echo "Running ${source%.c}..."
exec "$project_dir/$program"
