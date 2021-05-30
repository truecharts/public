#!/usr/bin/env bash

# This file is based off of the official 40-plex-first-run
# Here: https://github.com/plexinc/pms-docker/blob/master/root/etc/cont-init.d/40-plex-first-run
# It should live in /etc/cont-init.d/

# If we are debugging, enable trace
if [ "${DEBUG,,}" = "true" ]; then
  set -x
fi

function getPref {
  local key="${1}"

  xmlstarlet sel -T -t -m "/Preferences" -v "@${key}" -n "${prefFile}"
}

function setPref {
  local key="${1}"
  local value="${2}"

  count="$(xmlstarlet sel -t -v "count(/Preferences/@${key})" "${prefFile}")"
  count=$(($count + 0))
  if [[ $count > 0 ]]; then
    xmlstarlet ed --inplace --update "/Preferences/@${key}" -v "${value}" "${prefFile}"
  else
    xmlstarlet ed --inplace --insert "/Preferences"  --type attr -n "${key}" -v "${value}" "${prefFile}"
  fi
}

prefFile="${PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR}/Plex Media Server/Preferences.xml"

# Setup Server's client identifier
serial="$(getPref "MachineIdentifier")"
if [ -z "${serial}" ]; then
  serial="$(uuidgen)"
  setPref "MachineIdentifier" "${serial}"
fi
clientId="$(getPref "ProcessedMachineIdentifier")"
if [ -z "${clientId}" ]; then
  clientId="$(echo -n "${serial}- Plex Media Server" | sha1sum | cut -b 1-40)"
  setPref "ProcessedMachineIdentifier" "${clientId}"
fi

# Get server token and only turn claim token into server token if we have former but not latter.
token="$(getPref "PlexOnlineToken")"
if [ ! -z "${PLEX_CLAIM}" ] && [ -z "${token}" ]; then
  echo "Attempting to obtain server token from claim token"
  loginInfo="$(curl -X POST \
        -H 'X-Plex-Client-Identifier: '${clientId} \
        -H 'X-Plex-Product: Plex Media Server'\
        -H 'X-Plex-Version: 1.1' \
        -H 'X-Plex-Provides: server' \
        -H 'X-Plex-Platform: Linux' \
        -H 'X-Plex-Platform-Version: 1.0' \
        -H 'X-Plex-Device-Name: PlexMediaServer' \
        -H 'X-Plex-Device: Linux' \
        "https://plex.tv/api/claim/exchange?token=${PLEX_CLAIM}")"
  token="$(echo "$loginInfo" | sed -n 's/.*<authentication-token>\(.*\)<\/authentication-token>.*/\1/p')"

  if [ "$token" ]; then
    echo "Token obtained successfully"
    setPref "PlexOnlineToken" "${token}"
  fi
fi

if [ -n "${ADVERTISE_IP}" ]; then
  setPref "customConnections" "${ADVERTISE_IP}"
fi

if [ -n "${ALLOWED_NETWORKS}" ]; then
  setPref "allowedNetworks" "${ALLOWED_NETWORKS}"
fi

# Set transcoder temp if not yet set
if [ -z "$(getPref "TranscoderTempDirectory")" ]; then
  setPref "TranscoderTempDirectory" "/transcode"
fi

# Parse list of all exported variables that start with PLEX_PREFERENCE_
# The format of which is PLEX_PREFERENCE_<SOMETHING>="Key=Value"
# Where Key is the EXACT key to use in the Plex Preference file
# And Value is the EXACT value to use in the Plex Preference file for that key.
# Please note it looks like many of the key's are camelCase in some fashion.
# Additionally there are likely some preferences where environment variable injection
# doesn't really work for.
for var in "${!PLEX_PREFERENCE_@}"; do
  value="${!var}"
  PreferenceValue="${value#*=}"
  PreferenceKey="${value%=*}"
  setPref "${PreferenceKey}" "${PreferenceValue}"
done

echo "Plex Media Server preferences updated"
