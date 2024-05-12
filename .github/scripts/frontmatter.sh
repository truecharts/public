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
if ! head -n 1 "$file_path" | grep -q "^---$"; then
  echo "Front matter (start) not found, adding it"
  # Dont trace content, as its usually too large
  [ "$DEBUG" == "true" ] && set +x
  (echo -e "---\n---\n"; cat "$file_path") >"$file_path.tmp" && mv "$file_path.tmp" "$file_path"
  [ "$DEBUG" == "true" ] && set -x
fi

wc -l $file_path
cat $file_path

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
