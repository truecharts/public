#!/bin/bash

app="${1}"

if test -f "/containers/apps/${app}/latest-version.sh"; then
  version=$(bash "/containers/apps/${app}/latest-version.sh")
  if [[ ! -z "${version}" || "${version}" != "null" ]]; then
    echo "${version}" | tee "/containers/apps/${app}/VERSION" >/dev/null
    echo "App: ${app} using version: ${version}"
  fi
fi

if test -f "/containers/apps/${app}/BASE"; then
  if test -f "/containers/apps/${app}/latest-base.sh"; then
    base=$(bash "/containers/apps/${app}/latest-base.sh")
    if [[ ! -z "${base}" || "${base}" != "null" ]]; then
      echo "${base}" | tee "/containers/apps/${app}/BASE" >/dev/null
      echo "App: ${app} using Base: ${base}"
    fi
  fi
fi
