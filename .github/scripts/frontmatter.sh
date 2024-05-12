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

# if file is empty
if [ -z "$(cat "$file_path")" ]; then
  echo -e "---\n" >"$file_path"
  echo -e "---\n" >>"$file_path"
fi

echo "Checking front matter"
if ! grep -q "^---$" "$file_path"; then
  echo "Front matter (start) not found, adding it"
  echo -e "---\n" >"$file_path"
  echo "$(cat "$file_path")" >>"$file_path"
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

frontmatter=$($base_cmd '.' "$file_path")
# Check if the front matter does end with ---
if [ "${frontmatter: -3}" != "---" ]; then
  echo "Front matter (end) not found, adding it"
  echo -e "\n---\n" >>"$file_path"
fi
