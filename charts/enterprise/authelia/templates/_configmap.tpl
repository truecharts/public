{{/* Define the configmap */}}
{{- define "authelia.configmap.paths" -}}
enabled: true
data:
  AUTHELIA_SERVER_DISABLE_HEALTHCHECK: "true"
  AUTHELIA_JWT_SECRET_FILE: "/secrets/JWT_TOKEN"
  AUTHELIA_SESSION_SECRET_FILE: "/secrets/SESSION_ENCRYPTION_KEY"
  AUTHELIA_STORAGE_ENCRYPTION_KEY_FILE: "/secrets/ENCRYPTION_KEY"
  AUTHELIA_STORAGE_POSTGRES_PASSWORD_FILE: "/secrets/STORAGE_PASSWORD"
  {{- if .Values.authentication_backend.ldap.enabled }}
  AUTHELIA_AUTHENTICATION_BACKEND_LDAP_PASSWORD_FILE: "/secrets/LDAP_PASSWORD"
  {{- end }}
  {{- if .Values.notifier.smtp.enabled }}
  AUTHELIA_NOTIFIER_SMTP_PASSWORD_FILE: "/secrets/SMTP_PASSWORD"
  {{- end }}
  AUTHELIA_SESSION_REDIS_PASSWORD_FILE: "/secrets/REDIS_PASSWORD"
  {{- if .Values.redisProvider.high_availability.enabled }}
  AUTHELIA_SESSION_REDIS_HIGH_AVAILABILITY_SENTINEL_PASSWORD_FILE: "/secrets/REDIS_SENTINEL_PASSWORD"
  {{- end }}
  {{- if .Values.duo_api.enabled }}
  AUTHELIA_DUO_API_SECRET_KEY_FILE: "/secrets/DUO_API_KEY"
  {{- end }}
  {{- if .Values.identity_providers.oidc.enabled }}
  AUTHELIA_IDENTITY_PROVIDERS_OIDC_HMAC_SECRET_FILE: "/secrets/OIDC_HMAC_SECRET"
  AUTHELIA_IDENTITY_PROVIDERS_OIDC_ISSUER_PRIVATE_KEY_FILE: "/secrets/OIDC_PRIVATE_KEY"
  {{- end }}

{{- end -}}

