#!/usr/bin/sudo bash

deploy_cni(){
rm -rf ./src/deps/cni/charts || true
rm -f ./src/deps/cni/values.yaml || true
cat ./cluster/kube-system/cilium/app/cilium-values.yaml > ./src/deps/cni/values.yaml
kustomize build --enable-helm ./src/deps/cni | kubectl apply -f -
rm -f ./src/deps/cni/values.yaml || true
rm -rf ./src/deps/csr-approver/charts || true
}
export deploy_cni

deploy_approver(){
rm -rf ./src/deps/csr-approver/charts || true
kustomize build --enable-helm ./src/deps/csr-approver | kubectl apply -f -
rm -rf ./src/deps/csr-approver/charts || true
popd >/dev/null 2>&1
}
export deploy_approver

deploy_metallb(){
rm -rf ./src/deps/metallb/charts || true
kustomize build --enable-helm ./src/deps/metallb | kubectl apply -f -
rm -rf ./src/deps/metallb/charts || true
popd >/dev/null 2>&1
}
export deploy_metallb

deploy_metallb_config(){
rm -rf ./src/deps/metallb-config/charts || true
kustomize build --enable-helm ./src/deps/metallb-config | kubectl apply -f -
rm -rf ./src/deps/metallb-config/charts || true
popd >/dev/null 2>&1
}
export deploy_metallb_config

deploy_openebs(){
rm -rf ./src/deps/openebs/charts || true
kustomize build --enable-helm ./src/deps/openebs | kubectl apply -f -
rm -rf ./src/deps/openebs/charts || true
popd >/dev/null 2>&1
}
export deploy_openebs

deploy_kubeapps(){
rm -rf ./src/deps/kubeapps/charts || true
kustomize build --enable-helm ./src/deps/kubeapps | kubectl apply -f -
rm -rf ./src/deps/kubeapps/charts || true
popd >/dev/null 2>&1
echo "KubeApps Token can be recieved using: kubectl create token kubeapps-kubeapps"
echo "Current token:"
kubectl create token kubeapps-kubeapps
}
export deploy_kubeapps
