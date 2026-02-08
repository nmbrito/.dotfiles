#!/bin/sh

# Add and comment individual files
for file in $(git status --porcelain | cut -b 4-); do
    printf '%s\n' "$file"
    git add "$(git rev-parse --show-toplevel)/${file}"
    printf '%s' "Enter comment: "
    read -r comments
    git commit -m "$comments"
done
git push
