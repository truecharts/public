#!/usr/bin/env bash

version=$(curl -sX GET "https://api.github.com/repos/inverse-inc/sogo/releases" | jq --raw-output '.[0].tag_name')
version="${version#*SOGo-}"
version="${version#*release-}"
version="${version#*v}"
printf "%s" "${version}"
