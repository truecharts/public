#!/usr/bin/env bash

version=$(curl -sX GET 'https://plex.tv/api/downloads/5.json' | jq -r '.computer.Linux.version')
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
