#!/bin/bash
# https://github.com/quintush/helm-unittest

# -- You need to install this helm plugin
# helm plugin install https://github.com/quintush/helm-unittest

common_test_path="library/common-test"

function cleanup {
  if [ -d "$common_test_path/charts" ]; then
    echo "🧹 Cleaning up charts..."
    rm -r "$common_test_path/charts"
    rm  "$common_test_path/Chart.lock"
  fi
}

cleanup

echo "🔨 Building common..."
helm dependency update "$common_test_path"

echo "🧪 Running tests..."
helm unittest --update-snapshot --helm3 -f "tests/*/*.yaml" "./$common_test_path"

cleanup
