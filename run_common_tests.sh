#!/bin/bash
# https://github.com/quintush/helm-unittest

# -- You need to install this helm plugin
# helm plugin install https://github.com/quintush/helm-unittest
curr_dir=${pwd}

common_test_path="library/common-test"

echo "Building common..."
helm dependency build "$common_test_path"
echo "Running tests..."
cd "$common_test_path"
helm unittest --helm3 -f "tests/*/*.yaml" .
cd "$curr_dir"
