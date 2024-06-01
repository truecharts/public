#!/usr/bin/env bash
set -eu

## General file setup
# $1 bump type
# $2 path to chart if one chart only


## Function details
# $1 - semver string
# $2 - level to incr {patch,minor,major} - patch by default
function incr_semver() {
    IFS='.' read -ra ver <<< "$1"
    [[ "${#ver[@]}" -ne 3 ]] && echo "Invalid semver string" && return 1
    [[ "$#" -eq 1 ]] && level='patch' || level=$2

    patch=${ver[2]}
    minor=${ver[1]}
    major=${ver[0]}

    case $level in
        patch)
            patch=$((patch+1))
        ;;
        minor)
            patch=0
            minor=$((minor+1))
        ;;
        major)
            patch=0
            minor=0
            major=$((major+1))
        ;;
        *)
            echo "Invalid level passed"
            return 2
    esac
    echo "$major.$minor.$patch"
}

BUMPTYPE=${1}
if [ -z ${2+x} ]; then
for train in stable incubator games enterprise develop non-free deprecated dependency core; do
  for chart in charts/${train}/*; do
    if [ -d "${chart}" ]; then
      echo "Bumping version for ${train}/${chart}"
      OLDVER=$(cat ${chart}/Chart.yaml | grep "^version: ")
      OLDVER=${OLDVER#version: }
      NEWVER=$(incr_semver ${OLDVER} ${BUMPTYPE})
      sed -i "s|^version:.*|version: ${NEWVER}|g" ${chart}/Chart.yaml
    fi
  done
done
else
  chart=${2}
  if [ -d "${chart}" ]; then
    echo "Bumping version for ${chart}"
    OLDVER=$(cat ${chart}/Chart.yaml | grep "^version: ")
    OLDVER=${OLDVER#version: }
    NEWVER=$(incr_semver ${OLDVER} ${BUMPTYPE})
    sed -i "s|^version:.*|version: ${NEWVER}|g" ${chart}/Chart.yaml
  fi
fi
