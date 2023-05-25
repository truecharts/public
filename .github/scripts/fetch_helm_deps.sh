#!/bin/bash

# require go-yq
command -v go-yq >/dev/null 2>&1 || {
    printf >&2 "%s\n" "❌ go-yq (https://github.com/mikefarah/yq) is not installed. Aborting."
    exit 1
}

# define defaults
cache_path=${cache_path:-./tgz_cache}
charts_path=${charts_path:-./charts}
# Do NOT persist this directory, in order to always have the latest index for this run.
index_cache=${index_cache:-./index_cache}

mkdir -p "$cache_path"

trains=(
    "enterprise"
    "stable"
    "incubator"
    "dependency"
    "operators"
)

load_gpg_key() {
echo ""
echo "⏬ Downloading and Loading TrueCharts pgp Public Key"
gpg_dir=.cr-gpg
mkdir -p "$gpg_dir"
curl --silent https://keybase.io/truecharts/pgp_keys.asc | gpg --dearmor > $gpg_dir/pubring.gpg || echo "❌ Couldn't load  Public Key."
echo "✅ Public Key loaded successfully..."
echo ""
}
export -f load_gpg_key

download_deps() {
local train_chart="$1"

# Extract dependencies for the Chart
deps=$(go-yq '.dependencies' "$charts_path/$train_chart/Chart.yaml")
# Find how many deps exist, so we can loop through them
length=$(echo "$deps" | go-yq '. | length')

echo "🤖🔨 Processing <$charts_path/$train_chart>... Dependencies: $length"
echo ""

for idx in $(eval echo "{0..$length}"); do
    # Retrieve info for the dep in the current index..
    curr_dep=$(echo "$deps" | pos="$idx" go-yq '.[env(pos)]')

    if [ ! "$curr_dep" == null ]; then
        name=$(echo "$curr_dep" | go-yq '.name')
        version=$(echo "$curr_dep" | go-yq '.version')
        repo=$(echo "$curr_dep" | go-yq '.repository')

        # Remove http:// or https:// from url to create a dir name
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
            if [ -f "$index_cache/$repo_dir/index.yaml" ]; then
                echo "✅ Index for <$repo> exists!"
            else
                echo "⏬ Index for <$repo> is missing. Downloading from <$repo_url>..."

                mkdir -p $index_cache/$repo_dir
                wget --quiet "$repo_url" -O "$index_cache/$repo_dir/index.yaml"
                if [ ! $? ]; then
                    echo "❌ wget encountered an error..."
                    exit 1
                fi

                if [ -f "$index_cache/$repo_dir/index.yaml" ]; then
                    echo "✅ Downloaded index for <$repo>!"
                else
                    echo "❌ Failed to download index for <$repo> from <$repo_url>"
                    exit 1
                fi
            fi

            # At the time of writing this, only 1 url existed (.urls[0]) pointing to the actual tgz.
            # Extract url from repo_url. It's under .entries.DEP_NAME.urls. We filter the specific version first (.version)
            dep_url=$(v="$version" n="$name" go-yq '.entries.[env(n)].[] | select (.version == env(v)) | .urls.[0]' "$index_cache/$repo_dir/index.yaml")

            echo ""
            echo "⏬ Downloading dependency $name-$version from $dep_url..."
            mkdir -p "$cache_path/$repo_dir"
            wget --quiet "$dep_url" -P "$cache_path/$repo_dir"
            wget --quiet "$dep_url.prov" -P "$cache_path/$repo_dir"

            if [ ! $? ]; then
                echo "❌ wget encountered an error..."
              if [[ "$train_chart" =~ incubator\/.* ]]; then
                  helm dependency build "$charts_path/$train_chart/Chart.yaml" || \
                  helm dependency update "$charts_path/$train_chart/Chart.yaml"|| exit 1
              else
                  helm dependency build "$charts_path/$train_chart/Chart.yaml" --verify --keyring $gpg_dir/pubring.gpg || \
                  helm dependency update "$charts_path/$train_chart/Chart.yaml" --verify --keyring $gpg_dir/pubring.gpg || exit 1
              fi
            fi

            if [ -f "$cache_path/$repo_dir/$name-$version.tgz" ]; then
                echo "✅ Dependency Downloaded!"
                if [[ ! "$train_chart" =~ incubator\/.* ]]; then
                  echo "Validating dependency signature..."
                  helm verify $cache_path/$repo_dir/$name-$version.tgz --keyring $gpg_dir/pubring.gpg || \
                  helm verify $cache_path/$repo_dir/$name-$version.tgz --keyring $gpg_dir/pubring.gpg || exit 1
                else
                  echo "Skipping dependency signature verification for $train_chart..."
                fi
            else
                echo "❌ Failed to download dependency"
                # Try helm dependency build/update or otherwise fail fast if a dep fails to download...
              if [[ "$train_chart" =~ incubator\/.* ]]; then
                  helm dependency build "$charts_path/$train_chart/Chart.yaml" || \
                  helm dependency update "$charts_path/$train_chart/Chart.yaml"|| exit 1
              else
                  helm dependency build "$charts_path/$train_chart/Chart.yaml" --verify --keyring $gpg_dir/pubring.gpg || \
                  helm dependency update "$charts_path/$train_chart/Chart.yaml" --verify --keyring $gpg_dir/pubring.gpg || exit 1
              fi
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
            helm dependency build "$charts_path/$train_chart/Chart.yaml" || \
            helm dependency update "$charts_path/$train_chart/Chart.yaml" || exit 1
        fi
    fi
done
}
export -f download_deps

load_gpg_key

if [ -z "$1" ]; then
  for train in "${trains[@]}"; do
      for chart in $(ls "$charts_path/$train"); do
        download_deps "${train}/${chart}"
      done
  done
else
  download_deps "$1"
fi
