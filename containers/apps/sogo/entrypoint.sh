#!/usr/bin/env bash

#shellcheck disable=SC1091
source "/shim/umask.sh"
source "/shim/vpn.sh"


if [[ "${SKIP_SOGO}" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
  echo "SKIP_SOGO=y, skipping SOGo..."
  sleep 365d
  exit 0
fi

# Run hooks
for file in /hooks/*; do
  if [ -x "${file}" ]; then
    echo "Running hook ${file}"
    "${file}"
  fi
done

exec "$@"
