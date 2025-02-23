---
title: Files and Folders
---

File and Folder structure on init, is as follows

## Created Files and Folders

- talconfig.yaml -> Contains your Talos Cluster layout
- clusterenv.yaml -> Contains configuration options for both your Charts and Talos Cluster
- talsecret.yaml -> Contains Talos Cluster encryption keys
- age.agekey -> Contains SOPS encryption keys which can be used to encrypt data. It's **IMPERATIVE** you save this specific file elsewhere as a backup,
not doing so *will* result in future data loss
- .sops.yaml -> Contains specifications on how to decrypt any encrypted files found
- .pre-commit-config.yaml -> Contains configurations for users of "pre-commit"
- talconfig.json -> Contains the validations "schema" for talconfig.yaml
- /patches/ -> This folder contains our custom Talos Machine Configuration patches, these should not be altered by any end-user. however,
 you can add your own here
- /generated/ -> This folder will contain some pre-generated files that will be used to bootstrap the cluster and,
if configured, can be consumed by fluxcd for automatic updates and manual configuration
- .devcontainer -> Contains a preconfigured dev-container for vscode usage of clustertool
- .vscode -> Contains recommended extensions for your talos cluster in vscode
- /repositories/ -> Contains all repositories used within fluxcd helm-releases
- /clusters/ -> Contains all kubernetes clusters you run within the same clustertool github repo
- /kubernetes/ -> Contains all the files of your kubernetes cluster
