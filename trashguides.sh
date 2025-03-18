#!/bin/bash

# Define variables
TRASHGUIDES_REPO="https://github.com/TRaSH-Guides/Guides.git"
TRASHGUIDES_DIR="trashguides"
CHARTS_DIR="charts"

# Clone or update TRaSH-Guides repo
if [ -d "$TRASHGUIDES_DIR" ]; then
    git -C "$TRASHGUIDES_DIR" pull
else
    git clone "$TRASHGUIDES_REPO" "$TRASHGUIDES_DIR"
fi

# Loop through folders in /charts/*/FOLDERNAME
for chart_path in "$CHARTS_DIR"/*/; do
    folder_name=$(basename "$chart_path")
    matching_folder=$(find "$TRASHGUIDES_DIR/docs" -type d -name "$folder_name" -print -quit)

    if [ -n "$matching_folder" ]; then
        target_dir="${chart_path}trashguides"
        mkdir -p "$target_dir"

        # Copy folder contents
        cp -r "$matching_folder"/* "$target_dir"

        # Copy LICENSE
        cp "$TRASHGUIDES_DIR/LICENSE" "$target_dir"
    fi
done
