---
title: NGINX
---


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
