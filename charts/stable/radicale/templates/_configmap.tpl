{{/* Define the configmap */}}
{{- define "radicale.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $mainPort := .Values.service.main.ports.main.port }}
{{- $maxContentLength := .Values.radicale.server.max_content_length }}
{{- $maxConnections := .Values.radicale.server.max_connections }}
{{- $request := .Values.radicale.encoding.request }}
{{- $authType := .Values.radicale.auth.type }}
{{- $authDelay := .Values.radicale.auth.delay }}
{{- $authRealm := .Values.radicale.auth.realm }}
{{- $rightsType := .Values.radicale.rights.type }}
{{- $storageType := .Values.radicale.storage.type }}
{{- $webType := .Values.radicale.web.type }}
{{- $maxSyncTokenAge := .Values.radicale.storage.max_sync_token_age }}

{{- $stock := .Values.radicale.encoding.stock }}
{{- $loggingLevel := .Values.radicale.logging.level }}
{{- $authUsers := .Values.radicale.auth.users }}
{{- $maskPasswords := .Values.radicale.logging.mask_passwords }}

{{- $timeout := .Values.radicale.server.timeout }}

radicale-config:
  enabled: true
  data:
    config: |-
      # -*- mode: conf -*-
      # vim:ft=cfg

      # Config file for Radicale - A simple calendar server
      #
      # Place it into /etc/radicale/config (global)
      # or ~/.config/radicale/config (user)
      #
      # The current values are the default ones


      [server]

      # CalDAV server hostnames separated by a comma
      # IPv4 syntax: address:port
      # IPv6 syntax: [address]:port
      # For example: 0.0.0.0:9999, [::]:9999
      #hosts = localhost:5232
      hosts = 0.0.0.0:{{ $mainPort }}

      # Max parallel connections
      #max_connections = 8
      max_connections = {{ $maxConnections }}

      # Max size of request body (bytes)
      #max_content_length = 100000000
      {{- /*
        Multiply by 1, so large integers aren't rendered in scientific notation
        See: https://github.com/helm/helm/issues/1707#issuecomment-1167860346
      */}}
      max_content_length = {{ mul $maxContentLength 1 }}

      # Socket timeout (seconds)
      #timeout = 30
      timeout = {{ $timeout }}

      # SSL flag, enable HTTPS protocol
      #ssl = False

      # SSL certificate path
      #certificate = /etc/ssl/radicale.cert.pem

      # SSL private key
      #key = /etc/ssl/radicale.key.pem

      # CA certificate for validating clients. This can be used to secure
      # TCP traffic between Radicale and a reverse proxy
      #certificate_authority =


      [encoding]

      # Encoding for responding requests
      #request = utf-8
      request = {{ $request }}

      # Encoding for storing local collections
      #stock = utf-8
      stock = {{ $stock }}


      [auth]

      # Authentication method
      # Value: none | htpasswd | remote_user | http_x_remote_user
      #type = none
      type = {{ $authType }}

      # Htpasswd filename
      htpasswd_filename = /config/users

      # Htpasswd encryption method
      # Value: plain | bcrypt | md5
      # bcrypt requires the installation of radicale[bcrypt].
      #htpasswd_encryption = md5
      htpasswd_encryption = bcrypt

      # Incorrect authentication delay (seconds)
      #delay = 1
      delay = {{ $authDelay }}

      # Message displayed in the client when a password is needed
      #realm = Radicale - Password Required
      realm = {{ $authRealm }}

      [rights]

      # Rights backend
      # Value: none | authenticated | owner_only | owner_write | from_file
      #type = owner_only
      type = {{ $rightsType }}

      # File for rights management from_file
      #file = /etc/radicale/rights


      [storage]

      # Storage backend
      # Value: multifilesystem | multifilesystem_nolock
      #type = multifilesystem
      type = {{ $storageType }}

      # Folder for storing local collections, created if not present
      #filesystem_folder = /var/lib/radicale/collections
      filesystem_folder = /data/collections

      # Delete sync token that are older (seconds)
      #max_sync_token_age = 2592000
      {{- /*
        Multiply by 1, so large integers aren't rendered in scientific notation
        See: https://github.com/helm/helm/issues/1707#issuecomment-1167860346
      */}}
      max_sync_token_age = {{ mul $maxSyncTokenAge 1 }}

      # Command that is run after changes to storage
      # Example: ([ -d .git ] || git init) && git add -A && (git diff --cached --quiet || git commit -m "Changes by "%(user)s)
      #hook =


      [web]

      # Web interface backend
      # Value: none | internal
      #type = internal
      type = {{ $webType }}


      [logging]

      # Threshold for the logger
      # Value: debug | info | warning | error | critical
      #level = warning
      level = {{ $loggingLevel }}

      # Don't include passwords in logs
      #mask_passwords = True
      mask_passwords = {{ $maskPasswords | ternary "True" "False" }}


      [headers]

      # Additional HTTP headers
      #Access-Control-Allow-Origin = *

radicale-users:
  enabled: true
  data:
    users: |-
      {{- range $authUsers }}
      {{ htpasswd .username .password }}
      {{- end }}
{{- end }}
