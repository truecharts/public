---
title: Traefik
---

## Setup

For Traefik you will need to install the upstream traefik chart.
Our advised solution for Traefik is to not differentiate between internal and external. Instead we advice using an IP-Whitelist or use tunneling to limit
access for some domains to local.

### Example values

```yaml
# https://artifacthub.io/packages/helm/traefik/traefik?modal=values
deployment:
  enabled: true
  replicas: 2
service:
  enabled: true
  type: LoadBalancer
  annotations:
    metallb.io/ip-allocated-from-pool: main
    metallb.io/loadBalancerIPs: ${TRAEFIK_IP}
  spec:
    externalTrafficPolicy: Local
logs:
  general:
    level: INFO
  access:
    enabled: true
ingressClass:
  enabled: true
  isDefaultClass: true
tlsOptions:
  default:
    minVersion: VersionTLS12
    maxVersion: VersionTLS13
    sniStrict: true
providers:
  kubernetesCRD:
    enabled: true
    allowCrossNamespace: true
    allowExternalNameServices: true
tlsStore:
  default:
    defaultCertificate:
      secretName: "${SECRET_PUBLIC_DOMAIN/./-}-tls"
ports:
  traefik:
    expose:
      default: true
  web:
    redirections:
      port: websecure
  websecure:
    tls:
      enabled: true
      options: "default"
```

## Middleware Examples

Here we will showcase some middlewares you can use to customise your traefik ingress behavior.
For more information and all available options, please checkout common ingress docs (TODO: add link to common docs)

### General

To setup a middleware you can specify it in the values of the chart you want to use it in:

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      data:
        address: some-address
```

Additionally you have to add them to your ingress like this:

```yaml
ingress:
  main:
    enabled: true
    integrations:
      traefik:
        enabled: true
        entrypoints:
        - websecure
        middlewares:
        - name: traefik-regex
          namespace: traefik
        - name: auth
          namespace: traefik
```

### Authelia Example

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: forward-auth
      data:
        address: http://authelia.authelia.svc.cluster.local:9091/api/verify
        authResponseHeadersRegex: ''
        trustForwardHeader: true
        authResponseHeaders:
          - Remote-User
          - Remote-Groups
          - Remote-Name
          - Remote-Email
        authRequestHeaders:  []
        tls:
          insecureSkipVerify: true
```

### IP Whitelist

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: ip-allow-list
      data:
        sourceRange:
          - 192.168.178.0/24
        ipStrategy:
          depth: 1
          excludedIPs:
            - some-excluded-ip
```

### Themepart

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: plugin-theme-park
      data:
        pluginName: my-plugin-name
        app: sonarr
        theme: dark
        baseUrl: https://theme-park.dev
        addons:
          - some-addon
          - some-other-addon
```

### Redirect Regex

```yaml
ingressMiddlewares:
  traefik:
    middleware-name:
      enabled: true
      type: redirect-regex
      data:
        regex: some-regex
        replacement: some-replacement
        permanent: true
```

More Examples can be found in the common docs [here](/common/middlewares/traefik/).
