#!/bin/sh

# Add and comment all files
for file in $(git status --porcelain | cut -b 4-); do
    printf '%s\n' "$file"
    git add "$(git rev-parse --show-toplevel)/${file}"
    git commit -m "Updated ${file}."
done
git push
