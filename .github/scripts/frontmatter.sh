#!/bin/bash
[ "$DEBUG" == 'true' ] && set -x
[ "$STRICT" == 'true' ] && set -e

file_path="$1"
base_cmd="go-yq --front-matter=process"

echo "Checking front matter"
if ! head -n 1 "$file_path" | grep -q "^---$"; then
  echo "Front matter (start) not found, adding it"
  # Dont trace content, as its usually too large
  [ "$DEBUG" == "true" ] && set +x
  (echo -e "---\n---\n"; cat "$file_path") >"$file_path.tmp" && mv "$file_path.tmp" "$file_path"
  [ "$DEBUG" == "true" ] && set -x
fi

wc -l $file_path

# Get the title from the front matter
echo "Updating title"
$base_cmd -i '.title="Changelog"' "$file_path"

echo "Updating pagefind"
$base_cmd -i '.pagefind=false' "$file_path"
