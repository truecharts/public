#!/usr/bin/env bash
set -eu

# This script requires pyBump to be installed using pip.

for train in stable incubator develop non-free deprecated; do
  for chart in charts/${train}/*; do
    if [ -d "${chart}" ]; then
      echo "merging item.yaml into chart.yaml"
      cat ${chart}/SCALE/item.yaml >>  ${chart}/chart.yaml
    fi
  done
done
