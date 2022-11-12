#!/bin/bash

# require go-yq
command -v go-yq >/dev/null 2>&1 || {
    printf >&2 "%s\n" "❌ go-yq (https://github.com/mikefarah/yq) is not installed. Aborting."
    exit 1
}

# define defaults
cache_path="${cache_path:-'./tgz_cache'}"
charts_ath="${charts_ath:-'../../charts'}"

mkdir -p "$cache_path"

trains=(
    "enterprise"
    "stable"
    "incubator"
    "dependency"
)

for train in "${trains[@]}"; do
    for chart in $(ls "$charts_ath/$train"); do
        deps=$(go-yq '.dependencies' "$charts_ath/$train/$chart/Chart.yaml")
        length=$(echo "$deps" | go-yq '. | length')

        echo "🔨 Processing <$chart>... Dependencies: $length"
        echo ""

        for idx in $(eval echo "{0..$length}"); do
            curr_dep=$(echo "$deps" | pos="$idx" go-yq '.[env(pos)]')

            if [ ! "$curr_dep" == null ]; then
                name=$(echo "$curr_dep" | go-yq '.name')
                version=$(echo "$curr_dep" | go-yq '.version')
                repo=$(echo "$curr_dep" | go-yq '.repository')

                echo "**********"
                echo "🔗 Dependency: $name"
                echo "🆚 Version: $version"
                echo "🏠 Repository: $repo"
                echo ""

                if [ -f "$cache_path/$name-$version.tgz" ]; then
                    echo "✅ Dependency exists in cache..."
                else
                    echo "🤷‍♂️ Dependency does not exists in cache..."

                    repo_url="$repo/index.yaml"
                    echo "🤖 Calculating URL..."
                    dep_url=$(curl -s "$repo_url" | v="$version" n="$name" go-yq '.entries.[env(n)].[] | select (.version == env(v)) | .urls.[0]')

                    echo ""
                    echo "⏬ Downloading dependency $name-$version from $dep_url..."
                    wget --quiet "$dep_url" -P "$cache_path/"
                    if [ ! $? ]; then
                        echo "❌ wget encountered an error..."
                        helm dependency build "$charts_ath/$train/$chart/Chart.yaml" || helm dependency update "$charts_ath/$train/$chart/Chart.yaml" || exit 1
                    fi

                    if [ -f "$cache_path/$name-$version.tgz" ]; then
                        echo "✅ Dependency Downloaded!"
                    else
                        echo "❌ Failed to download dependency"
                        # Try helm dependency build/update or otherwise fail fast if a dep fails to download...
                        helm dependency build "$charts_ath/$train/$chart/Chart.yaml" || helm dependency update "$charts_ath/$train/$chart/Chart.yaml" || exit 1
                    fi
                fi
                echo ""

                mkdir -p "$charts_ath/$train/$chart/charts"
                echo "📝 Copying dependency <$name-$version.tgz> to <$charts_ath/$train/$chart/charts>..."
                cp "$cache_path/$name-$version.tgz" "$charts_ath/$train/$chart/charts"

                if [ -f "$cache_path/$name-$version.tgz" ]; then
                    echo "✅ Dependency copied!"
                    echo ""
                else
                    echo "❌ Failed to copy dependency"
                    # Try helm dependency build/update or otherwise fail fast if a dep fails to copy...
                    ehelm dependency build "$charts_ath/$train/$chart/Chart.yaml" || helm dependency update "$charts_ath/$train/$chart/Chart.yaml" || exit 1
                fi
            fi
        done
        echo "----------"
    done
done
