#!/usr/bin/env bash
version=$(cat ./apps/nextcloud-fpm/Dockerfile | grep "FROM docker.io/nextcloud:" | cut -d ':' -f2 | cut -d '@' -f1 | cut -d '-' -f1)
printf "%s" "${version}"
