#!/usr/bin/env bash
version=$(cat ./containers/apps/nextcloud-fpm/Dockerfile | grep "FROM public.ecr.aws/docker/library/nextcloud:" | cut -d ':' -f2 | cut -d '@' -f1 | cut -d '-' -f1)
printf "%s" "${version}"
