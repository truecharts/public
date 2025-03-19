#!/bin/bash

set -e  # Exit on error
set -u  # Treat unset variables as errors
set -o pipefail  # Fail on command in a pipeline failing

# Enable dotglob to include hidden files
shopt -s dotglob

# Define paths
TRASHGUIDES_REPO="https://github.com/TRaSH-Guides/Guides.git"
TRASHGUIDES_DIR="temp/trashguides"
CHARTS_DIR="charts"

# Header and Footer content
HEADER=":::caution\nThese guides are supplied 'as-is' and not covered by our support ticket system.\n:::\n\n:::info\nAll credits go towards: https://trash-guides.info\nfor more info and guides, please check them out!:::"
FOOTER=""

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

        # Look for a matching folder in trashguides/docs/ or trashguides/docs/downloaders/
        matching_folder=$(find "${TRASHGUIDES_DIR}/docs" "${TRASHGUIDES_DIR}/docs/downloaders" \
    -type d -iname "$folder_name" ! -path "${TRASHGUIDES_DIR}/docs/json/*" -print -quit 2>/dev/null)
        if [ -n "$matching_folder" ]; then
            echo "Match found in TRaSH-Guides: $matching_folder"
            target_dir="${chart_path}/trashguides"
            mkdir -p "$target_dir"

            # Copy the contents of the matching folder, including hidden files
            echo "Copying contents of $matching_folder to $target_dir"
            cp -r "${matching_folder}/." "$target_dir"

find "$target_dir" -type f -name "*.md" | while read -r md_file; do
    # Remove the first line of the file
    sed -i '' '1d' "$md_file"  # macOS/BSD sed syntax

    # Add the header at the beginning of the file
    echo -e "$HEADER" | cat - "$md_file" > temp && mv temp "$md_file"

    # Add the footer at the end of the file
    echo -e "$FOOTER" >> "$md_file"
done

            # Remove the first line from any index.md files and add the header and footer
            find "$target_dir" -type f -name "*.sh" | while read -r sh_file; do
                if [ -f "$sh_file" ]; then
                    # Add the header at the beginning of the file
                    rm -rf "$sh_file"
                fi
            done

            # Remove the first line from any index.md files and add the header and footer
            find "$target_dir" -type f -name "*.py" | while read -r py_file; do
                if [ -f "$py_file" ]; then
                    # Add the header at the beginning of the file
                    rm -rf "$py_file"
                fi
            done

            # Copy the LICENSE file
            echo "Copying LICENSE file to $target_dir"
            cp "${TRASHGUIDES_DIR}/LICENSE" "$target_dir"
        else
            echo "No match found for $folder_name in TRaSH-Guides."
        fi
    fi
done

echo "Script completed successfully."
