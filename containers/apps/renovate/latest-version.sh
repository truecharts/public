# curl -s "https://api.github.com/repos/truecharts/clustertool/releases/latest" | jq -r '.name' | sed 's/^clustertool-v//'
echo "2.0.0-BETA-8"
