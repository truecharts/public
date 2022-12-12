#!/bin/bash

chart_path=library/common-test

if [ ! $1 == "template" ]; then
  if [ $1 == "-f" ] && [ ! -z $2 ]; then
    extra_args=("-f" "$chart_path/ci/$2")
  fi
fi

if [ -d "$chart_path/charts" ]; then
  echo "Cleaning old built charts..."
  rm -r "$chart_path/charts"
  rm  "$chart_path/Chart.lock"
fi

echo "Building common..."
helm dependency update "$chart_path"

if [ $1 == "template" ]; then
  echo "Running <helm template ./$chart_path"
  helm template "./$chart_path"
else
  echo "Running <helm install --dry-run --debug common-test ${extra_args[@]} ./$chart_path"
  helm install --dry-run --debug common-test "${extra_args[@]}" "./$chart_path"
fi
helm lint "./$chart_path"
