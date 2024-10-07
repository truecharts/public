#!/usr/bin/sudo bash

regen(){
echo ""
echo "-----"
echo "Regenerating TalosOS Cluster Config..."
echo "-----"
# Prep precommit
echo "Update Pre-commit hooks..."
pre-commit install || echo "Install pre-commit hooks failed, continuing..."

echo "Ensuring schema is installed..."
talhelper genschema

# Generate age key if not present
if test -f "age.agekey"; then
  echo "Age Encryption Key already exists, skipping..."
else
  echo "Generating Age Encryption Key..."
  age-keygen -o age.agekey
  # Save an encrypted version of the age key, encrypted with itself
  cat age.agekey | age -r age1ql3z7hjy54pw3hyww5ayyfg7zqgvc7w3j2elw8zmrj2kg5sfn9aqmcac8p > age.agekey.enc
fi

echo "Generating sops.yaml from template"
AGE=$(cat age.agekey | grep public | sed -e "s|# public key: ||" )
cat templates/.sops.yaml.templ | sed -e "s|!!AGE!!|$AGE|"  > .sops.yaml

echo "Creating agekey cluster patch..."
rm -rf patches/sopssecret.yaml || true
cat templates/sopssecret.yaml.templ | sed -e "s|!!AGEKEY!!|$( base64 age.agekey -w0 )|" > patches/sopssecret.yaml

if test -f "talsecret.yaml"; then
  echo "Talos Secret already exists, skipping..."
else
  echo "Generating Talos Secret"
  talhelper gensecret >>  talsecret.yaml
fi

echo "(re)generating config..."
# Uncomment to generate new node configurations
talhelper genconfig

echo "verifying config..."
talhelper validate talconfig

echo "(re)generating chart-config"
rm -f ./cluster/main/flux-system/clustersettings.yaml || true
cp ./templates/clustersettings.yaml.templ ./cluster/main/flux-config/app/clustersettings.secret.yaml
sed "s/^/  /" talenv.yaml >> ./cluster/main/flux-config/app/clustersettings.secret.yaml

echo "(re)generating included helm-charts"
rm -f ./src/deps/kubeapps/values.yaml || true
cp ./templates/kubeappsvalues.yaml.templ ./src/deps/kubeapps/values.yaml
sed -i "s/KUBEAPPS_IP/${KUBEAPPS_IP}/" ./src/deps/kubeapps/values.yaml

rm -f ./src/deps/metallb-config/values.yaml || true
cp ./templates/metallbconfigvalues.yaml.templ ./src/deps/metallb-config/values.yaml
sed -i "s/KUBEAPPS_IP/${METALLB_RANGE}/" ./src/deps/metallb-config/values.yaml

}
export -f regen