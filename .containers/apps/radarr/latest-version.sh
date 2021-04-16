#!/usr/bin/env bash

TOKEN=$(curl https://ghcr.io/token\?scope\="repository:k8s-at-home/radarr:pull" | jq --raw-output '.[]')
version=$(curl -H "Authorization: Bearer ${TOKEN}" https://ghcr.io/v2/k8s-at-home/radarr/tags/list | jq --raw-output '.tags[]' | grep -v latest | grep -v buildcache | tail -n1)
version="${version#*v}"
version="${version#*release-}"
echo "${version}"
