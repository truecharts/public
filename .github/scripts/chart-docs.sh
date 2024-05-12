#!/bin/bash
[ "$DEBUG" == 'true' ] && set -x
[ "$STRICT" == 'true' ] && set -e

make_sure_structure_is_there() {
  local train="$1"
  local chart="$2"

  mkdir -p tmp/website/src/content/docs/charts/${train}/${chart} || echo "chart path already exists, continuing..."

  echo "Checking if website/src/content/docs/charts/${train}/${chart}/CHANGELOG.md exists"
  if [ -f "website/src/content/docs/charts/${train}/${chart}/CHANGELOG.md" ]; then
    echo "CHANGELOG.md already exists, continuing..."
    return 0
  fi

  mkdir -p "website/src/content/docs/charts/${train}/${chart}" || echo "chart path already exists, continuing..."
  touch "website/src/content/docs/charts/${train}/${chart}/CHANGELOG.md"
}

keep_safe_docs() {
  local train="$1"
  local chart="$2"

  echo "Keeping some docs safe..."
  mv -f website/src/content/docs/charts/${train}/${chart}/CHANGELOG.md tmp/website/src/content/docs/charts/${train}/${chart}/CHANGELOG.md || :
}

remove_old_docs() {
  local train="$1"
  local chart="$2"

  echo "Removing old docs and recreating based on charts repo..."
  rm -rf website/src/content/docs/charts/*/${chart} || :
  mkdir -p website/src/content/docs/charts/${train}/${chart} || echo "chart path already exists, continuing..."
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

copy_safe_docs() {
  local train="$1"
  local chart="$2"

  echo "copying safe docs to website for ${chart}"
  cp -rf tmp/website/src/content/docs/charts/${train}/${chart}/* website/src/content/docs/charts/${train}/${chart}/ 2>/dev/null || :
}

append_scale_changelog() {
  local train="$1"
  local chart="$2"

  echo "appending SCALE changelog to actual changelog..."
  # Remove header from changelog
  sed -i '/^---$/,/^---$/d' "website/src/content/docs/charts/${train}/${chart}/CHANGELOG.md"
  # Prepend app-changelog to changelog
  cat "charts/${train}/${chart}/app-changelog.md" |
    cat - "website/src/content/docs/charts/${train}/${chart}/CHANGELOG.md" >temp &&
    mv temp "website/src/content/docs/charts/${train}/${chart}/CHANGELOG.md"

  echo "Adding changelog header..."
  ./.github/scripts/frontmatter.sh "website/src/content/docs/charts/${train}/${chart}/CHANGELOG.md"
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

  local index_path="website/src/content/docs/charts/${train}/${chart}/index.md"
  local chart_yaml_path="charts/${train}/${chart}/Chart.yaml"

  echo "Creating index.md..."
  touch website/src/content/docs/charts/${train}/${chart}/index.md

  echo "Adding front matter to index.md..."
  echo "---" >>${index_path}
  yq -i --front-matter=process '.title="'${chart}'"' ${index_path}
  echo -e "---\n" >>${index_path}

  echo "Getting data from Chart.yaml..."
  version=$(yq '.version' ${chart_yaml_path})
  appversion=$(yq '.appVersion' ${chart_yaml_path})
  description=$(yq -r '.description' ${chart_yaml_path})
  sources=$(yq -r '.sources' ${chart_yaml_path})

  echo "Adding the data to the index.md file..."
  echo '![Version: '"${version}"'](https://img.shields.io/badge/Version-'"${version}"'-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: '"${appversion}"'](https://img.shields.io/badge/AppVersion-'"${appversion}"'-informational?style=flat-square)' >>${index_path}

  echo "" >>${index_path}
  echo -e "$description\n" >>${index_path}
  echo -e "## Chart Sources\n" >>${index_path}
  echo -e "$sources\n" >>${index_path}
  echo -e "## Available Documentation\n" >>${index_path}

  echo "Iterating over all files in the docs directory..."
  for file in website/src/content/docs/charts/${train}/${chart}/*.md*; do
    echo "Checking file: ${file}"
    filename=$(basename "${file}")

    # If title is not ok, skip
    if ! check_and_fix_title "${file}"; then
      continue
    fi

    # If file is index.md, skip
    if [ "${filename}" == "index.md" ]; then
      continue
    fi

    title=$(yq --front-matter=process '.title' ${file} | head -n 1)
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
  echo -e "## Readme Content\n" >>website/src/content/docs/charts/${train}/${chart}/index.md
  tail -n +4 "charts/${train}/${chart}/README.md" >>website/src/content/docs/charts/${train}/${chart}/readmetmp.md
  sed -i 's/##/###/' "website/src/content/docs/charts/${train}/${chart}/readmetmp.md"
  cat "website/src/content/docs/charts/${train}/${chart}/readmetmp.md" >>"website/src/content/docs/charts/${train}/${chart}/index.md"
  rm "website/src/content/docs/charts/${train}/${chart}/readmetmp.md" || echo "couldnt delete readmetmp.md"

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

  make_sure_structure_is_there "$train" "$chart"
  keep_safe_docs "$train" "$chart"
  remove_old_docs "$train" "$chart"
  copy_new_docs "$train" "$chart"
  copy_safe_docs "$train" "$chart"
  append_scale_changelog "$train" "$chart"
  ./.github/scripts/frontmatter.sh "website/src/content/docs/charts/${train}/${chart}/CHANGELOG.md"
  process_index "$train" "$chart"

  echo "Finished processing ${chart}"
}

main "$1"
