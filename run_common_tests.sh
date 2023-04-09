#!/bin/bash
# https://github.com/helm-unittest/helm-unittest

# -- You need to install this helm plugin
# helm plugin install https://github.com/helm-unittest/helm-unittest

common_test_path="library/common-test"

function cleanup {
  if [ -d "$common_test_path/charts" ]; then
    echo "🧹 Cleaning up charts..."
    rm -r "$common_test_path/charts"
    rm  "$common_test_path/Chart.lock"
    # Clean snapshots
    rm -r "$common_test_path/**/__snapshot__" 2> /dev/null
  fi
}

cleanup

echo "🔨 Building common..."
helm dependency update "$common_test_path"

echo "🧪 Running tests..."
helm unittest --update-snapshot -f "tests/*/*.yaml" "./$common_test_path"

cleanup
