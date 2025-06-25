curl -s "https://api.github.com/repos/truecharts/public/releases/latest" | jq -r '.name' | sed 's/^clustertool-v//'
