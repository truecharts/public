# inventree

![Version: 3.0.24](https://img.shields.io/badge/Version-3.0.24-informational?style=flat-square) ![AppVersion: 0.7.5](https://img.shields.io/badge/AppVersion-0.7.5-informational?style=flat-square)

InvenTree is an open-source Inventory Management System which provides powerful low-level stock control and part tracking.

**Homepage:** <https://github.com/truecharts/apps/tree/master/charts/incubator/inventree>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| TrueCharts | info@truecharts.org | https://truecharts.org |

## Source Code

* <https://inventree.readthedocs.io>
* <https://github.com/inventree/InvenTree>

## Requirements

Kubernetes: `>=1.16.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://charts.truecharts.org/ | postgresql | 8.0.30 |
| https://charts.truecharts.org | redis | 3.0.30 |
| https://library-charts.truecharts.org | common | 10.4.4 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| additionalContainers.nginx.image | string | `"{{ .Values.nginxImage.repository }}:{{ .Values.nginxImage.tag }}"` |  |
| additionalContainers.nginx.name | string | `"nginx"` |  |
| additionalContainers.nginx.ports[0].containerPort | int | `10231` |  |
| additionalContainers.nginx.ports[0].name | string | `"main"` |  |
| additionalContainers.nginx.securityContext.readOnlyRootFilesystem | bool | `false` |  |
| additionalContainers.nginx.securityContext.runAsGroup | int | `100` |  |
| additionalContainers.nginx.securityContext.runAsNonRoot | bool | `false` |  |
| additionalContainers.nginx.securityContext.runAsUser | int | `0` |  |
| additionalContainers.nginx.volumeMounts[0].mountPath | string | `"/etc/nginx/conf.d/default.conf"` |  |
| additionalContainers.nginx.volumeMounts[0].name | string | `"inventree-config"` |  |
| additionalContainers.nginx.volumeMounts[0].readOnly | bool | `true` |  |
| additionalContainers.nginx.volumeMounts[0].subPath | string | `"nginx-config"` |  |
| additionalContainers.nginx.volumeMounts[1].mountPath | string | `"/var/www"` |  |
| additionalContainers.nginx.volumeMounts[1].name | string | `"data"` |  |
| additionalContainers.worker.command[0] | string | `"invoke"` |  |
| additionalContainers.worker.command[1] | string | `"worker"` |  |
| additionalContainers.worker.env[0].name | string | `"INVENTREE_DB_ENGINE"` |  |
| additionalContainers.worker.env[0].value | string | `"postgresql"` |  |
| additionalContainers.worker.env[1].name | string | `"INVENTREE_DB_NAME"` |  |
| additionalContainers.worker.env[1].value | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| additionalContainers.worker.env[2].name | string | `"INVENTREE_DB_USER"` |  |
| additionalContainers.worker.env[2].value | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| additionalContainers.worker.env[3].name | string | `"INVENTREE_DB_PORT"` |  |
| additionalContainers.worker.env[3].value | string | `"5432"` |  |
| additionalContainers.worker.env[4].name | string | `"INVENTREE_CACHE_PORT"` |  |
| additionalContainers.worker.env[4].value | string | `"6379"` |  |
| additionalContainers.worker.env[5].name | string | `"INVENTREE_CACHE_HOST"` |  |
| additionalContainers.worker.env[5].valueFrom.secretKeyRef.key | string | `"plainhostpass"` |  |
| additionalContainers.worker.env[5].valueFrom.secretKeyRef.name | string | `"rediscreds"` |  |
| additionalContainers.worker.env[6].name | string | `"INVENTREE_DB_HOST"` |  |
| additionalContainers.worker.env[6].valueFrom.secretKeyRef.key | string | `"plainhost"` |  |
| additionalContainers.worker.env[6].valueFrom.secretKeyRef.name | string | `"dbcreds"` |  |
| additionalContainers.worker.env[7].name | string | `"INVENTREE_DB_PASSWORD"` |  |
| additionalContainers.worker.env[7].valueFrom.secretKeyRef.key | string | `"postgresql-password"` |  |
| additionalContainers.worker.env[7].valueFrom.secretKeyRef.name | string | `"dbcreds"` |  |
| additionalContainers.worker.env[8].name | string | `"INVENTREE_SECRET_KEY"` |  |
| additionalContainers.worker.env[8].valueFrom.secretKeyRef.key | string | `"INVENTREE_SECRET_KEY"` |  |
| additionalContainers.worker.env[8].valueFrom.secretKeyRef.name | string | `"inventree-secrets"` |  |
| additionalContainers.worker.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| additionalContainers.worker.name | string | `"worker"` |  |
| additionalContainers.worker.volumeMounts[0].mountPath | string | `"/home/inventree/data"` |  |
| additionalContainers.worker.volumeMounts[0].name | string | `"data"` |  |
| configmap.config.data.nginx-config | string | `"server {\n  listen 10231;\n  real_ip_header proxy_protocol;\n  location / {\n      proxy_set_header      Host              $http_host;\n      proxy_set_header      X-Forwarded-By    $server_addr:$server_port;\n      proxy_set_header      X-Forwarded-For   $remote_addr;\n      proxy_set_header      X-Forwarded-Proto $scheme;\n      proxy_set_header      X-Real-IP         $remote_addr;\n      proxy_set_header      CLIENT_IP         $remote_addr;\n      proxy_pass_request_headers on;\n      proxy_redirect off;\n      client_max_body_size 100M;\n      proxy_buffering off;\n      proxy_request_buffering off;\n      proxy_pass http://localhost:8000;\n  }\n  # Redirect any requests for static files\n  location /static/ {\n      alias /var/www/static/;\n      autoindex on;\n      # Caching settings\n      expires 30d;\n      add_header Pragma public;\n      add_header Cache-Control \"public\";\n  }\n  # Redirect any requests for media files\n  location /media/ {\n      alias /var/www/media/;\n      # Media files require user authentication\n      auth_request /auth;\n  }\n  # Use the 'user' API endpoint for auth\n  location /auth {\n      internal;\n      proxy_pass http://localhost:8000/auth/;\n      proxy_pass_request_body off;\n      proxy_set_header Content-Length \"\";\n      proxy_set_header X-Original-URI $request_uri;\n  }\n}"` |  |
| configmap.config.enabled | bool | `true` |  |
| env.INVENTREE_CACHE_HOST.secretKeyRef.key | string | `"plainhostpass"` |  |
| env.INVENTREE_CACHE_HOST.secretKeyRef.name | string | `"rediscreds"` |  |
| env.INVENTREE_CACHE_PORT | string | `"6379"` |  |
| env.INVENTREE_DB_ENGINE | string | `"postgresql"` |  |
| env.INVENTREE_DB_HOST.secretKeyRef.key | string | `"plainhost"` |  |
| env.INVENTREE_DB_HOST.secretKeyRef.name | string | `"dbcreds"` |  |
| env.INVENTREE_DB_NAME | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| env.INVENTREE_DB_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| env.INVENTREE_DB_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| env.INVENTREE_DB_PORT | string | `"5432"` |  |
| env.INVENTREE_DB_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| env.INVENTREE_DEBUG | bool | `false` |  |
| env.INVENTREE_LOGIN_ATTEMPTS | int | `5` |  |
| env.INVENTREE_LOGIN_CONFIRM_DAYS | int | `3` |  |
| env.INVENTREE_LOG_LEVEL | string | `"INFO"` |  |
| env.INVENTREE_PLUGINS_ENABLED | bool | `false` |  |
| env.INVENTREE_SECRET_KEY.secretKeyRef.key | string | `"INVENTREE_SECRET_KEY"` |  |
| env.INVENTREE_SECRET_KEY.secretKeyRef.name | string | `"inventree-secrets"` |  |
| env.INVENTREE_TIMEZONE | string | `"{{ .Values.TZ }}"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/inventree"` |  |
| image.tag | string | `"v0.7.5@sha256:7677153653b26249ffb97430b0b95943e820256bbacbb8b4d0cd565759b7ce0b"` |  |
| initContainers.init-migrate.args[0] | string | `"cd /home/inventree;\ninvoke update;"` |  |
| initContainers.init-migrate.command[0] | string | `"sh"` |  |
| initContainers.init-migrate.command[1] | string | `"-c"` |  |
| initContainers.init-migrate.env[0].name | string | `"INVENTREE_DB_ENGINE"` |  |
| initContainers.init-migrate.env[0].value | string | `"postgresql"` |  |
| initContainers.init-migrate.env[1].name | string | `"INVENTREE_DB_NAME"` |  |
| initContainers.init-migrate.env[1].value | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| initContainers.init-migrate.env[2].name | string | `"INVENTREE_DB_USER"` |  |
| initContainers.init-migrate.env[2].value | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| initContainers.init-migrate.env[3].name | string | `"INVENTREE_DB_PORT"` |  |
| initContainers.init-migrate.env[3].value | string | `"5432"` |  |
| initContainers.init-migrate.env[4].name | string | `"INVENTREE_CACHE_PORT"` |  |
| initContainers.init-migrate.env[4].value | string | `"6379"` |  |
| initContainers.init-migrate.env[5].name | string | `"INVENTREE_CACHE_HOST"` |  |
| initContainers.init-migrate.env[5].valueFrom.secretKeyRef.key | string | `"plainhostpass"` |  |
| initContainers.init-migrate.env[5].valueFrom.secretKeyRef.name | string | `"rediscreds"` |  |
| initContainers.init-migrate.env[6].name | string | `"INVENTREE_DB_HOST"` |  |
| initContainers.init-migrate.env[6].valueFrom.secretKeyRef.key | string | `"plainhost"` |  |
| initContainers.init-migrate.env[6].valueFrom.secretKeyRef.name | string | `"dbcreds"` |  |
| initContainers.init-migrate.env[7].name | string | `"INVENTREE_DB_PASSWORD"` |  |
| initContainers.init-migrate.env[7].valueFrom.secretKeyRef.key | string | `"postgresql-password"` |  |
| initContainers.init-migrate.env[7].valueFrom.secretKeyRef.name | string | `"dbcreds"` |  |
| initContainers.init-migrate.env[8].name | string | `"INVENTREE_SECRET_KEY"` |  |
| initContainers.init-migrate.env[8].valueFrom.secretKeyRef.key | string | `"INVENTREE_SECRET_KEY"` |  |
| initContainers.init-migrate.env[8].valueFrom.secretKeyRef.name | string | `"inventree-secrets"` |  |
| initContainers.init-migrate.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| initContainers.init-migrate.name | string | `"init-migrate"` |  |
| initContainers.init-migrate.volumeMounts[0].mountPath | string | `"/home/inventree/data"` |  |
| initContainers.init-migrate.volumeMounts[0].name | string | `"data"` |  |
| nginxImage.repository | string | `"tccr.io/truecharts/nginx"` |  |
| nginxImage.tag | string | `"v1.23.0@sha256:4545dec2db20dd215a48d03ff65887cd4abae935f6876cd1f8d0d44a3b6ced32"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/home/inventree/data"` |  |
| persistence.inventree-config.enabled | string | `"true"` |  |
| persistence.inventree-config.mountPath | string | `"/etc/nginx/nginx.conf"` |  |
| persistence.inventree-config.subPath | string | `"nginx-confing"` |  |
| persistence.inventree-config.type | string | `"custom"` |  |
| persistence.inventree-config.volumeSpec.configMap.name | string | `"{{ printf \"%v-config\" (include \"tc.common.names.fullname\" .) }}"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `100` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"inventree"` |  |
| postgresql.postgresqlUsername | string | `"inventree"` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| secretEnv.INVENTREE_ADMIN_EMAIL | string | `"test@example.com"` |  |
| secretEnv.INVENTREE_ADMIN_PASSWORD | string | `"secret"` |  |
| secretEnv.INVENTREE_ADMIN_USER | string | `"testuser"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.main.ports.main.port | int | `10231` |  |
| service.main.ports.main.targetPort | int | `10231` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v0.1.1](https://github.com/k8s-at-home/helm-docs/releases/v0.1.1)
