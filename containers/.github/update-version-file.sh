#/bin/bash

app="${1}"

if test -f "/apps/${app}/latest-version.sh"; then
  version=$(bash "/apps/${app}/latest-version.sh")
  if [[ ! -z "${version}" || "${version}" != "null" ]]; then
    echo "${version}" | tee "/apps/${app}/VERSION" >/dev/null
    echo "App: ${app} using version: ${version}"
  fi
fi

if test -f "/apps/${app}/BASE"; then
  if test -f "/apps/${app}/latest-base.sh"; then
    base=$(bash "/apps/${app}/latest-base.sh")
    if [[ ! -z "${base}" || "${base}" != "null" ]]; then
      echo "${base}" | tee "/apps/${app}/BASE" >/dev/null
      echo "App: ${app} using Base: ${base}"
    fi
  fi
fi
