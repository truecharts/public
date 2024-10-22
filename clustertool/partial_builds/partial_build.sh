#!/bin/bash

set -e

# Define target OS names
os_names=("linux" "windows" "darwin" "freebsd")
# Define corresponding GOOS values
os_targets=("linux" "windows" "darwin" "freebsd")

# Define target architectures
architectures=("amd64" "arm64")

# Ensure embed directories exist
for i in "${!os_names[@]}"; do
    os=${os_names[i]}
    for arch in "${architectures[@]}"; do
        mkdir -p "./clustertool/embed/${os}_${arch}"
    done
done

# Build the precommit binary for each OS and architecture
for i in "${!os_names[@]}"; do
    os=${os_names[i]}
    for arch in "${architectures[@]}"; do
        echo "Building precommit for $os/$arch"

        # Determine output file name and extension
        output="./embed/${os}_${arch}/precommit"
        mkdir "./clustertool/embed/${os}_${arch}/" || echo "mkdir failed or not needed"
        if [ "$os" == "windows" ]; then
            output+=".exe"
        fi

        # Build the binary
        cd clustertool
        GOOS=$os GOARCH=$arch go build -o $output ./partial_builds/precommit/main.go
        ls -l "./embed/${os}_${arch}/" || echo "ls failed"
        cd -
    done
done
