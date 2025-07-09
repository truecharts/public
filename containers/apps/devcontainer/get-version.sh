#!/usr/bin/env bash
version=$(grep "ARG CLUSTERTOOL_VERSION=" ./containers/apps/devcontainer/Dockerfile | cut -d '=' -f2)
printf "%s" "${version}"
