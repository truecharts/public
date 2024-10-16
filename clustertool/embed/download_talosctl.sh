#!/bin/bash

# Ensure the script exits on errors and undefined variables
set -euo pipefail

# Define the version
version="v1.8.0"  # Example version

# Define the OS and architecture combinations
combinations=(
    "linux amd64"
    "linux arm64"
    "darwin amd64"
    "darwin arm64"
    "windows amd64"
    "freebsd amd64"
    "freebsd arm64"
)

# Base URL for downloading the file
base_url="https://github.com/siderolabs/talos/releases/download/${version}"

# Iterate over each combination
for combo in "${combinations[@]}"; do
    # Split the combination into OS and architecture
    os=$(echo "$combo" | cut -d ' ' -f 1)
    arch=$(echo "$combo" | cut -d ' ' -f 2)

    # Determine the file name and download URL based on OS and architecture
    if [ "$os" == "windows" ]; then
        file_name="talosctl-${os}-${arch}.exe"
        file_extension="exe"
    elif [ "$os" == "darwin" ] || [ "$os" == "freebsd" ]; then
        file_name="talosctl-${os}-${arch}"
        file_extension="bin"
    else
        file_name="talosctl-${os}-${arch}"
        file_extension="bin"
    fi

    # Construct the download URL and target directory
    download_url="${base_url}/${file_name}"
    target_dir="./clustertool/embed/${os}_${arch}"

    # Create target directory if it doesn't exist
    mkdir -p "${target_dir}"

    # Download the file
    echo "Downloading ${download_url}..."
    curl -L -o "${file_name}" "${download_url}"

    # Handle different file types
    if [ "$file_extension" == "exe" ]; then
        # For Windows executables, just move the file to the target directory
        echo "Moving ${file_name} to ${target_dir}..."
        mv "${file_name}" "${target_dir}/"
    elif [ "$os" == "linux" ] || [ "$os" == "darwin" ] || [ "$os" == "freebsd" ]; then
        # For Linux, Darwin, and FreeBSD binaries
        echo "Moving ${file_name} to ${target_dir}..."
        mv "${file_name}" "${target_dir}/"
    fi

    # Print success message
    echo "Talosctl ${version} for ${os}-${arch} has been downloaded and moved to ${target_dir}"
done
