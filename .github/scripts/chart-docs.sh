#!/bin/bash
[ "$DEBUG" == 'true' ] && set -x
[ "$STRICT" == 'true' ] && set -e

docs_base="website/src/content/docs/charts"
tmp_docs_base="tmpwebsite/src/content/docs/charts"
safe_docs=(
  "CHANGELOG.md"
)

keep_docs_safe() {
  local train="$1"
  local chart="$2"

  mkdir -p "$tmp_docs_base/${train}/${chart}"
  echo "Keeping some docs safe..."
  for doc in "${safe_docs[@]}"; do
    if [ ! -f "$docs_base/${train}/${chart}/${doc}" ]; then
      echo "Doc [$doc] does not exist, cannot keep it safe. Skipping."
      continue
    fi
    mv "$docs_base/${train}/${chart}/${doc}" "$tmp_docs_base/${train}/${chart}/${doc}"
  done
}

restore_safe_docs() {
  local train="$1"
  local chart="$2"

  echo "Restoring safe docs..."
  for doc in "${safe_docs[@]}"; do
    if [ ! -f "$tmp_docs_base/${train}/${chart}/${doc}" ]; then
      echo "Doc [$doc] does not exist, cannot restore it. Skipping."
      continue
    fi
    mv "$tmp_docs_base/${train}/${chart}/${doc}" "$docs_base/${train}/${chart}/${doc}"
  done
}

remove_old_docs() {
  local train="$1"
  local chart="$2"

  echo "Removing old docs and recreating based on website repo..."
  rm -rf $docs_base/*/${chart} || :
  mkdir -p $docs_base/${train}/${chart} || echo "chart path already exists, continuing..."
}

copy_new_docs() {
  local $train="$1"
  local chart="$2"

  echo "copying new docs to website for ${chart}"
  cp -rf charts/${train}/${chart}/docs/* website/src/content/docs/charts/${train}/${chart}/ 2>/dev/null || :
  cp -rf charts/${train}/${chart}/icon.webp website/public/img/hotlink-ok/chart-icons/${chart}.webp 2>/dev/null || :
  cp -rf charts/${train}/${chart}/icon-small.webp website/public/img/hotlink-ok/chart-icons-small/${chart}.webp 2>/dev/null || :
  cp -rf charts/${train}/${chart}/screenshots/* website/public/img/hotlink-ok/chart-screenshots/${chart}/ 2>/dev/null || :
}

check_and_fix_title() {
  local file="$1"

  echo "Checking title..."

  ok_title="false"
  echo "Getting the first line"
  if grep -q "^---$" "${file}"; then
    ok_title="true"
  elif grep -q "^# " "${file}"; then
    echo "Found old-style title, fixing..."
    title=$(grep "^# " "${file}" | cut -d " " -f 2-)
    # Remove title
    sed -i "s/^# ${title}//" "${file}"
    content=$(cat "${file}")
    echo -e "---\ntitle: ${title}\n---\n${content}" >"${file}"
    ok_title="true"
  else
    ok_title="false"
  fi

  if [ ${ok_title} == "false" ]; then
    echo "Doc title should use front matter and not # for title, for example"
    echo "---"
    echo "title: some title"
    echo "---"
    return 1
  fi

  echo "Title is ok"

  return 0
}

process_index() {
  local train="$1"
  local chart="$2"

  local index_path="$docs_base/${train}/${chart}/index.md"
  local chart_yaml_path="charts/${train}/${chart}/Chart.yaml"

  echo "Creating index.md..."
  touch $docs_base/${train}/${chart}/index.md

  echo "Adding front matter to index.md..."
  echo "---" >>${index_path}
  go-yq -i --front-matter=process '.title="'${chart}'"' ${index_path}
  echo -e "---\n" >>${index_path}

  echo "Getting data from Chart.yaml..."
  version=$(go-yq '.version' ${chart_yaml_path})
  appversion=$(go-yq '.appVersion' ${chart_yaml_path})
  description=$(go-yq -r '.description' ${chart_yaml_path})
  sources=$(go-yq -r '.sources' ${chart_yaml_path})

  echo "Adding the data to the index.md file..."
  echo '![Version: '"${version}"'](https://img.shields.io/badge/Version-'"${version}"'-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: '"${appversion}"'](https://img.shields.io/badge/AppVersion-'"${appversion}"'-informational?style=flat-square)' >>${index_path}

  echo "" >>${index_path}
  echo -e "$description\n" >>${index_path}
  echo -e "## Chart Sources\n" >>${index_path}
  echo -e "$sources\n" >>${index_path}
  echo -e "## Available Documentation\n" >>${index_path}

  echo "Iterating over all files in the docs directory..."
  for f in $docs_base/${train}/${chart}/*.md*; do
    echo "Checking file: ${f}"
    filename=$(basename "${f}")

    # If title is not ok, skip
    if ! check_and_fix_title "${f}"; then
      echo "Title is not ok, skipping..."
      continue
    fi

    # If file is index.md, skip
    if [ "${filename}" == "index.md" ]; then
      echo "File is index.md, not adding it to the links"
      continue
    fi

    title=$(go-yq --front-matter=process '.title' ${f} | head -n 1)
    echo "The title is: ${title}"

    echo "Generating markdown links"

    filename="${filename##*/}"
    filenameURL=${filename%.*}
    filenameURL=${filenameURL,,}
    link="[**${title}**](./${filenameURL})"
    echo "The link is: ${link}"
    echo "- ${link}" >>${index_path}
  done
  echo "" >>${index_path}
  echo "" >>${index_path}
  echo "---" >>${index_path}
  echo "" >>${index_path}
  echo -e "## Readme\n" >>$docs_base/${train}/${chart}/index.md
  tail -n +4 "charts/${train}/${chart}/README.md" >>$docs_base/${train}/${chart}/readmetmp.md
  sed -i 's/##/###/' "$docs_base/${train}/${chart}/readmetmp.md"
  cat "$docs_base/${train}/${chart}/readmetmp.md" >>"$docs_base/${train}/${chart}/index.md"
  rm "$docs_base/${train}/${chart}/readmetmp.md" || echo "couldnt delete readmetmp.md"

}

main() {
  local chart_path="$1"

  IFS='/' read -r -a chart_parts <<<"$chart_path"
  train=${chart_parts[0]}
  chart=${chart_parts[1]}

  if [ ! -f "charts/${train}"/"${chart}/Chart.yaml" ]; then
    echo "chart path does not exist, skipping..."
    continue
  fi

  echo "copying docs to website for ${chart}"

  keep_docs_safe "$train" "$chart"
  remove_old_docs "$train" "$chart"
  copy_new_docs "$train" "$chart"
  process_index "$train" "$chart"
  restore_safe_docs "$train" "$chart"

  echo "Finished processing ${chart}"
}

main "$1"
