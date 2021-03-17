#!/usr/bin/env bash

version=$(curl -s "https://registry.hub.docker.com/v1/repositories/library/ubuntu/tags" | jq --raw-output '.[] | select(.name | contains("focal")) | .name'  | tail -n1)
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
