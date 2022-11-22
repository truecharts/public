#!/bin/bash

chart_path=library/common-test

if [ -d "$chart_path/charts" ]; then
  echo "Cleaning old built charts..."
  rm -r "$chart_path/charts"
  rm  "$chart_path/Chart.lock"
fi

echo "Building common..."
helm dependency update "$chart_path"

helm template --debug "./$chart_path"
helm lint "./$chart_path"
