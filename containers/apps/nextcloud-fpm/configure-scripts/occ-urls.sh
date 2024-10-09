#!/bin/sh
occ_urls(){
  echo '## Configuring Overwrite URLs...'
  occ config:system:set overwrite.cli.url --value="${NX_OVERWRITE_CLI_URL:?"NX_OVERWRITE_CLI_URL is unset"}"
  occ config:system:set overwritehost --value="${NX_OVERWRITE_HOST:?"NX_OVERWRITE_HOST is unset"}"
  occ config:system:set overwriteprotocol --value="${NX_OVERWRITE_PROTOCOL:?"NX_OVERWRITE_PROTOCOL is unset"}"

  echo '## Configuring Trusted Domains...'
  [ "${NX_TRUSTED_DOMAINS:?"NX_TRUSTED_DOMAINS is unset"}" ]

  if [ "${NX_COLLABORA:-"false"}" = "true" ]; then
    # Remove http(s):// from NX_COLLABORA_URL
    [ "${NX_COLLABORA_URL:?"NX_COLLABORA_URL is unset"}" ]
    NX_COLLABORA_DOMAIN="${NX_COLLABORA_URL#*://}"
    # Remove /foo (subfolder) from NX_COLLABORA_DOMAIN
    NX_COLLABORA_DOMAIN="${NX_COLLABORA_DOMAIN#%/*}"
    if [ "${NX_COLLABORA_DOMAIN}" != "${NX_OVERWRITE_HOST}" ]; then
      NX_TRUSTED_DOMAINS="${NX_TRUSTED_DOMAINS} ${NX_COLLABORA_DOMAIN}"
    fi
  fi

  if [ "${NX_ONLYOFFICE:-"false"}" = "true" ]; then
    # Remove http(s):// from NX_ONLYOFFICE_URL
    [ "${NX_ONLYOFFICE_URL:?"NX_ONLYOFFICE_URL is unset"}" ]
    NX_ONLYOFFICE_DOMAIN="${NX_ONLYOFFICE_URL#*://}"
    # Remove /foo (subfolder) from NX_ONLYOFFICE_DOMAIN
    NX_ONLYOFFICE_DOMAIN="${NX_ONLYOFFICE_DOMAIN#%/*}"
    if [ "${NX_ONLYOFFICE_DOMAIN}" != "${NX_OVERWRITE_HOST}" ]; then
      NX_TRUSTED_DOMAINS="${NX_TRUSTED_DOMAINS} ${NX_ONLYOFFICE_DOMAIN}"
    fi
  fi

  set_list 'trusted_domains' "${NX_TRUSTED_DOMAINS}" 'system'

  echo '## Configuring Trusted Proxies...'
  set_list 'trusted_proxies' "${NX_TRUSTED_PROXIES:?"NX_TRUSTED_PROXIES is unsed"}" 'system'
}
