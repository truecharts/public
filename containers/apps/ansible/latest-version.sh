#!/usr/bin/env bash

version=$(curl -sX GET https://pypi.org/pypi/ansible/json | jq --raw-output '.["releases"] | keys[]' | grep -v rc | grep -v a | grep -v b | tail -n1rep -v buildcache | tail -n1)
version="${version#*v}"
version="${version#*release-}"
echo "${version}"
