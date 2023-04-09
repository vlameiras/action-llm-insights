#!/bin/bash

latest_commit=$(git rev-parse HEAD)
# Stash changes not staged for commit, so that we only analyze staged changes
# Get the diff and file contents
diff_output=$(git diff "$latest_commit" HEAD)
changed_files=$(git diff --cached --name-only)

file_contents=""
for file in $changed_files; do
    if [ -f "$file" ]; then
        content=$(cat "$file")
        file_contents+=$"==== File: ${file} ====\n${content}\n\n"
    fi
done

# Get insights and fixes from LLM
echo "Running LLM..."

insights=$(python llm_insights.py "$diff_output" "$file_contents")
echo "$insights"

IFS='
'
read -ra ADDR <<< "$insights"
bug_detected=0
for i in "${ADDR[@]}"; do
    if echo "$i" | grep -q -i "fix:"; then
        bug_detected=1
        fix_cmd=$(echo "$i" | sed -n -e 's/^.*fix: //p')
        echo "Applying fix: $fix_cmd"
        eval "$fix_cmd"
    else
        echo "$i"
    fi
done

if [ $bug_detected -eq 1 ]; then
    echo "Bugs detected and fixed. Please review the changes and stage them before committing."
    exit 1
fi