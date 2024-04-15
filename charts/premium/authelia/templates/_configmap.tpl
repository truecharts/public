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
    theme: {{ .Values.theme | default "light" }}
    default_redirection_url: {{ default (printf "https://www.%s" .Values.domain) .Values.default_redirection_url }}
    ntp:
      address:  {{ .Values.ntp.address | default "time.cloudflare.com:123" }}
      version: {{ .Values.ntp.version | default 4 }}
      max_desync: {{ .Values.ntp.max_desync | default "3s" }}
      disable_startup_check: {{ .Values.ntp.disable_startup_check | default false }}
      disable_failure: {{ .Values.ntp.disable_failure |  default true }}
    server:
      host: 0.0.0.0
      port: {{ .Values.server.port | default 9091 }}
      {{- if ne "" (.Values.server.path | default "") }}
      path: {{ .Values.server.path }}
      {{- end }}
      buffers:
        write: {{ .Values.server.write_buffer_size | default 4096 }}
        read: {{ .Values.server.read_buffer_size | default 4096 }}
      enable_pprof: {{ .Values.server.enable_pprof | default false }}
      enable_expvars: {{ .Values.server.enable_expvars | default false }}
    log:
      level: {{ .Values.log.level | default "info" }}
      format: {{ .Values.log.format | default "text" }}
      {{- if ne "" (.Values.log.file_path | default "") }}
      file_path: {{ .Values.log.file_path }}
      keep_stdout: true
      {{- end }}
    totp:
      issuer: {{ .Values.totp.issuer | default .Values.domain }}
      period: {{ .Values.totp.period | default 30 }}
      skew: {{ .Values.totp.skew | default 1 }}
    {{- if .Values.password_policy.enabled }}
    password_policy:
      standard:
        enabled: {{ .Values.password_policy.standard.enabled | default false }}
        min_length: {{ .Values.password_policy.standard.min_length | default 8 }}
        max_length: {{ .Values.password_policy.standard.max_length | default 0 }}
        require_uppercase: {{ .Values.password_policy.standard.require_uppercase | default false }}
        require_lowercase: {{ .Values.password_policy.standard.require_lowercase | default false }}
        require_number: {{ .Values.password_policy.standard.require_number | default false }}
        require_special: {{ .Values.password_policy.standard.require_special | default false }}
      zxcvbn:
        enabled: {{ .Values.password_policy.zxcvbn.enabled | default false }}
        min_score: {{ .Values.password_policy.zxcvbn.min_score | default 3 }}
    {{- end -}}
    {{- if .Values.duo_api.enabled }}
    duo_api:
      hostname: {{ .Values.duo_api.hostname }}
      integration_key: {{ .Values.duo_api.integration_key }}
    {{- end -}}
    {{- with $auth := .Values.authentication_backend }}
    authentication_backend:
      password_reset:
        disable: {{ $auth.disable_reset_password }}
    {{- if $auth.file.enabled }}
      file:
        path: {{ $auth.file.path }}
        password:
          {{- $p := $auth.file.password -}}
          {{- if $p.algorithm }}
          algorithm: {{ $p.algorithm }}
          {{- end -}}
          {{- if $p.iterations }}
          iterations: {{ $p.iterations }}
          {{- end -}}
          {{- if $p.key_length }}
          key_length: {{ $p.key_length }}
          {{- end -}}
          {{- if $p.salt_length }}
          salt_length: {{ $p.salt_length }}
          {{- end -}}
          {{- if $p.memory }}
          memory: {{ $p.memory }}
          {{- end -}}
          {{- if $p.parallelism }}
          parallelism: {{ $p.parallelism }}
          {{- end -}}
    {{- end -}}
    {{- if $auth.ldap.enabled }}
      ldap:
        implementation: {{ $auth.ldap.implementation | default "custom" }}
        url: {{ $auth.ldap.url }}
        timeout: {{ $auth.ldap.timeout | default "5s" }}
        start_tls: {{ $auth.ldap.start_tls }}
        tls:
          {{- if hasKey $auth.ldap.tls "server_name" }}
          server_name: {{ $auth.ldap.tls.server_name | default $auth.ldap.host }}
          {{- end }}
          minimum_version: {{ $auth.ldap.tls.minimum_version | default "TLS1.2" }}
          skip_verify: {{ $auth.ldap.tls.skip_verify | default false }}
    {{- if $auth.ldap.base_dn }}
        base_dn: {{ $auth.ldap.base_dn }}
    {{- end -}}
    {{- if $auth.ldap.username_attribute }}
        username_attribute: {{ $auth.ldap.username_attribute }}
    {{- end -}}
    {{- if $auth.ldap.additional_users_dn }}
        additional_users_dn: {{ $auth.ldap.additional_users_dn }}
    {{- end -}}
    {{- if $auth.ldap.users_filter }}
        users_filter: {{ $auth.ldap.users_filter }}
    {{- end -}}
    {{- if $auth.ldap.additional_groups_dn }}
        additional_groups_dn: {{ $auth.ldap.additional_groups_dn }}
    {{- end -}}
    {{- if $auth.ldap.groups_filter }}
        groups_filter: {{ $auth.ldap.groups_filter }}
    {{- end -}}
    {{- if $auth.ldap.group_name_attribute }}
        group_name_attribute: {{ $auth.ldap.group_name_attribute }}
    {{- end -}}
    {{- if $auth.ldap.mail_attribute }}
        mail_attribute: {{ $auth.ldap.mail_attribute }}
    {{- end -}}
    {{- if $auth.ldap.display_name_attribute }}
        display_name_attribute: {{ $auth.ldap.display_name_attribute }}
    {{- end }}
        user: {{ $auth.ldap.user }}
    {{- end -}}
    {{- end -}}
    {{- with $session := .Values.session }}
    session:
      name: {{ $session.name | default "authelia_session" }}
      domain: {{ required "A valid .Values.domain entry required!" $.Values.domain }}
      same_site: {{ $session.same_site | default "lax" }}
      expiration: {{ $session.expiration | default "1M" }}
      inactivity: {{ $session.inactivity | default "5m" }}
      remember_me_duration: {{ $session.remember_me_duration | default "1M" }}
    {{- end }}
      redis:
        host: {{ .Values.redis.creds.plain }}
      {{- with $redis := .Values.redisProvider }}
        port: {{ $redis.port | default 6379 }}
        {{- if not (eq $redis.username "") }}
        username: {{ $redis.username }}
        {{- end }}
        maximum_active_connections: {{ $redis.maximum_active_connections | default 8 }}
        minimum_idle_connections: {{ $redis.minimum_idle_connections | default 0 }}
    {{- if $redis.tls.enabled }}
        tls:
          server_name: {{ $redis.tls.server_name }}
          minimum_version: {{ $redis.tls.minimum_version | default "TLS1.2" }}
          skip_verify: {{ $redis.tls.skip_verify }}
    {{- end }}
    {{- if $redis.high_availability.enabled }}
        high_availability:
          sentinel_name: {{ $redis.high_availability.sentinel_name }}
    {{- if $redis.high_availability.nodes }}
          nodes:
          {{- range $node := $redis.high_availability.nodes }}
          - host: {{ $node.host }}
            port: {{ $node.port | default 26379 }}
          {{- end -}}
    {{- end }}
          route_by_latency: {{ $redis.high_availability.route_by_latency }}
          route_randomly: {{ $redis.high_availability.route_randomly }}
      {{- end }}
    {{- end }}
    regulation:
      max_retries: {{ .Values.regulation.max_retries | default 3 }}
      find_time: {{ .Values.regulation.find_time | default "1m" }}
      ban_time: {{ .Values.regulation.ban_time | default "5m" }}
    storage:
      postgres:
        host: {{ $.Values.cnpg.main.creds.host }}
    {{- with $storage := .Values.storage }}
        port: {{ $storage.postgres.port | default 5432 }}
        database: {{ $storage.postgres.database | default "authelia" }}
        username: {{ $storage.postgres.username | default "authelia" }}
        timeout: {{ $storage.postgres.timeout | default "5s" }}
        ssl:
          mode: {{ $storage.postgres.sslmode | default "disable" }}
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
        port: {{ $notifier.smtp.port | default 25 }}
        timeout: {{ $notifier.smtp.timeout | default "5s" }}
        {{- with $notifier.smtp.username }}
        username: {{ . }}
        {{- end }}
        sender: {{ $notifier.smtp.sender | quote }}
        identifier: {{ $notifier.smtp.identifier | quote }}
        subject: {{ $notifier.smtp.subject | quote }}
        startup_check_address: {{ $notifier.smtp.startup_check_address | quote }}
        disable_require_tls: {{ $notifier.smtp.disable_require_tls }}
        disable_html_emails: {{ $notifier.smtp.disable_html_emails }}
        tls:
          server_name: {{ $notifier.smtp.tls.server_name | default $notifier.smtp.host }}
          minimum_version: {{ $notifier.smtp.tls.minimum_version | default "TLS1.2" }}
          skip_verify: {{ $notifier.smtp.tls.skip_verify | default false }}
    {{- end }}
    {{- end }}
    {{- if .Values.identity_providers.oidc.enabled }}
    identity_providers:
      oidc:
        access_token_lifespan: {{ .Values.identity_providers.oidc.access_token_lifespan | default "1h" }}
        authorize_code_lifespan: {{ .Values.identity_providers.oidc.authorize_code_lifespan | default "1m" }}
        id_token_lifespan: {{ .Values.identity_providers.oidc.id_token_lifespan | default "1h" }}
        refresh_token_lifespan: {{ .Values.identity_providers.oidc.refresh_token_lifespan | default "90m" }}
        enable_client_debug_messages: {{ .Values.identity_providers.oidc.enable_client_debug_messages | default false }}
        minimum_parameter_entropy: {{ .Values.identity_providers.oidc.minimum_parameter_entropy | default 8 }}
        {{- if .Values.identity_providers.oidc.clients  }}
        clients:
    {{- range $client := .Values.identity_providers.oidc.clients }}
        - id: {{ $client.id }}
          description: {{ $client.description | default $client.id }}
          secret: {{ $client.secret | default (randAlphaNum 128) }}
          {{- if $client.public }}
          public: {{ $client.public }}
          {{- end }}
          authorization_policy: {{ $client.authorization_policy | default "two_factor" }}
          consent_mode: {{ $client.consent_mode | default "auto" }}
          redirect_uris:
          {{- range $client.redirect_uris }}
          - {{ . }}
          {{- end }}
          {{- if $client.audience }}
          audience:
            {{- range $client.audience }}
            - {{ . }}
            {{- end }}
          {{- end }}
          scopes:
          {{- range ($client.scopes | default (list "openid" "profile" "email" "groups")) }}
            - {{ . }}
          {{- end }}
          grant_types:
          {{- range ($client.grant_types | default (list "refresh_token" "authorization_code")) }}
            - {{ . }}
          {{- end }}
          response_types:
          {{- range ($client.response_types | default (list "code")) }}
            - {{ . }}
          {{- end }}
          {{- if $client.response_modes }}
          response_modes:
          {{- range $client.response_modes }}
            - {{ . }}
          {{- end }}
          {{- end }}
          token_endpoint_auth_method: {{ $client.token_endpoint_auth_method | default "client_secret_basic" }}
          userinfo_signing_algorithm: {{ $client.userinfo_signing_algorithm | default "none" }}
          {{- if $client.require_pkce }}
          require_pkce: {{ $client.require_pkce }}
          {{- end }}
          {{- if $client.pkce_challange_method }}
          pkce_challenge_method: {{ $client.pkce_challange_method | default "S256" }}
          {{- end }}
    {{- end }}
    {{- end }}
    {{- end }}
    access_control:
    {{- if not .Values.access_control.rules }}
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

    {{- if and .Values.access_control.networks (not .Values.access_control.networks_access_control) -}}
      {{- fail "Please change [.Values.access_control.networks] to [.Values.access_control.networks_access_control]" -}}
    {{- end -}}
    {{- if not .Values.access_control.networks_access_control }}
      networks: []
    {{- else }}
      networks:
    {{- range $net := .Values.access_control.networks_access_control }}
      - name: {{ $net.name }}
        networks:
          {{- range $net.networks }}
          - {{ . | squote }}
          {{- end }}
    {{- end }}
    {{- end }}

    {{- if not .Values.access_control.rules }}
      rules: []
    {{- else }}
      rules:
    {{- range $rule := .Values.access_control.rules }}
      {{- if $rule.domain }}
      - domain:
        {{- if kindIs "string" $rule.domain }}
          - {{ $rule.domain | squote }}
        {{- else -}}
          {{- range $rule.domain }}
          - {{ . | squote }}
          {{- end }}
        {{- end }}
      {{- end -}}
      {{- if $rule.domain_regex }}
        domain_regex:
        {{- if kindIs "string" $rule.domain_regex }}
          - {{ $rule.domain_regex | squote }}
        {{- else -}}
          {{- range $rule.domain_regex }}
          - {{ . | squote }}
          {{- end }}
        {{- end }}
      {{- end }}
      {{- with $rule.policy }}
        policy: {{ . }}
      {{- end -}}
      {{- if $rule.networks }}
        networks:
        {{- if kindIs "string" $rule.networks }}
          - {{ $rule.networks | squote }}
        {{- else -}}
          {{- range $rule.networks }}
            - {{ . | squote }}
          {{- end }}
        {{- end }}
      {{- end }}
      {{- if $rule.subject }}
        subject:
        {{- if kindIs "string" $rule.subject }}
          - {{ $rule.subject | squote }}
        {{- else -}}
          {{- range $rule.subject }}
            - {{ . | squote }}
          {{- end }}
        {{- end }}
      {{- end }}
      {{- if $rule.resources }}
        resources:
        {{- if kindIs "string" $rule.resources }}
          - {{ $rule.resources | squote }}
        {{- else -}}
          {{- range $rule.resources }}
            - {{ . | squote }}
          {{- end }}
        {{- end }}
      {{- end }}
    {{- end }}
    {{- end }}
    ...
{{- end -}}
