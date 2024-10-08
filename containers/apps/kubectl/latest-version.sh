#!/usr/bin/env bash

version=$(curl -L -s https://dl.k8s.io/release/stable.txt)
printf "%s" "${version}"
