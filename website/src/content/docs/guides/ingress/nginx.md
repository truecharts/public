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

```
    controller:
      replicaCount: 2
      service:
        externalTrafficPolicy: Local
        annotations:
          metallb.io/ip-allocated-from-pool: main
          metallb.io/loadBalancerIPs: ${NGINX_INTERNAL_IP}
          metallb.universe.tf/ip-allocated-from-pool: main
      ingressClassByName: true
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

```

  values:
    controller:
      replicaCount: 2
      service:
        externalTrafficPolicy: Local
        annotations:
          metallb.io/ip-allocated-from-pool: main
          metallb.io/loadBalancerIPs: ${NGINX_EXTERNAL_IP}
          metallb.universe.tf/ip-allocated-from-pool: main
      ingressClassByName: true
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

### Auth

For Authelia, Authentik and more

```
annotations:
  nginx.ingress.kubernetes.io/auth-method: 'GET'
  nginx.ingress.kubernetes.io/auth-url: 'http://authelia.default.svc.cluster.local/api/authz/auth-request'
  nginx.ingress.kubernetes.io/auth-signin: 'https://auth.example.com?rm=$request_method'
  nginx.ingress.kubernetes.io/auth-response-headers: 'Remote-User,Remote-Name,Remote-Groups,Remote-Email'
```

### Themepark

```
annotations:
  nginx.ingress.kubernetes.io/configuration-snippet: |
      proxy_set_header Accept-Encoding "";
      sub_filter
      '</head>'
      '<link rel="stylesheet" type="text/css" href="https://gilbn.github.io/theme.park/CSS/themes/APP_NAME/THEME.css">
      </head>';
      sub_filter_once on;
```
