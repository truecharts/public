#!/bin/bash

set -e  # Exit on error
set -u  # Treat unset variables as errors
set -o pipefail  # Fail on command in a pipeline failing

# Define paths
TRASHGUIDES_REPO="https://github.com/TRaSH-Guides/Guides.git"
TRASHGUIDES_DIR="trashguides"
CHARTS_DIR="charts"

echo "Starting script..."

# Clone or update TRaSH-Guides repo
if [ -d "$TRASHGUIDES_DIR/.git" ]; then
    echo "Updating existing TRaSH-Guides repository..."
    git -C "$TRASHGUIDES_DIR" pull --quiet
else
    echo "Cloning TRaSH-Guides repository..."
    git clone --quiet "$TRASHGUIDES_REPO" "$TRASHGUIDES_DIR"
fi

echo "Processing charts in ${CHARTS_DIR}..."

# Loop through all folders in /charts/*
for chart_path in ${CHARTS_DIR}/*/*; do
    if [ -d "$chart_path" ]; then
        folder_name=$(basename "$chart_path")
        echo "Checking chart folder: $folder_name"

        # Look for a matching folder in trashguides/docs/
        matching_folder=$(find "${TRASHGUIDES_DIR}/docs" -type d -name "$folder_name" -print -quit)

        if [ -n "$matching_folder" ]; then
            echo "Match found in TRaSH-Guides: $matching_folder"
            target_dir="${chart_path}/trashguides"
            mkdir -p "$target_dir"

            # Copy the contents of the matching folder
            echo "Copying contents of $matching_folder to $target_dir"
            cp -r ${matching_folder}/* "$target_dir"

            # Copy the LICENSE file
            echo "Copying LICENSE file to $target_dir"
            cp "${TRASHGUIDES_DIR}/LICENSE" "$target_dir"
        else
            echo "No match found for $folder_name in TRaSH-Guides."
        fi
    fi
done

echo "Script completed successfully."