{{- define "authelia.configmap.configfile" -}}
enabled: true
data:
  configuration.yaml: |
    ---
    theme: {{ default "light" .Values.theme }}
    default_redirection_url: {{ default (printf "https://www.%s" .Values.domain) .Values.default_redirection_url }}
    ntp:
      address:  {{ default "time.cloudflare.com:123" .Values.ntp.address }}
      version: {{ default 4 .Values.ntp.version }}
      max_desync: {{ default "3s" .Values.ntp.max_desync }}
      disable_startup_check: {{ default false .Values.ntp.disable_startup_check }}
      disable_failure: {{ default true .Values.ntp.disable_failure }}
    server:
      host: 0.0.0.0
      port: {{ default 9091 .Values.server.port }}
      {{- if not (eq "" (default "" .Values.server.path)) }}
      path: {{ .Values.server.path }}
      {{- end }}
      buffers:
        write: {{ default 4096 .Values.server.write_buffer_size }}
        read: {{ default 4096 .Values.server.read_buffer_size }}
      enable_pprof: {{ default false .Values.server.enable_pprof }}
      enable_expvars: {{ default false .Values.server.enable_expvars }}
    log:
      level: {{ default "info" .Values.log.level }}
      format: {{ default "text" .Values.log.format }}
      {{- if not (eq "" (default "" .Values.log.file_path)) }}
      file_path: {{ .Values.log.file_path }}
      keep_stdout: true
      {{- end }}
    totp:
      issuer: {{ default .Values.domain .Values.totp.issuer }}
      period: {{ default 30 .Values.totp.period }}
      skew: {{ default 1 .Values.totp.skew }}
    {{- if .Values.duo_api.enabled }}
    duo_api:
      hostname: {{ .Values.duo_api.hostname }}
      integration_key: {{ .Values.duo_api.integration_key }}
    {{- end }}
    {{- with $auth := .Values.authentication_backend }}
    authentication_backend:
      password_reset:
        disable: {{ $auth.disable_reset_password }}
    {{- if $auth.file.enabled }}
      file:
        path: {{ $auth.file.path }}
        password: {{ toYaml $auth.file.password | nindent 10 }}
    {{- end }}
    {{- if $auth.ldap.enabled }}
      ldap:
        implementation: {{ default "custom" $auth.ldap.implementation }}
        url: {{ $auth.ldap.url }}
        timeout: {{ default "5s" $auth.ldap.timeout }}
        start_tls: {{ $auth.ldap.start_tls }}
        tls:
          {{- if hasKey $auth.ldap.tls "server_name" }}
          server_name: {{ default $auth.ldap.host $auth.ldap.tls.server_name }}
          {{- end }}
          minimum_version: {{ default "TLS1.2" $auth.ldap.tls.minimum_version }}
          skip_verify: {{ default false $auth.ldap.tls.skip_verify }}
    {{- if $auth.ldap.base_dn }}
        base_dn: {{ $auth.ldap.base_dn }}
    {{- end }}
    {{- if $auth.ldap.username_attribute }}
        username_attribute: {{ $auth.ldap.username_attribute }}
    {{- end }}
    {{- if $auth.ldap.additional_users_dn }}
        additional_users_dn: {{ $auth.ldap.additional_users_dn }}
    {{- end }}
    {{- if $auth.ldap.users_filter }}
        users_filter: {{ $auth.ldap.users_filter }}
    {{- end }}
    {{- if $auth.ldap.additional_groups_dn }}
        additional_groups_dn: {{ $auth.ldap.additional_groups_dn }}
    {{- end }}
    {{- if $auth.ldap.groups_filter }}
        groups_filter: {{ $auth.ldap.groups_filter }}
    {{- end }}
    {{- if $auth.ldap.group_name_attribute }}
        group_name_attribute: {{ $auth.ldap.group_name_attribute }}
    {{- end }}
    {{- if $auth.ldap.mail_attribute }}
        mail_attribute: {{ $auth.ldap.mail_attribute }}
    {{- end }}
    {{- if $auth.ldap.display_name_attribute }}
        display_name_attribute: {{ $auth.ldap.display_name_attribute }}
    {{- end }}
        user: {{ $auth.ldap.user }}
    {{- end }}
    {{- end }}
    {{- with $session := .Values.session }}
    session:
      name: {{ default "authelia_session" $session.name }}
      domain: {{ required "A valid .Values.domain entry required!" $.Values.domain }}
      same_site: {{ default "lax" $session.same_site }}
      expiration: {{ default "1M" $session.expiration }}
      inactivity: {{ default "5m" $session.inactivity }}
      remember_me_duration: {{ default "1M" $session.remember_me_duration }}
    {{- end }}
      redis:
        host: {{ .Values.redis.creds.plain }}
      {{- with $redis := .Values.redisProvider }}
        port: {{ default 6379 $redis.port }}
        {{- if not (eq $redis.username "") }}
        username: {{ $redis.username }}
        {{- end }}
        maximum_active_connections: {{ default 8 $redis.maximum_active_connections }}
        minimum_idle_connections: {{ default 0 $redis.minimum_idle_connections }}
    {{- if $redis.tls.enabled }}
        tls:
          server_name: {{ $redis.tls.server_name }}
          minimum_version: {{ default "TLS1.2" $redis.tls.minimum_version }}
          skip_verify: {{ $redis.tls.skip_verify }}
    {{- end }}
    {{- if $redis.high_availability.enabled }}
        high_availability:
          sentinel_name: {{ $redis.high_availability.sentinel_name }}
    {{- if $redis.high_availability.nodes }}
          nodes: {{ toYaml $redis.high_availability.nodes | nindent 10 }}
    {{- end }}
          route_by_latency: {{ $redis.high_availability.route_by_latency }}
          route_randomly: {{ $redis.high_availability.route_randomly }}
      {{- end }}
    {{- end }}
    regulation: {{ toYaml .Values.regulation | nindent 6 }}
    storage:
      postgres:
        host: {{ $.Values.cnpg.main.creds.host }}
    {{- with $storage := .Values.storage }}
        port: {{ default 5432 $storage.postgres.port }}
        database: {{ default "authelia" $storage.postgres.database }}
        username: {{ default "authelia" $storage.postgres.username }}
        timeout: {{ default "5s" $storage.postgres.timeout }}
        ssl:
          mode: {{ default "disable" $storage.postgres.sslmode }}
    {{- end }}
    {{- with $notifier := .Values.notifier }}
    notifier:
      disable_startup_check: {{ $.Values.notifier.disable_startup_check }}
    {{- if $notifier.filesystem.enabled }}
      filesystem:
        filename: {{ $notifier.filesystem.filename }}
    {{- end }}
    {{- if $notifier.smtp.enabled }}
      smtp:
        host: {{ $notifier.smtp.host }}
        port: {{ default 25 $notifier.smtp.port }}
        timeout: {{ default "5s" $notifier.smtp.timeout }}
        {{- with $notifier.smtp.username }}
        username: {{ . }}
        {{- end }}
        sender: {{ $notifier.smtp.sender }}
        identifier: {{ $notifier.smtp.identifier }}
        subject: {{ $notifier.smtp.subject | quote }}
        startup_check_address: {{ $notifier.smtp.startup_check_address }}
        disable_require_tls: {{ $notifier.smtp.disable_require_tls }}
        disable_html_emails: {{ $notifier.smtp.disable_html_emails }}
        tls:
          server_name: {{ default $notifier.smtp.host $notifier.smtp.tls.server_name }}
          minimum_version: {{ default "TLS1.2" $notifier.smtp.tls.minimum_version }}
          skip_verify: {{ default false $notifier.smtp.tls.skip_verify }}
    {{- end }}
    {{- end }}
    {{- if .Values.identity_providers.oidc.enabled }}
    identity_providers:
      oidc:
        access_token_lifespan: {{ default "1h" .Values.identity_providers.oidc.access_token_lifespan }}
        authorize_code_lifespan: {{ default "1m" .Values.identity_providers.oidc.authorize_code_lifespan }}
        id_token_lifespan: {{ default "1h" .Values.identity_providers.oidc.id_token_lifespan }}
        refresh_token_lifespan: {{ default "90m" .Values.identity_providers.oidc.refresh_token_lifespan }}
        enable_client_debug_messages: {{ default false .Values.identity_providers.oidc.enable_client_debug_messages }}
        minimum_parameter_entropy: {{ default 8 .Values.identity_providers.oidc.minimum_parameter_entropy }}
        {{- if gt (len .Values.identity_providers.oidc.clients) 0 }}
        clients:
    {{- range $client := .Values.identity_providers.oidc.clients }}
        - id: {{ $client.id }}
          description: {{ default $client.id $client.description }}
          secret: {{ default (randAlphaNum 128) $client.secret }}
          {{- if $client.public }}
          public: {{ $client.public }}
          {{- end }}
          authorization_policy: {{ default "two_factor" $client.authorization_policy }}
          consent_mode: {{ default "auto" $client.consent_mode}}
          redirect_uris:
          {{- range $client.redirect_uris }}
          - {{ . }}
          {{- end }}
          {{- if $client.audience }}
          audience: {{ toYaml $client.audience | nindent 10 }}
          {{- end }}
          scopes: {{ toYaml (default (list "openid" "profile" "email" "groups") $client.scopes) | nindent 10 }}
          grant_types: {{ toYaml (default (list "refresh_token" "authorization_code") $client.grant_types) | nindent 10 }}
          response_types: {{ toYaml (default (list "code") $client.response_types) | nindent 10 }}
          {{- if $client.response_modes }}
          response_modes: {{ toYaml $client.response_modes | nindent 10 }}
          {{- end }}
          userinfo_signing_algorithm: {{ default "none" $client.userinfo_signing_algorithm }}
    {{- end }}
    {{- end }}
    {{- end }}
    access_control:
    {{- if (eq (len .Values.access_control.rules) 0) }}
      {{- if (eq .Values.access_control.default_policy "bypass") }}
      default_policy: one_factor
      {{- else if (eq .Values.access_control.default_policy "deny") }}
      default_policy: two_factor
      {{- else }}
      default_policy: {{ .Values.access_control.default_policy }}
      {{- end }}
    {{- else }}
      default_policy: {{ .Values.access_control.default_policy }}
    {{- end }}
    {{- if (eq (len .Values.access_control.networks) 0) }}
      networks: []
    {{- else }}
      networks: {{ toYaml .Values.access_control.networks | nindent 6 }}
    {{- end }}
    {{- if (eq (len .Values.access_control.rules) 0) }}
      rules: []
    {{- else }}
      rules: {{ toYaml .Values.access_control.rules | nindent 6 }}
    {{- end }}
    ...
{{- end -}}
