#!/bin/bash
latest_commit=$(git rev-parse HEAD)

# Stash changes not staged for commit, so that we only analyze staged changes
# Get the diff and file contents
#diff_output=$(git diff "$latest_commit" HEAD)
changed_files=$(git diff --name-only "$latest_commit" HEAD)

file_contents=""
for file in $changed_files; do
    if [ -f "$file" ]; then
        content=$(cat "$file")
        file_contents+=$"==== File: ${file} ====\n${content}\n\n"
        ech $file_contents
    fi
done