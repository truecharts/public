{{/* Define the configmap */}}
{{- define "guacamole.configmap" -}}
{{/* https://github.com/apache/guacamole-client/blob/master/guacamole-docker/bin/start.sh */}}
{{/* https://guacamole.apache.org/doc/gug/guacamole-docker.html */}}
{{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ }}
guacamole-config:
  enabled: true
  data:
    RECORDING_SEARCH_PATH: /var/lib/guacamole/recordings
    {{/*
      https://github.com/apache/guacamole-client/blob/bffc5fbdd5e2bb7a777f55c819a1d4d858829cb7/guacamole-docker/bin/start.sh#L1038
      TomCat uses the war name as the context path. ROOT.war is the default and means the context path is /.
    */}}
    WEBAPP_CONTEXT: ROOT
  {{/* GuacD */}}
    GUACD_HOSTNAME: {{ printf "%v-guacd" $fullname }}
    GUACD_PORT: {{ .Values.service.guacd.ports.guacd.port | quote }}
  {{/* Database */}}
    POSTGRESQL_PORT: "5432"
    POSTGRESQL_DATABASE: {{ .Values.cnpg.main.database }}
    POSTGRESQL_USER: {{ .Values.cnpg.main.user }}
    POSTGRESQL_HOSTNAME: {{ .Values.cnpg.main.creds.host }}
    POSTGRESQL_PASSWORD: {{ .Values.cnpg.main.creds.password | trimAll "\"" }}
  {{/* LDAP */}}
  {{- if (get .Values.guacamole "ldap").LDAP_HOSTNAME }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_HOSTNAME" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_PORT" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_ENCRYPTION_METHOD" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_USER_BASE_DN" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_USER_SEARCH_FILTER" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_GROUP_BASE_DN" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_GROUP_SEARCH_FILTER" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_GROUP_NAME_ATTRIBUTE" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_MEMBER_ATTRIBUTE" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_MEMBER_ATTRIBUTE_TYPE" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_SEARCH_BIND_DN" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_SEARCH_BIND_PASSWORD" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_USERNAME_ATTRIBUTE" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_USER_ATTRIBUTES" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_CONFIG_BASE_DN" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_DEREFERENCE_ALIASES" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_FOLLOW_REFERRALS" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_MAX_REFERRAL_HOPS" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_MAX_SEARCH_RESULTS" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "ldap" "key" "LDAP_OPERATION_TIMEOUT" "rootCtx" $) }}
  {{- end }}
  {{/* Header */}}
  {{- if (get .Values.guacamole "header").HEADER_ENABLED }}
    {{ include "guac.env" (dict "ob" "header" "key" "HEADER_ENABLED" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "header" "key" "HTTP_AUTH_HEADER" "rootCtx" $) }}
  {{- end }}
  {{/* SAML */}}
  {{- if or
        (and ((get .Values.guacamole "saml").SAML_ENTITY_ID) ((get .Values.guacamole "saml").SAML_CALLBACK_URL))
        ((get .Values.guacamole "saml").SAML_IDP_METADATA_URL) }}
    {{ include "guac.env" (dict "ob" "saml" "key" "SAML_IDP_METADATA_URL" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "saml" "key" "SAML_IDP_URL" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "saml" "key" "SAML_ENTITY_ID" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "saml" "key" "SAML_CALLBACK_URL" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "saml" "key" "SAML_STRICT" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "saml" "key" "SAML_DEBUG" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "saml" "key" "SAML_COMPRESS_REQUEST" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "saml" "key" "SAML_COMPRESS_RESPONSE" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "saml" "key" "SAML_GROUP_ATTRIBUTE" "rootCtx" $) }}
  {{- end }}
  {{/* Proxy */}}
  {{- if (get .Values.guacamole "proxy").REMOTE_IP_VALVE_ENABLED }}
    {{ include "guac.env" (dict "ob" "proxy" "key" "REMOTE_IP_VALVE_ENABLED" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "proxy" "key" "PROXY_ALLOWED_IPS_REGEX" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "proxy" "key" "PROXY_IP_HEADER" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "proxy" "key" "PROXY_PROTOCOL_HEADER" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "proxy" "key" "PROXY_BY_HEADER" "rootCtx" $) }}
  {{- end }}
  {{/* General */}}
    {{ include "guac.env" (dict "ob" "general" "key" "EXTENSION_PRIORITY" "rootCtx" $) }}
  {{/* TOTP */}}
  {{- if (get .Values.guacamole "totp").TOTP_ENABLED }}
    {{ include "guac.env" (dict "ob" "totp" "key" "TOTP_ENABLED" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "totp" "key" "TOTP_ISSUER" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "totp" "key" "TOTP_DIGITS" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "totp" "key" "TOTP_PERIOD" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "totp" "key" "TOTP_MODE" "rootCtx" $) }}
  {{- end }}
  {{/* DUO */}}
  {{- if (get .Values.guacamole "duo").DUO_API_HOSTNAME }}
    {{ include "guac.env" (dict "ob" "duo" "key" "DUO_API_HOSTNAME" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "duo" "key" "DUO_INTEGRATION_KEY" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "duo" "key" "DUO_SECRET_KEY" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "duo" "key" "DUO_APPLICATION_KEY" "rootCtx" $) }}
  {{- end }}
  {{/* API */}}
    {{ include "guac.env" (dict "ob" "api" "key" "API_SESSION_TIMEOUT" "rootCtx" $) }}
  {{/* RADIUS */}}
  {{- if (get .Values.guacamole "radius").SHARED_SECRET }}
    {{ include "guac.env" (dict "ob" "radius" "key" "RADIUS_HOSTNAME" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "radius" "key" "RADIUS_AUTH_PORT" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "radius" "key" "RADIUS_SHARED_SECRET" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "radius" "key" "RADIUS_AUTH_PROTOCOL" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "radius" "key" "RADIUS_KEY_TYPE" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "radius" "key" "RADIUS_KEY_TYPE" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "radius" "key" "RADIUS_KEY_PASSWORD" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "radius" "key" "RADIUS_CA_FILE" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "radius" "key" "RADIUS_CA_TYPE" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "radius" "key" "RADIUS_CA_PASSWORD" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "radius" "key" "RADIUS_TRUST_ALL" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "radius" "key" "RADIUS_RETRIES" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "radius" "key" "RADIUS_TIMEOUT" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "radius" "key" "RADIUS_EAP_TTLS_INNER_PROTOCOL" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "radius" "key" "RADIUS_NAS_IP" "rootCtx" $) }}
  {{- end }}
  {{/* OPENID */}}
  {{- if (get .Values.guacamole "openid").OPENID_AUTHORIZATION_ENDPOINT }}
    {{ include "guac.env" (dict "ob" "openid" "key" "OPENID_AUTHORIZATION_ENDPOINT" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "openid" "key" "OPENID_JWKS_ENDPOINT" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "openid" "key" "OPENID_ISSUER" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "openid" "key" "OPENID_CLIENT_ID" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "openid" "key" "OPENID_REDIRECT_URI" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "openid" "key" "OPENID_USERNAME_CLAIM_TYPE" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "openid" "key" "OPENID_GROUPS_CLAIM_TYPE" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "openid" "key" "OPENID_SCOPE" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "openid" "key" "OPENID_ALLOWED_CLOCK_SKEW" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "openid" "key" "OPENID_MAX_TOKEN_VALIDITY" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "openid" "key" "OPENID_MAX_NONCE_VALIDITY" "rootCtx" $) }}
  {{- end }}
  {{/* CAS */}}
  {{- if (get .Values.guacamole "cas").CAS_AUTHORIZATION_ENDPOINT }}
    {{ include "guac.env" (dict "ob" "cas" "key" "CAS_AUTHORIZATION_ENDPOINT" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "cas" "key" "CAS_REDIRECT_URI" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "cas" "key" "CAS_CLEARPASS_KEY" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "cas" "key" "CAS_GROUP_ATTRIBUTE" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "cas" "key" "CAS_GROUP_FORMAT" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "cas" "key" "CAS_GROUP_LDAP_BASE_DN" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "cas" "key" "CAS_GROUP_LDAP_ATTRIBUTE" "rootCtx" $) }}
  {{- end }}
  {{/* JSON */}}
  {{- if (get .Values.guacamole "json").JSON_SECRET_KEY }}
    {{ include "guac.env" (dict "ob" "json" "key" "JSON_SECRET_KEY" "rootCtx" $) }}
    {{ include "guac.env" (dict "ob" "json" "key" "JSON_TRUSTED_NETWORKS" "rootCtx" $) }}
  {{- end }}
db-init:
  enabled: true
  data:
    {{- $filename := "/tc-init/initdb.sql" }}
    create-seed.sh: |
      echo "Creating [{{ $filename }}] file..."
      /opt/guacamole/bin/initdb.sh --postgresql > {{ $filename }}
      if [ -f {{ $filename }} ]; then
        echo "File [{{ $filename }}] created successfully!"
        exit 0
      fi
      echo "File [{{ $filename }}] failed to create."
      exit 1
    apply-seed.sh: |
      export PGPASSWORD="$POSTGRESQL_PASSWORD"
      until
        pg_isready --username="$POSTGRESQL_USER" --host="$POSTGRESQL_HOSTNAME" --port="$POSTGRESQL_PORT"
      do
        echo "Waiting for PostgreSQL to start..."
        sleep 2
      done
      psql  --host="$POSTGRESQL_HOSTNAME" --port="$POSTGRESQL_PORT" \
            --username="$POSTGRESQL_USER" --dbname="$POSTGRESQL_DATABASE" \
            --no-password --command='SELECT * FROM public.guacamole_user' \
            --output=/dev/null --quiet
      if [ $? -eq 0 ]; then
        echo "Database already initialized."
        exit 0
      fi
      if [ ! -f {{ $filename }} ]; then
        echo "File [{{ $filename }}] does not exist."
        exit 1
      fi
      echo "Initializing database from [{{ $filename }}] file..."
      psql  --host="$POSTGRESQL_HOSTNAME" --port="$POSTGRESQL_PORT" \
            --username="$POSTGRESQL_USER" --dbname="$POSTGRESQL_DATABASE" \
            --no-password --quiet --output=/dev/null --file={{ $filename }}
      if [ $? -eq 0 ]; then
        echo "Database initialized successfully!"
        exit 0
      fi
      echo "Database failed to initialize."
      exit 1
{{- end -}}

{{- define "guac.env" -}}
  {{- $key := .key -}}
  {{- $ob := .ob -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $object := (get $rootCtx.Values.guacamole $ob) -}}

  {{- if $object -}}
    {{- if hasKey $object $key -}}
      {{- if not (kindIs "invalid" $key) -}}
        {{- printf "%v: %v" $key (get $object $key | quote) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
