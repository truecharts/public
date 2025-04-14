---
title: NGINX
---

## Setup

For NGINX we will setup 2 ingress controllers: Internal and External.
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

  values:
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

## Annotations Examples

Here we will showcase some annotations you can use to customise your NGINX ingress behavior

### Redirect to Https

```yaml
annotations:
  nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
```

### Auth

#### Authelia

```yaml
annotations:
  nginx.ingress.kubernetes.io/auth-method: 'GET'
  nginx.ingress.kubernetes.io/auth-url: 'http://authelia.authelia.svc.cluster.local:9091/api/verify'
  nginx.ingress.kubernetes.io/auth-signin: 'https://auth.${DOMAIN_1}?rm=$request_method'
  nginx.ingress.kubernetes.io/auth-response-headers: 'Remote-User,Remote-Name,Remote-Groups,Remote-Email'
```

#### Authentik

When using Authentik, take care to configure the service as follows. 

```yaml
ingress:
  main:
    enabled: true
    primary: true
    ingressClassName: external
    annotations:
      nginx.ingress.kubernetes.io/backend-protocol: "HTTPS"
      nginx.ingress.kubernetes.io/ssl-passthrough: "true"
      nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
    integrations:
      traefik:
        enabled: false
      certManager:
        enabled: true
        certificateIssuer: "letsencrypt"
    hosts:
      - host: "auth.${DOMAIN_1}"
  proxy:
    enabled: true
    advanced: false
    ingressClassName: external
    integrations:
      traefik:
        enabled: false
      certManager:
        certificateIssuer: "letsencrypt"
        enabled: true
    tls: []
    hosts:
      - host: "auth-proxy.${DOMAIN_1}"
```

For domain-level forward auth, you must configure the embedded outpost first (please refer to
Authentik's docs). The basic steps are to create a provider and application, then enable the embedded outpost for your newly created application.

Once that has been done, configure each service you wish to place behind Authentik as follows:

```yaml
ingress:
  main:
    enabled: true
    primary: true
    ingressClassName: internal
    annotations:
      nginx.ingress.kubernetes.io/auth-url: http://authentik-http.authentik.svc.cluster.local:10230/outpost.goauthentik.io/auth/nginx
      nginx.ingress.kubernetes.io/auth-signin: https://auth.${DOMAIN_1}/outpost.goauthentik.io/start?rd=$scheme://$http_host$escaped_request_uri
      nginx.ingress.kubernetes.io/auth-response-headers: Set-Cookie,X-authentik-username,X-authentik-groups,X-authentik-entitlements,X-authentik-email,X-authentik-name,X-authentik-uid
      nginx.ingress.kubernetes.io/auth-snippet: proxy_set_header X-Forwarded-Host $http_host;
```

### IP Whitelist

```yaml
annotations:
  nginx.ingress.kubernetes.io/whitelist-source-range: 49.36.X.X/32
```

### Themepark

```yaml
annotations:
  nginx.ingress.kubernetes.io/configuration-snippet: |
      proxy_set_header Accept-Encoding "";
      sub_filter
      '</head>'
      '<link rel="stylesheet" type="text/css" href="https://gilbn.github.io/theme.park/CSS/themes/APP_NAME/THEME.css">
      </head>';
      sub_filter_once on;
```

### Redirect-Regex

```yaml
annotations:
  nginx.ingress.kubernetes.io/configuration-snippet: |
    rewrite ^/$ /admin permanent;
```
