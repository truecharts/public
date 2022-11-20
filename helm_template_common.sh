#!/bin/bash

common_path=library/common/1.0.0

go-yq -i '.type = "application"' "$common_path"/Chart.yaml
helm template ./"$common_path"
helm lint ./"$common_path"
go-yq -i '.type = "library"' "$common_path"/Chart.yaml
