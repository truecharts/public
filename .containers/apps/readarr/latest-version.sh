#!/usr/bin/env bash

version=$(curl -fsSL "https://readarr.servarr.com/v1/update/nightly/changes?os=linux&runtime=netcore" | jq --raw-output '.[0].version')
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
