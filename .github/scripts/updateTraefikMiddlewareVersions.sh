#! /bin/bash

trainsPath="./charts"
traefikTrain="stable"

get_latest_release() {
    # Get latest release from GitHub api
    curl --silent \
         --header 'authorization: Bearer ${{ secrets.GITHUB_TOKEN }}' \
         --url "https://api.github.com/repos/$1/releases/latest" |
    # Get tag line
    grep '"tag_name":' |
    # Pluck JSON value
    sed -E 's/.*"([^"]+)".*/\1/'
}

set_key_to_version() {
    key="$1"
    version="$2"
    traefikValuesFile="$trainsPath/$traefikTrain/traefik/values.yaml"
    echo "Setting $key to $version..."
    sed -i "s/${key}: .*/${key}: ${version}/" $traefikValuesFile

    content=$(grep "$key:" "$traefikValuesFile" | sed "s/\s*${key}:\s*//" )
    echo "New content of $key in values.yaml: $content"
    echo ""
}

update_plugin() {
    repo="$1"
    key="$2"
    pluginName="$3"

    version=$(get_latest_release "$repo")
    if [ -z "$version" ]
    then
        echo "Got empty version, skipping..."
    else
        echo "Fetched $pluginName plugin version: $version"
        set_key_to_version "$key" "$version"
    fi;
}
# Example
# update_plugin "repo" "key_holding_version_in_values.yaml" "plugin_name_used_for_verbose_printing_only"
# Real IP
update_plugin "soulbalz/traefik-real-ip" "realIPVersion" "RealIP"

# Theme Park
update_plugin "packruler/traefik-themepark" "themeParkVersion" "ThemePark"
