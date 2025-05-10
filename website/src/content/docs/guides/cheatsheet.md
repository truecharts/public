---
title: Cluster Cheatsheet
---

This page contains a useful selection of commands to troubleshoot and manage your cluster.

## Fluxcd

Show all Flux Resources:

```bash
flux get all -A
```

Show all Kustomizations:

```bash
flux get ks -A
```

Show all Helm-Releases:

```bash
flux get hr -A
```

Reconcile your cluster:

```bash
flux reconcile source git cluster
```

Show all Flux objects which are not ready:

```bash
flux get all -A --status-selector ready=false
```

## Helm

Get Values from a running deployment:

```bash
helm get values -n <namespace> <deployment-name>
```

## Kubectl

Most of the following commands can be adapted to either show all namespaces `-A` or only show a specific namespace with `-n <namespace>`. Examples use the all namespaces flag.
Additionally you can use additional commands like `grep` to sort and filter your results.

Show all Running Pods

```bash
kubectl get pods -A
```

Show all Services:

```bash
kubectl get svc -A
```

Show events:

```bash
kubectl get events -A
```

Describe a pod:

```bash
kubectl describe pod -n <namespace> podname
```

As you can see kubectl follows a certain pattern.
The usual format is
```bash
kubectl (get/describe/delete/edit) <resource-type> -n <namespace>
```

An exception to this pattern is the logs command:

```bash
kubectl logs -n <namespace> <pod-name>
```


## Talosctl

Show talos dashboard:

```bash
talosctl dashboard
```

Show talos kernel logs:

```bash
talosctl dmesg
```
