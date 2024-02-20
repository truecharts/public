#!/usr/bin/env bash
set -o errexit
set -o nounset
set -o pipefail

    # Generate screenshots
    screenshots=""
    if [[ -d "${target}/screenshots" ]]; then
        screenshots=$(ls ${target}/screenshots)
    fi
    if [[ -n $screenshots ]]; then
        echo "screenshots:" >> catalog/${train}/${chartname}/item.yaml
        for screenshot in $screenshots; do
            echo "  - https://truecharts.org/img/hotlink-ok/chart-screenshots/${chartname}/${screenshot}" >> catalog/${train}/${chartname}/item.yaml
        done
    else
        echo "screenshots: []" >> catalog/${train}/${chartname}/item.yaml
    fi
    rm -rf ${target}/screenshots
    # Copy changelog from website
    if [[ ! -f "website/docs/charts/${train}/${chartname}/CHANGELOG.md" ]]; then
        touch "website/docs/charts/${train}/${chartname}/CHANGELOG.md"
    fi
    cp -rf "website/docs/charts/${train}/${chartname}/CHANGELOG.md" "${target}/CHANGELOG.md" 2>/dev/null || :
    # If changelog is empty, add a notice
    if ! grep -q "for the complete changelog, please refer to the website" "${target}/CHANGELOG.md"; then
        echo "Adding changelog notice for: ${chartname}"
        # Count the frontmatter lines
        line_count=$(sed -n '/^---$/,/^---$/p' "${target}/CHANGELOG.md" | wc -l)
        # Increase the line count by 2
        line_count=$((line_count + 2))
        # Add a line to the changelog
        sed -i "${line_count}s/^/*for the complete changelog, please refer to the website*\n\n/" "${target}/CHANGELOG.md"
        sed -i "${line_count}s/^/**Important:**\n/" "${target}/CHANGELOG.md"
    fi
    echo "Truncating changelog for: ${chartname}"
    # Truncate changelog to only contain the last 100 lines
    sed -i '100,$ d' "${target}/CHANGELOG.md" || :
    # Generate SCALE App description file
    cat ${target}/Chart.yaml | yq .description -r >> ${target}/app-readme.md
    echo "" >> ${target}/app-readme.md
    echo "This App is supplied by TrueCharts, for more information visit the manual: [https://truecharts.org/charts/${train}/${chartname}](https://truecharts.org/charts/${train}/${chartname})" >> ${target}/app-readme.md
    echo "" >> ${target}/app-readme.md
    echo "---" >> ${target}/app-readme.md
    echo "" >> ${target}/app-readme.md
    echo "TrueCharts can only exist due to the incredible effort of our staff." >> ${target}/app-readme.md
    echo "Please consider making a [donation](https://truecharts.org/sponsor) or contributing back to the project any way you can!" >> ${target}/app-readme.md
    echo "app-readme generated"
