#!/bin/sh

# Installs the passed application if not already installed
install_app() {
  app_name="${1:?"app_name is unset"}"

  echo "Installing [$app_name]..."

  if occ app:list | grep -wq "$app_name"; then
    echo "App [$app_name] is already installed! Skipping..."
    return 0
  fi

  if ! occ app:install "$app_name"; then
    echo "Failed to install $app_name..."
    exit 1
  fi

  echo "App [$app_name] installed successfuly!"
}

remove_app() {
  app_name="${1:?"app_name is unset"}"

  echo "Removing [$app_name]..."

  if ! occ app:list | grep -wq "$app_name"; then
    echo "App [$app_name] is not installed! Skipping..."
    return 0
  fi

  if ! occ app:remove "$app_name"; then
    echo "Failed to remove [$app_name]..."
    exit 1
  fi

  echo "App [$app_name] removed successfuly!"
}

# Sets a space separated values into the specified list, by default for system settings
# Pass a 3rd argument for a different app
set_list() {
  list_name="${1:?"list_name is unset"}"
  space_delimited_values="${2:?"space_delimited_values is unset"}"
  app="${3:-"system"}"
  prefix="${4:-""}"

  if [ -n "${space_delimited_values}" ]; then

    if [ "${app}" != 'system' ]; then
      occ config:app:delete "$app" "$list_name"
    else
      occ config:system:delete "$list_name"
    fi

    IDX=0
    # Replace spaces with newlines so the input can have
    # mixed entries of space or new line seperated values
    echo "$space_delimited_values" | tr ' ' '\n' | while IFS= read -r value; do
        # Skip empty values
        if [ -z "$value" ]; then
          continue
        fi

        # Prepend prefix (eg OC\Preview)
        if [ -n "${prefix}" ]; then
          value="$prefix$value"
        fi

        if [ "${app}" != 'system' ]; then
          occ config:app:set "$app" "$list_name" $IDX --value="$value"
        else
          occ config:system:set "$list_name" $IDX --value="$value"
        fi

        IDX=$((IDX+1))
    done
  fi
}

config_file="${NX_CONFIG_FILE_PATH:-"/var/www/html/config/config.php"}"
if [ ! -f "$config_file" ]; then
  echo "Config file [$config_file] is missing. Something went wrong. Exiting in 15 sec..."
  # Sleep so people can get to the logs
  # And see what happened
  sleep 15
  exit 1
fi

if ! grep -q "'installed' => true" "$config_file"; then
  echo 'Looks like Nextcloud failed to complete installation. Exiting in 15 sec...'
  # Sleep so people can get to the logs
  # And see what happened
  sleep 15
  exit 1
fi

echo 'Nextcloud is installed. proceeding with the configuration.'

echo '++++++++++++++++++++++++++++++++++++++++++++++++++'
echo ''
### Source all configure-scripts. ###
for script in /configure-scripts/*.sh; do
  echo "Sourcing $script"
  . "$script"
done

echo ''
echo 'Executing injected scripts...'
echo '++++++++++++++++++++++++++++++++++++++++++++++++++'
echo ''
### Start Configuring ###

# Configure Redis
if [ "${NX_REDIS:-"true"}" = "true" ]; then
  echo '# Redis is enabled.'
  occ_redis_install
else
  echo '# Redis is disabled.'
  occ_redis_remove
fi

# Configure Database
echo ''
occ_database
# Configure General Settings
echo ''
occ_general
# Configure Logging
echo ''
occ_logging
# Configure URLs (Trusted Domains, Trusted Proxies, Overwrites, etc)
echo ''
occ_urls
# Configure Expiration/Retention Days
echo ''
occ_expire_retention

echo ''
if [ "${NX_NOTIFY_PUSH:-"true"}" = "true" ]; then
  echo '# Notify Push is enabled.'
  occ_notify_push_install
else
  echo '# Notify Push is disabled.'
  occ_notify_push_remove
fi

echo ''
# If Imaginary is enabled, previews are forced enabled
if [ "${NX_IMAGINARY:-"true"}" = "true" ]; then
  NX_PREVIEWS="true"
  echo '# Imaginary is enabled.'
  occ_imaginary_install
else
  echo '# Imaginary is disabled.'
  occ_imaginary_remove
fi

echo ''
# If Imaginary is disabled but previews are enabled, configure only previews
if [ "${NX_PREVIEWS:-"true"}" = "true" ] ; then
  echo '# Preview Generator is enabled.'
  occ_preview_generator_install
else
  echo '# Preview Generator is disabled.'
  occ_preview_generator_remove
fi

echo ''
if [ "${NX_CLAMAV:-"false"}" = "true" ]; then
  echo '# ClamAV is enabled.'
  occ_clamav_install
else
  echo '# ClamAV is disabled.'
  occ_clamav_remove
fi

echo ''
if [ "${NX_COLLABORA:-"false"}" = "true" ]; then
  echo '# Collabora is enabled.'
  occ_collabora_install
else
  echo '# Collabora is disabled.'
  occ_collabora_remove
fi

echo ''
if [ "${NX_ONLYOFFICE:-"false"}" = "true" ]; then
  echo '# OnlyOffice is enabled.'
  occ_onlyoffice_install
else
  echo '# OnlyOffice is disabled.'
  occ_onlyoffice_remove
fi

if [ "${NX_ONLYOFFICE:-"false"}" = "true" ] || [ "${NX_COLLABORA:-"false"}" = "true" ] || [ "${NX_FORCE_ENABLE_ALLOW_LOCAL_REMOTE_SERVERS:-"false"}" = "true" ]; then
  occ config:system:set allow_local_remote_servers --value="true"
else
  occ config:system:delete allow_local_remote_servers
fi

occ_cleanups

echo ''
echo '++++++++++++++++++++++++++++++++++++++++++++++++++'
### End Configuring ###

echo '--------------------------------------------------'
echo ''

# Run optimize/repairs/migrations
if [ "${NX_RUN_OPTIMIZE:-"true"}" = "true" ]; then
  echo '# Optimize is enabled. Running...'
  occ_optimize
else
  echo '# Optimize is disabled. Skipping...'
fi

echo ''
echo '--------------------------------------------------'

echo 'Starting Nextcloud PHP-FPM'

exec "$@"
