---
title: NGINX
---

## Setup

For NGINX we will deploy two ingress controllers: Internal and External.
Where External is either forwarded by your router or, for example, a cloudflare tunnel.
Internal, however, is not routed anywhere and is used as a safe default to just have charts reached from your internal network only.

### Example setup

Here are example values to configure both Internal and External
Please note the IP variables that need to be set to your specific configuration wishes and the use of metallb, that also has to be configured correctly

#### Internal

```yaml
controller:
  replicaCount: 2
  service:
    externalTrafficPolicy: Local
    annotations:
      metallb.io/ip-allocated-from-pool: main
      metallb.io/loadBalancerIPs: ${NGINX_INTERNAL_IP}
  ingressClassByName: true
  watchIngressWithoutClass: true
  ingressClassResource:
    name: internal
    default: true
    controllerValue: k8s.io/internal
  config:
    allow-snippet-annotations: true
    annotations-risk-level: Critical
    client-body-buffer-size: 100M
    client-body-timeout: 120
    client-header-timeout: 120
    enable-brotli: "true"
    enable-ocsp: "true"
    enable-real-ip: "true"
    force-ssl-redirect: "true"
    hide-headers: Server,X-Powered-By
    hsts-max-age: "31449600"
    keep-alive-requests: 10000
    keep-alive: 120
    proxy-body-size: 0
    proxy-buffer-size: 16k
    proxy-busy-buffers-size: 32k
    ssl-protocols: TLSv1.3 TLSv1.2
    use-forwarded-headers: "true"
  metrics:
    enabled: true
  extraArgs:
    default-ssl-certificate: "clusterissuer/certificate-issuer-general-wildcard"
    publish-status-address: ${NGINX_INTERNAL_IP}
  terminationGracePeriodSeconds: 120
  publishService:
    enabled: false
  resources:
    requests:
      cpu: 100m
    limits:
      memory: 500Mi
defaultBackend:
  enabled: false
```

#### External

```yaml
controller:
  replicaCount: 2
  service:
    externalTrafficPolicy: Local
    annotations:
      metallb.io/ip-allocated-from-pool: main
      metallb.io/loadBalancerIPs: ${NGINX_EXTERNAL_IP}
  ingressClassByName: true
  watchIngressWithoutClass: false
  ingressClassResource:
    name: external
    default: false
    controllerValue: k8s.io/external
  config:
    allow-snippet-annotations: true
    annotations-risk-level: Critical
    client-body-buffer-size: 100M
    client-body-timeout: 120
    client-header-timeout: 120
    enable-brotli: "true"
    enable-ocsp: "true"
    enable-real-ip: "true"
    force-ssl-redirect: "true"
    hide-headers: Server,X-Powered-By
    hsts-max-age: "31449600"
    keep-alive-requests: 10000
    keep-alive: 120
    proxy-body-size: 0
    proxy-buffer-size: 16k
    proxy-busy-buffers-size: 32k
    ssl-protocols: TLSv1.3 TLSv1.2
    use-forwarded-headers: "true"
  metrics:
    enabled: true
  extraArgs:
    default-ssl-certificate: "clusterissuer/certificate-issuer-general-wildcard"
    publish-status-address: ${NGINX_EXTERNAL_IP}
  terminationGracePeriodSeconds: 120
  publishService:
    enabled: false
  resources:
    requests:
      cpu: 100m
    limits:
      memory: 500Mi
defaultBackend:
  enabled: false
```

### Using the IngressClasses

You can set charts to use either of them by specifying either:
`ingressClassName: internal`
or
`ingressClassName: external`

## Nginx Integration examples

Our Common-Chart offers some Nginx Integrations which save some time compared to manually setting the annotations.
These can be configured in the following section of the ingress which is `disabled` by default:

```yaml

ingress:
    main:
      integrations:
        nginx:
          #disabled by default
          enabled: true
```

In the following sections only the nginx part is shown for simplicity.

### Authelia

```yaml
nginx:
  enabled: true
  auth:
    type: "authelia"
    internalHost: "authelia.authelia.svc.cluster.local:9091"
    externalHost: "auth.${DOMAIN_1}"
    # Can be left default in most cases
    responseHeaders: []
```

### Authentik

When using Authentik, take care to configure the service as follows.

```yaml
annotations:
  nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
  nginx.ingress.kubernetes.io/ssl-passthrough: "true"
  nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
```

For domain-level forward auth, you must configure the embedded outpost first (please refer to
[Authentik's docs](https://truecharts.org/charts/stable/authentik/how_to/)). The basic steps are
to create a provider and application, then enable the embedded outpost for your newly created application.

Once that has been done, configure each service you wish to place behind Authentik as follows:

```yaml
nginx:
  enabled: true
  auth:
    type: "authentik"
    internalHost: "authentik-http.authentik.svc.cluster.local:10230"
    externalHost: "auth.${DOMAIN_1}"
    # Can be left default in most cases
    responseHeaders: []
```

### IP Whitelist

```yaml
nginx:
  enabled: true
  ipWhitelist: [49.36.X.X/32]
```

### Themepark

```yaml
nginx:
  enabled: true
  themepark:
    enabled: true
    css: "https://gilbn.github.io/theme.park/CSS/themes/APP_NAME/THEME.css"
```

## Annotations Examples

Here we will showcase some annotations you can use to customize your NGINX ingress behavior

### Redirect to Https

```yaml
annotations:
  nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
```

### Redirect-Regex

```yaml
annotations:
  nginx.ingress.kubernetes.io/configuration-snippet: |
    rewrite ^/$ /admin permanent;
```
