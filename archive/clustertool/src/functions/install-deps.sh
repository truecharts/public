#!/usr/bin/sudo bash

function install_deps {
cd src/deps
# These have automatic functions to grab latest release, keep it that way.
echo "Installing talosctl..."
curl -SsL https://talos.dev/install | sh > /dev/null || echo "installation failed..."

echo "Installing fluxcli..."
curl -Ss https://fluxcd.io/install.sh |  bash > /dev/null || echo "installation failed..."

echo "Installing kubectl..."
curl -SsLO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" &&  mv kubectl /usr/local/bin/kubectl &&  chmod +x /usr/local/bin/kubectl || echo "installation failed..."

echo "Instaling Helm..."
curl -Ss https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash  || echo "installation failed..."

echo "Installing Kustomize"
rm -f kustomize && curl -Ss "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/kustomize/v5.2.1/hack/install_kustomize.sh" | bash  &&  mv kustomize /usr/local/bin/kustomize &&  chmod +x /usr/local/bin/kustomize || echo "installation failed..."

echo "Installing velerocli..."
curl -Ss https://i.jpillora.com/vmware-tanzu/velero! | bash > /dev/null || echo "installation failed..."

echo "Installing talhelper..."
curl -Ssl https://i.jpillora.com/budimanjojo/talhelper! | bash > /dev/null || echo "installation failed..."

echo "Installing pre-commit..."
pip install pre-commit > /dev/null || pip install pre-commit --break-system-packages > /dev/null || echo "Installing pre-commit failed, non-critical continuing..."

echo "Installing/Updating Pre-commit hooks..."
pre-commit install --install-hooks > /dev/null || echo "installing pre-commit hooks failed, non-critical continuing..."

# TODO ensure these grab the latest releases.
echo "Installing age..."
curl -SsLO https://github.com/FiloSottile/age/releases/download/v1.1.1/age-v1.1.1-linux-amd64.tar.gz && tar -xvzf age-v1.1.1-linux-amd64.tar.gz > /dev/null &&  mv age/age /usr/local/bin/age &&  mv age/age-keygen /usr/local/bin/age-keygen &&  chmod +x /usr/local/bin/age /usr/local/bin/age-keygen

echo "Installing sops..."
curl -SsLO https://github.com/getsops/sops/releases/download/v3.8.1/sops-v3.8.1.linux.amd64 &&  mv sops-v3.8.1.linux.amd64 /usr/local/bin/sops &&  chmod +x /usr/local/bin/sops

echo "Finished installing all dependencies."
cd -
}
export install_deps
