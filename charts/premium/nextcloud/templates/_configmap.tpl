{{- define "nextcloud.accessurl" -}}
  {{- $accessUrl := .Values.chartContext.appUrl -}}
  {{- if or (contains "127.0.0.1" $accessUrl) (contains "localhost" $accessUrl) -}}
    {{- if .Values.nextcloud.general.accessIP -}}
      {{- $prot := "http" -}}
      {{- $host := .Values.nextcloud.general.accessIP -}}
      {{- $port := .Values.service.main.ports.main.port -}}
      {{/*
        Allowing here to override protocol and port
        should be enough to make it work with any rev proxy
      */}}
      {{- $accessUrl = printf "%v://%v:%v" $prot $host $port -}}
    {{- end -}}
  {{- end -}}

  {{- $accessUrl -}}
{{- end -}}

{{- define "nextcloud.accesshost" -}}
  {{- $accessUrl := (include "nextcloud.accessurl" $) -}}
  {{- $accessHost := regexReplaceAll ".*://(.*)" $accessUrl "${1}" -}}
  {{- $accessHost = regexReplaceAll "(.*):.*" $accessHost "${1}" -}}

  {{- $accessHost -}}
{{- end -}}

{{/* Define the configmap */}}
{{- define "nextcloud.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}
{{- $fqdn := (include "tc.v1.common.lib.chart.names.fqdn" $) -}}
{{- $accessUrl := (include "nextcloud.accessurl" $) -}}
{{- $accessHost := (include "nextcloud.accesshost" $) -}}
{{- $accessHostPort := regexReplaceAll ".*://(.*)" $accessUrl "${1}" -}}
{{- $accessProtocol := regexReplaceAll "(.*)://.*" $accessUrl "${1}" -}}
{{- $redisHost := .Values.redis.creds.plainhost | trimAll "\"" -}}
{{- $redisPass := .Values.redis.creds.redisPassword | trimAll "\"" -}}
{{- $healthHost := "kube.internal.healthcheck" -}}

php-tune:
  enabled: true
  data:
    zz-tune.conf: |
      [www]
      pm.max_children = {{ .Values.nextcloud.php.pm_max_children }}
      pm.start_servers = {{ .Values.nextcloud.php.pm_start_servers }}
      pm.min_spare_servers = {{ .Values.nextcloud.php.pm_min_spare_servers }}
      pm.max_spare_servers = {{ .Values.nextcloud.php.pm_max_spare_servers }}

opcache:
  enabled: true
  data:
    opcache-recommended.ini: |
      opcache.enable=1
      opcache.save_comments=1
      opcache.jit=1255
      opcache.interned_strings_buffer={{ .Values.nextcloud.opcache.interned_strings_buffer }}
      opcache.max_accelerated_files={{ .Values.nextcloud.opcache.max_accelerated_files }}
      opcache.memory_consumption={{ .Values.nextcloud.opcache.memory_consumption }}
      opcache.revalidate_freq={{ .Values.nextcloud.opcache.revalidate_freq }}
      opcache.jit_buffer_size={{ printf "%vM" .Values.nextcloud.opcache.jit_buffer_size }}

redis-session:
  enabled: true
  data:
    redis-session.ini: |
      session.save_handler = redis
      session.save_path = {{ printf "tcp://%v:6379?auth=%v" $redisHost $redisPass | quote }}
      redis.session.locking_enabled = 1
      redis.session.lock_retries = -1
      redis.session.lock_wait_time = 10000

hpb-config:
  enabled: {{ .Values.nextcloud.notify_push.enabled }}
  data:
    NEXTCLOUD_URL: {{ printf "http://%v:%v" $fullname .Values.service.main.ports.main.port }}
    HPB_HOST: {{ $healthHost }}
    CONFIG_FILE: {{ printf "%v/config.php" .Values.persistence.config.targetSelector.notify.notify.mountPath }}
    METRICS_PORT: {{ .Values.service.notify.ports.metrics.port | quote }}

clamav-config:
  enabled: {{ .Values.nextcloud.clamav.enabled }}
  data:
    CLAMAV_NO_CLAMD: "false"
    CLAMAV_NO_FRESHCLAMD: "true"
    CLAMAV_NO_MILTERD: "true"
    CLAMD_STARTUP_TIMEOUT: "1800"

collabora-config:
  enabled: {{ .Values.nextcloud.collabora.enabled }}
  data:
    aliasgroup1: {{ $accessUrl }}
    server_name: {{ $accessHostPort }}
    dictionaries: {{ join " " .Values.nextcloud.collabora.dictionaries }}
    username: {{ .Values.nextcloud.collabora.username | quote }}
    password: {{ .Values.nextcloud.collabora.password | quote }}
    DONT_GEN_SSL_CERT: "true"
    # mount_jail_tree is only used for local storage
    # not needed for WOPI https://github.com/CollaboraOnline/online/issues/3604#issuecomment-989833814
    extra_params: |
      --o:ssl.enable=false
      --o:ssl.termination=true
      --o:net.service_root=/collabora
      --o:home_mode.enable=true
      --o:welcome.enable=false
      --o:logging.level=warning
      --o:logging.level_startup=warning
      --o:security.seccomp=true
      --o:mount_jail_tree=false
      --o:user_interface.mode={{ .Values.nextcloud.collabora.interface_mode }}

nextcloud-config:
  enabled: true
  data:
    {{/* Database */}}
    POSTGRES_DB: {{ .Values.cnpg.main.database | quote }}
    POSTGRES_USER: {{ .Values.cnpg.main.user | quote }}
    POSTGRES_PASSWORD: {{ .Values.cnpg.main.password | trimAll "\"" }}
    POSTGRES_HOST: {{ .Values.cnpg.main.creds.host | trimAll "\"" }}

    {{/* Compatibility Layer to support database changes */}}
    NX_POSTGRES_NAME: {{ .Values.cnpg.main.database | quote }}
    NX_POSTGRES_USER: {{ .Values.cnpg.main.user | quote }}
    NX_POSTGRES_PASSWORD: {{ .Values.cnpg.main.password | trimAll "\"" }}
    NX_POSTGRES_HOST: {{ .Values.cnpg.main.creds.host | trimAll "\"" }}

    {{/* Redis */}}
    NX_REDIS_HOST: {{ $redisHost }}
    NX_REDIS_PASS: {{ $redisPass }}

    {{/* Nextcloud INITIAL credentials */}}
    NEXTCLOUD_ADMIN_USER: {{ .Values.nextcloud.credentials.initialAdminUser | quote }}
    NEXTCLOUD_ADMIN_PASSWORD: {{ .Values.nextcloud.credentials.initialAdminPassword | quote }}

    {{/* PHP Variables */}}
    PHP_MEMORY_LIMIT: {{ .Values.nextcloud.php.memory_limit | quote }}
    PHP_UPLOAD_LIMIT: {{ .Values.nextcloud.php.upload_limit | quote }}

    {{/* Notify Push */}}
    NX_NOTIFY_PUSH: {{ .Values.nextcloud.notify_push.enabled | quote }}
    {{- if .Values.nextcloud.notify_push.enabled }}
    NX_NOTIFY_PUSH_ENDPOINT: {{ $accessUrl }}/push
    {{- end }}

    {{/* Previews */}}
    NX_PREVIEWS: {{ .Values.nextcloud.previews.enabled | quote }}
    NX_PREVIEW_PROVIDERS: {{ join " " .Values.nextcloud.previews.providers }}
    NX_PREVIEW_MAX_X: {{ .Values.nextcloud.previews.max_x | quote }}
    NX_PREVIEW_MAX_Y: {{ .Values.nextcloud.previews.max_y | quote }}
    NX_PREVIEW_MAX_MEMORY: {{ .Values.nextcloud.previews.max_memory | quote }}
    NX_PREVIEW_MAX_FILESIZE_IMAGE: {{ .Values.nextcloud.previews.max_file_size_image | quote }}
    NX_JPEG_QUALITY: {{ .Values.nextcloud.previews.jpeg_quality | quote }}
    NX_PREVIEW_SQUARE_SIZES: {{ .Values.nextcloud.previews.square_sizes | quote }}
    NX_PREVIEW_WIDTH_SIZES: {{ .Values.nextcloud.previews.width_sizes | quote }}
    NX_PREVIEW_HEIGHT_SIZES: {{ .Values.nextcloud.previews.height_sizes | quote }}

    {{/* Imaginary */}}
    NX_IMAGINARY: {{ and .Values.nextcloud.previews.enabled .Values.nextcloud.previews.imaginary | quote }}
    {{- if and .Values.nextcloud.previews.enabled .Values.nextcloud.previews.imaginary }}
    NX_IMAGINARY_URL: {{ printf "http://%v-imaginary:%v" $fullname .Values.service.imaginary.ports.imaginary.port }}
    {{- end }}

    {{/* Expirations */}}
    NX_ACTIVITY_EXPIRE_DAYS: {{ .Values.nextcloud.expirations.activity_expire_days | quote }}
    NX_TRASH_RETENTION: {{ .Values.nextcloud.expirations.trash_retention_obligation | quote }}
    NX_VERSIONS_RETENTION: {{ .Values.nextcloud.expirations.versions_retention_obligation | quote }}

    {{/* General */}}
    NX_RUN_OPTIMIZE: {{ .Values.nextcloud.general.run_optimize | quote }}
    NX_DEFAULT_PHONE_REGION: {{ .Values.nextcloud.general.default_phone_region | quote }}
    NEXTCLOUD_DATA_DIR: {{ .Values.persistence.data.targetSelector.main.main.mountPath }}
    NX_FORCE_ENABLE_ALLOW_LOCAL_REMOTE_SERVERS: {{ .Values.nextcloud.general.force_enable_allow_local_remote_servers | quote }}

    {{/* Files */}}
    NX_SHARED_FOLDER_NAME: {{ .Values.nextcloud.files.shared_folder_name | quote }}
    NX_MAX_CHUNKSIZE: {{ .Values.nextcloud.files.max_chunk_size | mul 1 | quote }}

    {{/* Logging */}}
    NX_LOG_LEVEL: {{ .Values.nextcloud.logging.log_level | quote }}
    NX_LOG_FILE: {{ .Values.nextcloud.logging.log_file | quote }}
    NX_LOG_FILE_AUDIT: {{ .Values.nextcloud.logging.log_audit_file | quote }}
    NX_LOG_DATE_FORMAT: {{ .Values.nextcloud.logging.log_date_format | quote }}
    NX_LOG_TIMEZONE: {{ .Values.TZ | quote }}

    {{/* ClamAV */}}
    NX_CLAMAV: {{ .Values.nextcloud.clamav.enabled | quote }}
    {{- if .Values.nextcloud.clamav.enabled }}
    NX_CLAMAV_HOST: {{ printf "%v-clamav" $fullname }}
    NX_CLAMAV_PORT: {{ .Values.service.clamav.ports.clamav.targetPort | quote }}
    NX_CLAMAV_STREAM_MAX_LENGTH: {{ .Values.nextcloud.clamav.stream_max_length | mul 1 | quote }}
    NX_CLAMAV_FILE_MAX_SIZE: {{ .Values.nextcloud.clamav.file_max_size | quote }}
    NX_CLAMAV_INFECTED_ACTION: {{ .Values.nextcloud.clamav.infected_action | quote }}
    {{- end }}

    {{/* Collabora */}}
    NX_COLLABORA: {{ .Values.nextcloud.collabora.enabled | quote }}
    {{- if .Values.nextcloud.collabora.enabled }}
    NX_COLLABORA_URL: {{ printf "%v/collabora" $accessUrl | quote }}
    # Ideally this would be a combo of: public ip, pod cidr, svc cidr
    # But not always people have static IP.
    NX_COLLABORA_ALLOWLIST: "0.0.0.0/0"
    {{- end }}

    {{/* Only Office */}}
    NX_ONLYOFFICE: {{ .Values.nextcloud.onlyoffice.enabled | quote }}
    {{- if .Values.nextcloud.onlyoffice.enabled }}
    NX_ONLYOFFICE_URL: {{ .Values.nextcloud.onlyoffice.url | quote }}
    NX_ONLYOFFICE_INTERNAL_URL: {{ .Values.nextcloud.onlyoffice.internal_url | quote }}
    NX_ONLYOFFICE_VERIFY_SSL: {{ .Values.nextcloud.onlyoffice.verify_ssl | quote }}
    NX_ONLYOFFICE_NEXTCLOUD_INTERNAL_URL: {{ printf "http://%v.svc.cluster.local:%v" $fqdn .Values.service.main.ports.main.port }}
    NX_ONLYOFFICE_JWT: {{ .Values.nextcloud.onlyoffice.jwt | quote }}
    NX_ONLYOFFICE_JWT_HEADER: {{ .Values.nextcloud.onlyoffice.jwt_header | quote }}
    {{- end }}

    {{/* URLs */}}
    NX_OVERWRITE_HOST: {{ $accessHostPort }}
    NX_OVERWRITE_CLI_URL: {{ $accessUrl }}
    # Return the protocol part of the URL
    NX_OVERWRITE_PROTOCOL: {{ $accessProtocol | lower }}
    # IP (or range in this case) of the proxy(ies)
    NX_TRUSTED_PROXIES: |
      {{ .Values.chartContext.podCIDR }}
      {{ .Values.chartContext.svcCIDR }}
    # fullname-* will allow access from the
    # other services in the same namespace
    NX_TRUSTED_DOMAINS: |
      127.0.0.1
      localhost
      {{ $fullname }}
      {{ printf "%v-*" $fullname }}
      {{ $healthHost }}
      {{- if not (contains "127.0.0.1" $accessHost) }}
        {{- $accessHost | nindent 6 }}
      {{- end -}}
      {{- with .Values.nextcloud.general.accessIP }}
        {{- . | nindent 6 }}
      {{- end }}

# TODO: Replace locations with ingress
# like /push, /.well-known/carddav, /.well-known/caldav
# needs some work as nginx converts urls to pretty urls
# before matching them to locations, so ingress needs to
# take that into consideration.
nginx-config:
  enabled: true
  data:
    nginx.conf: |
      worker_processes auto;

      error_log               /var/log/nginx/error.log warn;
      # Set to /tmp so it can run as non-root
      pid                     /tmp/nginx.pid;

      events {
        worker_connections  1024;
      }

      http {
        # Set to /tmp so it can run as non-root
        client_body_temp_path /tmp/nginx/client_temp;
        proxy_temp_path       /tmp/nginx/proxy_temp_path;
        fastcgi_temp_path     /tmp/nginx/fastcgi_temp;
        uwsgi_temp_path       /tmp/nginx/uwsgi_temp;
        scgi_temp_path        /tmp/nginx/scgi_temp;

        include               /etc/nginx/mime.types;
        default_type          application/octet-stream;

        log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                          '$status $body_bytes_sent "$http_referer" '
                          '"$http_user_agent" "$http_x_forwarded_for"';

        access_log  /var/log/nginx/access.log  main;

        sendfile        on;
        #tcp_nopush     on;

        # Prevent nginx HTTP Server Detection
        server_tokens   off;

        keepalive_timeout  65;

        #gzip  on;

        upstream php-handler {
          server {{ printf "%v-nextcloud" $fullname }}:{{ .Values.service.nextcloud.ports.nextcloud.targetPort }};
        }

        server {
          listen {{ .Values.service.main.ports.main.port }};
          absolute_redirect off;

          {{- if .Values.nextcloud.notify_push.enabled }}
          # Forward Notify_Push "High Performance Backend"  to it's own container
          location ^~ /push/ {
              # The trailing "/" is important!
              proxy_pass http://{{ printf "%v-notify" $fullname }}:{{ .Values.service.notify.ports.notify.targetPort }}/;
              proxy_http_version 1.1;
              proxy_set_header Upgrade $http_upgrade;
              proxy_set_header Connection "Upgrade";
              proxy_set_header Host $host;
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
          }
          {{- end }}

          # HSTS settings
          # WARNING: Only add the preload option once you read about
          # the consequences in https://hstspreload.org/. This option
          # will add the domain to a hardcoded list that is shipped
          # in all major browsers and getting removed from this list
          # could take several months.
          #add_header Strict-Transport-Security "max-age=15768000; includeSubDomains; preload;" always;

          # Set max upload size
          client_max_body_size {{ .Values.nextcloud.php.upload_limit | default "512M" }};
          fastcgi_buffers 64 4K;

          # Enable gzip but do not remove ETag headers
          gzip on;
          gzip_vary on;
          gzip_comp_level 4;
          gzip_min_length 256;
          gzip_proxied expired no-cache no-store private no_last_modified no_etag auth;
          gzip_types application/atom+xml text/javascript application/javascript application/json application/ld+json application/manifest+json application/rss+xml application/vnd.geo+json application/vnd.ms-fontobject application/wasm application/x-font-ttf application/x-web-app-manifest+json application/xhtml+xml application/xml font/opentype image/bmp image/svg+xml image/x-icon text/cache-manifest text/css text/plain text/vcard text/vnd.rim.location.xloc text/vtt text/x-component text/x-cross-domain-policy;

          # Pagespeed is not supported by Nextcloud, so if your server is built
          # with the `ngx_pagespeed` module, uncomment this line to disable it.
          #pagespeed off;

          include mime.types;
          types {
              text/javascript js mjs;
          }

          # HTTP response headers borrowed from Nextcloud `.htaccess`
          add_header Referrer-Policy                      "no-referrer"       always;
          add_header X-Content-Type-Options               "nosniff"           always;
          add_header X-Download-Options                   "noopen"            always;
          add_header X-Frame-Options                      "SAMEORIGIN"        always;
          add_header X-Permitted-Cross-Domain-Policies    "none"              always;
          add_header X-Robots-Tag                         "noindex, nofollow" always;
          add_header X-XSS-Protection                     "1; mode=block"     always;

          # Remove X-Powered-By, which is an information leak
          fastcgi_hide_header X-Powered-By;

          # Path to the root of your installation
          root {{ .Values.persistence.html.targetSelector.nginx.nginx.mountPath }};

          # Specify how to handle directories -- specifying `/index.php$request_uri`
          # here as the fallback means that Nginx always exhibits the desired behaviour
          # when a client requests a path that corresponds to a directory that exists
          # on the server. In particular, if that directory contains an index.php file,
          # that file is correctly served; if it doesn't, then the request is passed to
          # the front-end controller. This consistent behaviour means that we don't need
          # to specify custom rules for certain paths (e.g. images and other assets,
          # `/updater`, `/ocm-provider`, `/ocs-provider`), and thus
          # `try_files $uri $uri/ /index.php$request_uri`
          # always provides the desired behaviour.
          index index.php index.html /index.php$request_uri;

          # Rule borrowed from `.htaccess` to handle Microsoft DAV clients
          location = / {
            if ( $http_user_agent ~ ^DavClnt ) {
              return 302 /remote.php/webdav/$is_args$args;
            }
          }

          location = /robots.txt {
            allow all;
            log_not_found off;
            access_log off;
          }

          # Make a regex exception for `/.well-known` so that clients can still
          # access it despite the existence of the regex rule
          # `location ~ /(\.|autotest|...)` which would otherwise handle requests
          # for `/.well-known`.
          location ^~ /.well-known {
            # The rules in this block are an adaptation of the rules
            # in `.htaccess` that concern `/.well-known`.

            location = /.well-known/carddav { return 301 /remote.php/dav/; }
            location = /.well-known/caldav  { return 301 /remote.php/dav/; }

            location /.well-known/acme-challenge    { try_files $uri $uri/ =404; }
            location /.well-known/pki-validation    { try_files $uri $uri/ =404; }

            # Let Nextcloud's API for `/.well-known` URIs handle all other
            # requests by passing them to the front-end controller.
            return 301 /index.php$request_uri;
          }

          # Rules borrowed from `.htaccess` to hide certain paths from clients
          location ~ ^/(?:build|tests|config|lib|3rdparty|templates|data)(?:$|/)  { return 404; }
          location ~ ^/(?:\.|autotest|occ|issue|indie|db_|console)                { return 404; }

          # Ensure this block, which passes PHP files to the PHP process, is above the blocks
          # which handle static assets (as seen below). If this block is not declared first,
          # then Nginx will encounter an infinite rewriting loop when it prepends `/index.php`
          # to the URI, resulting in a HTTP 500 error response.
          location ~ \.php(?:$|/) {
            # Required for legacy support
            rewrite ^/(?!index|remote|public|cron|core\/ajax\/update|status|ocs\/v[12]|updater\/.+|oc[ms]-provider\/.+|.+\/richdocumentscode\/proxy) /index.php$request_uri;

            fastcgi_split_path_info ^(.+?\.php)(/.*)$;
            set $path_info $fastcgi_path_info;

            try_files $fastcgi_script_name =404;

            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
            fastcgi_param PATH_INFO $path_info;
            #fastcgi_param HTTPS on;

            fastcgi_param modHeadersAvailable true;         # Avoid sending the security headers twice
            fastcgi_param front_controller_active true;     # Enable pretty urls
            fastcgi_pass php-handler;

            fastcgi_intercept_errors on;
            fastcgi_request_buffering off;
            proxy_send_timeout 3600s;
            proxy_read_timeout 3600s;
            fastcgi_send_timeout 3600s;
            fastcgi_read_timeout 3600s;
          }

          location ~ \.(?:css|js|svg|gif)$ {
            try_files $uri /index.php$request_uri;
            expires 6M;         # Cache-Control policy borrowed from `.htaccess`
            access_log off;     # Optional: Don't log access to assets
          }

          location ~ \.woff2?$ {
            try_files $uri /index.php$request_uri;
            expires 7d;         # Cache-Control policy borrowed from `.htaccess`
            access_log off;     # Optional: Don't log access to assets
          }

          # Rule borrowed from `.htaccess`
          location /remote {
            return 301 /remote.php$request_uri;
          }

          location / {
            try_files $uri $uri/ /index.php$request_uri;
          }
        }
      }
{{- end -}}
