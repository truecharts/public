#!/bin/bash

# require go-yq
command -v go-yq >/dev/null 2>&1 || {
    printf >&2 "%s\n" "❌ go-yq (https://github.com/mikefarah/yq) is not installed. Aborting."
    exit 1
}

# define defaults
cache_path=${cache_path:-./tgz_cache}
charts_path=${charts_path:-./charts}

mkdir -p "$cache_path"

trains=(
    "enterprise"
    "stable"
    "incubator"
    "dependency"
)

download_deps() {
local train_chart="$1"

# Extract dependencies for the Chart
deps=$(go-yq '.dependencies' "$charts_path/$train_chart/Chart.yaml")
# Find how many deps exist, so we can loop through them
length=$(echo "$deps" | go-yq '. | length')

echo "🔨 Processing <$charts_path/$train_chart>... Dependencies: $length"
echo ""

for idx in $(eval echo "{0..$length}"); do
    # Retrieve info for the dep in the current index..
    curr_dep=$(echo "$deps" | pos="$idx" go-yq '.[env(pos)]')

    if [ ! "$curr_dep" == null ]; then
        name=$(echo "$curr_dep" | go-yq '.name')
        version=$(echo "$curr_dep" | go-yq '.version')
        repo=$(echo "$curr_dep" | go-yq '.repository')

        repo_dir="${repo#http://}"
        repo_dir="${repo#https://}"

        echo "**********"
        echo "🔗 Dependency: $name"
        echo "🆚 Version: $version"
        echo "🏠 Repository: $repo"
        echo ""

        if [ -f "$cache_path/$repo_dir/$name-$version.tgz" ]; then
            echo "✅ Dependency exists in cache..."
        else
            echo "🤷‍♂️ Dependency does not exists in cache..."

            repo_url="$repo/index.yaml"
            echo "🤖 Calculating URL..."
            # At the time of writing this, only 1 url existed (.urls[0]) pointing to the actual tgz.
            # Extract url from repo_url. It's under .entries.DEP_NAME.urls. We filter the specific version first (.version)
            dep_url=$(curl -s "$repo_url" | v="$version" n="$name" go-yq '.entries.[env(n)].[] | select (.version == env(v)) | .urls.[0]')

            echo ""
            echo "⏬ Downloading dependency $name-$version from $dep_url..."
            mkdir -p "$cache_path/$repo_dir"
            wget --quiet "$dep_url" -P "$cache_path/$repo_dir"
            if [ ! $? ]; then
                echo "❌ wget encountered an error..."
                helm dependency build "$charts_path/$train_chart/Chart.yaml" || helm dependency update "$charts_path/$train_chart/Chart.yaml" || exit 1
            fi

            if [ -f "$cache_path/$repo_dir/$name-$version.tgz" ]; then
                echo "✅ Dependency Downloaded!"
            else
                echo "❌ Failed to download dependency"
                # Try helm dependency build/update or otherwise fail fast if a dep fails to download...
                helm dependency build "$charts_path/$train_chart/Chart.yaml" || helm dependency update "$charts_path/$train_chart/Chart.yaml" || exit 1
            fi
        fi
        echo ""

        mkdir -p "$charts_path/$train_chart/charts"
        echo "📝 Copying dependency <$name-$version.tgz> to <$charts_path/$train_chart/charts>..."
        cp "$cache_path/$repo_dir/$name-$version.tgz" "$charts_path/$train_chart/charts"

        if [ -f "$charts_path/$train_chart/charts/$name-$version.tgz" ]; then
            echo "✅ Dependency copied!"
            echo ""
        else
            echo "❌ Failed to copy dependency"
            # Try helm dependency build/update or otherwise fail fast if a dep fails to copy...
            helm dependency build "$charts_path/$train_chart/Chart.yaml" || helm dependency update "$charts_path/$train_chart/Chart.yaml" || exit 1
        fi
    fi
done
}
export -f download_deps

if [ -z "$1" ]; then
  for train in "${trains[@]}"; do
      for chart in $(ls "$charts_path/$train"); do
        download_deps "${train}/${chart}"
      done
  done
else
  download_deps "$1"
fi
