#!/usr/bin/env bash

version=$(curl "https://registry.hub.docker.com/v1/repositories/freeradius/freeradius-server/tags" | jq --raw-output '.[].name' | grep -v layer | grep -v alpine | grep -v latest | tail -n1)
version="${version#*v}"
version="${version#*release-}"
echo "${version}"
