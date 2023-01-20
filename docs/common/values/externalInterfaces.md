# External Interfaces

## Key: externalInterfaces

Info:

- Type: `list`
- Default: `[]`
- Helm Template: ❌

Can be defined in:

- `.Values`.externalInterfaces

---

It's used in SCALE GUI. Configuration added in this key (from the GUI),
is parsed from the middleware. Middleware then injects 2 other `lists`.
`ixExternalInterfacesConfiguration` and`ixExternalInterfacesConfigurationNames`.
Which are parsed from the Chart to create the objects.

Examples:

```yaml
externalInterfaces:
  - hostInterface: ens4
    ipam:
      type: dhcp
```

With the above example middleware will output something like the bellow:

```yaml
ixExternalInterfacesConfiguration: []
  - '{"cniVersion": "0.3.1", "name": "ix-RELEASE-NAME-0", "type": "macvlan", "master": "ens4", "ipam": {"type": "dhcp"}}'

ixExternalInterfacesConfigurationNames: []
  - ix-RELEASE-NAME-0
```

Chart will add an annotation to the deployment like this
`k8s.v1.cni.cncf.io/networks: ix-RELEASE-NAME-0`.

If more than one `ixExternalInterfacesConfigurationNames` presents,
annotation looks like `k8s.v1.cni.cncf.io/networks: ix-RELEASE-NAME-0, ix-RELEASE-NAME-1`.

Also for each item in `ixExternalInterfacesConfiguration` will create a
`NetworkAttachmentDefinition` object and adding the item to `spec.config` as is.
Name will be `ix-RELEASE-NAME-$index`

Other examples:

```yaml
externalInterfaces:
  - hostInterface: ens3
    ipam:
      type: static
    # Only available when type equals static
    staticIPConfigurations:
      - 1.2.3.4
    # Only available when type equals static
    staticRoutes:
      - destination: 1.2.3.4
        gateway: 1.2.3.4
```

`hostInterface` values are generated from the SCALE GUI
