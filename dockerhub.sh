#!/bin/bash

# Find all values.yaml files in subdirectories
find . -type f -name "values.yaml" | while read -r file; do
    echo "Checking $file"

    # Extract repository references matching docker.io/*
    grep -oE 'repository: docker.io/[^[:space:]]+' "$file" | while read -r line; do
        repo=$(echo "$line" | cut -d ' ' -f2 | sed 's|docker.io/||')

        # Check if equivalent ghcr.io, public.ecr.aws, or gcr.io repositories exist
        ghcr_url="https://ghcr.io/v2/$repo/tags/list"
        quay_url="https://quay.io/v2/$repo/tags/list"
        ecr_url="https://public.ecr.aws/v2/$repo/tags/list"
        gcr_url="https://mirror.gcr.io/v2/$repo/tags/list"

        ghcr_exists=$(curl -s -o /dev/null -w "%{http_code}" "$ghcr_url")
        quay_exists=$(curl -s -o /dev/null -w "%{http_code}" "$quay_url")
        ecr_exists=$(curl -s -o /dev/null -w "%{http_code}" "$ecr_url")
        gcr_exists=$(curl -s -o /dev/null -w "%{http_code}" "$gcr_url")

        new_repo="docker.io/$repo"
        if [[ "$ghcr_exists" == "200" ]]; then
            new_repo="ghcr.io/$repo"
        elif [[ "$ecr_exists" == "200" ]]; then
            new_repo="public.ecr.aws/$repo"
        elif [[ "$gcr_exists" == "200" ]]; then
            new_repo="mirror.gcr.io/$repo"
        fi
        if [[ $new_repo != "" ]]; then
          # Replace repository reference in the file
          sed -i '' "s|repository: docker.io/$repo|repository: $new_repo|g" "$file"
          ## For Linux
          # sed -i "s|repository: docker.io/$repo|repository: $new_repo|g" "$file"
          echo "Updated repository in $file to $new_repo"
        fi
    done
done
