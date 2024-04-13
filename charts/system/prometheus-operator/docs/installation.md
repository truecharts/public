---
title: Troubleshooting
---

## INSTALLATION FAILED: rendered manifests contain a resource that already exists

### TrueNAS SCALE

If you get

![Error message: [EFAULT] Failed to install App: Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: CustomResourceDefinition "alertmanagerconfigs.monitoring.coreos.com" in namespace "" exists and cannot be imported into the current release: invalid ownership metadata; label validation error: missing key "app.kubernetes.io/managed-by": must be set to "Helm"; annotation validation error: missing key "meta.helm.sh/release-name": must be set to "prometheus-operator"; annotation validation error: missing key "meta.helm.sh/release-namespace": must be set to "ix-prometheus-operator"](./images/install_error_message.webp)

> [EFAULT] Failed to install App: Error: INSTALLATION FAILED: rendered manifests contain a resource that already exists. Unable to continue with install: CustomResourceDefinition "alertmanagerconfigs.monitoring.coreos.com" in namespace "" exists and cannot be imported into the current release: invalid ownership metadata; label validation error: missing key "app.kubernetes.io/managed-by": must be set to "Helm"; annotation validation error: missing key "meta.helm.sh/release-name": must be set to "prometheus-operator"; annotation validation error: missing key "meta.helm.sh/release-namespace": must be set to "ix-prometheus-operator"

you should follow instructions from the [FAQ](https://truecharts.org/manual/FAQ#prometheus-operator) to resolve it

### Helm

On Helm this indicates your previously had a non-TrueCharts version of Prometheus-Operator installed.
Please uninstall all old CRD's before installing our version of Prometheus Operator.

If you don't know how, this might be a good moment to do some research or ask yourself if running DIY clusters is a good idea for your specific knowlage level.
