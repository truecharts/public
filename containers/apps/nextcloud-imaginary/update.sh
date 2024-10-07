#!/bin/bash
curr_dir="$1"

curr_commit="$(cat "$curr_dir/Dockerfile" | grep "go install github.com/h2non/imaginary" | sed -e 's/^[[:space:]]*//' | cut -d ' ' -f3 | cut -d '@' -f2)"
imaginary_commit="$(git ls-remote https://github.com/h2non/imaginary.git refs/heads/master | cut -f1)"

if [ "$imaginary_commit" = "$curr_commit" ]; then
  echo 'Already up-to-date'
  exit 0
fi

echo "Updating imaginary commit: $imaginary_commit"

sed -re 's/^(.*)go install github.com\/h2non\/imaginary@.+$/\1go install github.com\/h2non\/imaginary@'"$imaginary_commit"'/;' -i "$curr_dir/Dockerfile"

echo 'Updated Dockerfile:'
echo ''
cat "$curr_dir/Dockerfile"
