#!/bin/bash

# Define the directory containing the Charts.yaml files
charts_dir="charts/incubator"

# List of app names
app_list=(
  "authentik"
  "darktable"
  "guacamole-client"
  "cloudflared"
  "dsmr-reader"
  "habridge"
  "dupeguru"
  "filerun"
  "filezilla"
  "firefox"
  "flashpaper"
  "focalboard"
  "gotify"
  "grist"
  "icantbelieveitsnotvaletudo"
  "icinga2"
  "inventree"
  "invidious"
  "joplin-server"
  "k8s-gateway"
  "kimai"
  "koel"
  "kopia"
  "kutt"
  "leantime"
  "libreoffice"
  "librephotos"
  "linkace"
  "loki"
  "lychee"
  "mattermost"
  "mealie"
  "miniflux"
  "ml-workspace"
  "mosquitto"
  "nextcloud"
  "openkm"
  "openldap"
  "penpot"
  "photoview"
  "pialert"
  "piaware"
  "pidgin"
  "pihole"
  "plexanisync"
  "protonmail-bridge"
  "pydio-cells"
  "recipes"
  "rtmpserver"
  "sdtd"
  "shiori"
  "snipe-it"
  "statping-ng"
  "synapse"
  "teamspeak3"
  "typecho"
  "wbo"
  "wger"
  "wireshark"
  "wordpress"
  "xbackbone"
  "youtrack"
  "zusam"
)

# Loop through each app in the list
for app_name in "${app_list[@]}"
do
  # Check if the app directory exists
  if [ -d "${charts_dir}/${app_name}" ]; then
    # Check if the Charts.yaml file exists
    if [ -f "${charts_dir}/${app_name}/Chart.yaml" ]; then
      # Read the current version from the Charts.yaml file
      current_version=$(awk '/^version:/{print $2}' "${charts_dir}/${app_name}/Chart.yaml")

      # Extract major version and increment it by 1
      major_version=$(echo "${current_version}" | awk -F '.' '{print $1 + 1}')

      # Set the updated version
      updated_version="${major_version}.0.0"

      # Update the version in the Charts.yaml file
      sed -i "s/version: ${current_version}/version: ${updated_version}/" "${charts_dir}/${app_name}/Chart.yaml"

      echo "Updated version in ${charts_dir}/${app_name}/Chart.yaml from ${current_version} to ${updated_version}"
    fi
  fi
done
