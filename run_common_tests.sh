#!/bin/bash
# https://github.com/quintush/helm-unittest

# -- You need to install this helm plugin
# helm plugin install https://github.com/quintush/helm-unittest
curr_dir=${pwd}

common_test_path="library/common-test"

echo "Cleaning old built charts..."
rm -r "$common_test_path/charts"

echo "Building common..."
helm dependency update "$common_test_path"
echo "Running tests..."
cd "$common_test_path"
helm unittest --helm3 -f "tests/*/*.yaml" .
cd "$curr_dir"
