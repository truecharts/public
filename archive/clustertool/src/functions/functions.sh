#!/usr/bin/sudo bash

source ./src/functions/encryption.sh
source ./src/functions/deploy-extras.sh
source ./src/functions/nodeHealth.sh
source ./src/functions/clusterHealth.sh
source ./src/functions/approve-certs.sh
source ./src/functions/apply-kubeconfig.sh
source ./src/functions/bootstrap-flux.sh
source ./src/functions/parse-yaml-env.sh
source ./src/functions/install-deps.sh
source ./src/functions/title.sh
source ./src/functions/gen-config.sh
source ./src/functions/bootstrap.sh
source ./src/functions/upgrade.sh
source ./src/functions/apply.sh
source ./src/functions/apply-manifests.sh
source ./src/functions/remove-manifests.sh