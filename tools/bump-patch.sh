#!/usr/bin/env bash
set -eu

# This script requires pyBump to be installed using pip.

for train in stable incubator develop non-free deprecated; do
  for chart in charts/${train}/*; do
    if [ -d "${chart}" ]; then
      echo "Bumping patch version for ${train}/${chart}"
      pybump bump --file ${chart}/Chart.yaml --level patch
    fi
  done
done
