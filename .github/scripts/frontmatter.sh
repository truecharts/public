#!/bin/bash
[ "$DEBUG" == 'true' ] && set -x
[ "$STRICT" == 'true' ] && set -e

file_path="$1"
base_cmd="go-yq --front-matter=process"
# Check if the file has valid front matter

is_empty() {
  if $(echo "$1" | grep -q "^null$"); then
    return 0
  fi

  return 1
}

is_true() {
  if $(echo "$1" | grep -q "^true$"); then
    return 0
  fi

  return 1
}

echo "Checking front matter"
if ! grep -q "^---$" "$file_path"; then
  echo "Front matter (start) not found, adding it"
  content=$(cat "$file_path")
  echo -e "---\n" >"$file_path"
  echo -e "---\n" >>"$file_path"
  echo "$content" >>"$file_path"
fi

# Get the title from the front matter
echo "Checking title"
title=$($base_cmd '.title' "$file_path")
# Check if the title is empty
if is_empty "$title"; then
  $base_cmd -i '.title="Changelog"' "$file_path"
fi

echo "Checking pagefind"
pagefind=$($base_cmd '.pagefind' "$file_path")
if is_empty "$pagefind" || is_true "$pagefind"; then
  $base_cmd -i '.pagefind=false' "$file_path"
fi
