#!/usr/bin/env bash

version=$(curl -sX GET "https://lidarr.servarr.com/v1/update/nightly/changes?os=linux" | jq --raw-output '.[0].version')
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
