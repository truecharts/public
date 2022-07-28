{{/* Define the configmap */}}
{{- define "guacamole-client.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: guacamole-client-env
data:
  {{/* GENERAL */}}
  {{- if .Values.general.EXTENSION_PRIORITY }}
  EXTENSION_PRIORITY: {{ .Values.general.EXTENSION_PRIORITY | quote }}
  {{- end }}
  {{/* API */}}
  {{- if .Values.api.API_SESSION_TIMEOUT }}
  API_SESSION_TIMEOUT: {{ .Values.api.API_SESSION_TIMEOUT | quote }}
  {{- end }}
  {{/* TOTP */}}
  {{- if eq .Values.totp.TOTP_ENABLED true }}
  TOTP_ENABLED: {{ .Values.totp.TOTP_ENABLED | quote }}
  {{- if .Values.totp.TOTP_ISSUER }}
  TOTP_ISSUER: {{ .Values.totp.TOTP_ISSUER | quote }}
  {{- end }}
  {{- if .Values.totp.TOTP_DIGITS }}
  TOTP_DIGITS: {{ .Values.totp.TOTP_DIGITS | quote }}
  {{- end }}
  {{- if .Values.totp.TOTP_PERIOD }}
  TOTP_PERIOD: {{ .Values.totp.TOTP_PERIOD | quote }}
  {{- end }}
  {{- if .Values.totp.TOTP_MODE }}
  TOTP_MODE: {{ .Values.totp.TOTP_MODE | quote }}
  {{- end }}
  {{- end }}
  {{/* HEADER */}}
  {{- if eq .Values.header.HEADER_ENABLED true }}
  HEADER_ENABLED: {{ .Values.header.HEADER_ENABLED | quote }}
  {{- if .Values.header.HTTP_AUTH_HEADER }}
  HTTP_AUTH_HEADER: {{ .Values.header.HTTP_AUTH_HEADER | quote }}
  {{- end }}
  {{- end }}
  {{/* JSON */}}
  {{- if .Values.json.JSON_SECRET_KEY }}
  JSON_SECRET_KEY: {{ .Values.json.JSON_SECRET_KEY | quote }}
  {{- if .Values.json.JSON_TRUSTED_NETWORKS }}
  JSON_TRUSTED_NETWORKS: {{ .Values.json.JSON_TRUSTED_NETWORKS | quote }}
  {{- end }}
  {{- end }}
  {{/* DUO */}}
  {{- if and .Values.duo.DUO_API_HOSTNAME .Values.duo.DUO_INTEGRATION_KEY .Values.duo.DUO_SECRET_KEY .Values.duo.DUO_APPLICATION_KEY }}
  DUO_API_HOSTNAME: {{ .Values.duo.DUO_API_HOSTNAME | quote }}
  DUO_INTEGRATION_KEY: {{ .Values.duo.DUO_INTEGRATION_KEY | quote }}
  DUO_SECRET_KEY: {{ .Values.duo.DUO_SECRET_KEY | quote }}
  DUO_APPLICATION_KEY: {{ .Values.duo.DUO_APPLICATION_KEY | quote }}
  {{- end }}
  {{/* CAS */}}
  {{- if and .Values.cas.CAS_AUTHORIZATION_ENDPOINT .Values.cas.CAS_REDIRECT_URI }}
  CAS_AUTHORIZATION_ENDPOINT: {{ .Values.cas.CAS_AUTHORIZATION_ENDPOINT | quote }}
  CAS_REDIRECT_URI: {{ .Values.cas.CAS_REDIRECT_URI | quote }}
  {{- if .Values.cas.CAS_CLEARPASS_KEY }}
  CAS_CLEARPASS_KEY: {{ .Values.cas.CAS_CLEARPASS_KEY | quote }}
  {{- end }}
  {{- if .Values.cas.CAS_GROUP_ATTRIBUTE }}
  CAS_GROUP_ATTRIBUTE: {{ .Values.cas.CAS_GROUP_ATTRIBUTE | quote }}
  {{- if .Values.cas.CAS_GROUP_FORMAT }}
  CAS_GROUP_FORMAT: {{ .Values.cas.CAS_GROUP_FORMAT | quote }}
  {{- if eq .Values.cas.CAS_GROUP_FORMAT "ldap" }}
  {{- if .Values.cas.CAS_GROUP_LDAP_BASE_DN }}
  CAS_GROUP_LDAP_BASE_DN: {{ .Values.cas.CAS_GROUP_LDAP_BASE_DN | quote }}
  {{- if .Values.cas.CAS_GROUP_LDAP_ATTRIBUTE }}
  CAS_GROUP_LDAP_ATTRIBUTE: {{ .Values.cas.CAS_GROUP_LDAP_ATTRIBUTE | quote }}
  {{- end }}
  {{- end }}
  {{- end }}
  {{- end }}
  {{- end }}
  {{- end }}
  {{/* OpenID */}}
  {{- if and .Values.openid.OPENID_AUTHORIZATION_ENDPOINT .Values.openid.OPENID_JWKS_ENDPOINT .Values.openid.OPENID_ISSUER .Values.openid.OPENID_CLIENT_ID .Values.openid.OPENID_REDIRECT_URI }}
  OPENID_AUTHORIZATION_ENDPOINT: {{ .Values.openid.OPENID_AUTHORIZATION_ENDPOINT | quote }}
  OPENID_JWKS_ENDPOINT: {{ .Values.openid.OPENID_JWKS_ENDPOINT | quote }}
  OPENID_ISSUER: {{ .Values.openid.OPENID_ISSUER | quote }}
  OPENID_CLIENT_ID: {{ .Values.openid.OPENID_CLIENT_ID | quote }}
  OPENID_REDIRECT_URI: {{ .Values.openid.OPENID_REDIRECT_URI | quote }}
  {{- if .Values.openid.OPENID_USERNAME_CLAIM_TYPE }}
  OPENID_USERNAME_CLAIM_TYPE: {{ .Values.openid.OPENID_USERNAME_CLAIM_TYPE | quote }}
  {{- end }}
  {{- if .Values.openid.OPENID_GROUPS_CLAIM_TYPE }}
  OPENID_GROUPS_CLAIM_TYPE: {{ .Values.openid.OPENID_GROUPS_CLAIM_TYPE | quote }}
  {{- end }}
  {{- if .Values.openid.OPENID_MAX_TOKEN_VALIDITY }}
  OPENID_MAX_TOKEN_VALIDITY: {{ .Values.openid.OPENID_MAX_TOKEN_VALIDITY | quote }}
  {{- end }}
  {{- end }}
  {{/* RADIUS */}}
  {{- if and .Values.radius.RADIUS_SHARED_SECRET .Values.radius.RADIUS_AUTH_PROTOCOL }}
  RADIUS_SHARED_SECRET: {{ .Values.radius.RADIUS_SHARED_SECRET | quote }}
  RADIUS_AUTH_PROTOCOL: {{ .Values.radius.RADIUS_AUTH_PROTOCOL | quote }}
  {{- if .Values.radius.RADIUS_HOSTNAME }}
  RADIUS_HOSTNAME: {{ .Values.radius.RADIUS_HOSTNAME | quote }}
  {{- end }}
  {{- if .Values.radius.RADIUS_AUTH_PORT }}
  RADIUS_AUTH_PORT: {{ .Values.radius.RADIUS_AUTH_PORT | quote }}
  {{- end }}
  {{- if .Values.radius.RADIUS_KEY_FILE }}
  RADIUS_KEY_FILE: {{ .Values.radius.RADIUS_KEY_FILE | quote }}
  {{- end }}
  {{- if .Values.radius.RADIUS_KEY_TYPE }}
  RADIUS_KEY_TYPE: {{ .Values.radius.RADIUS_KEY_TYPE | quote }}
  {{- end }}
  {{- if .Values.radius.RADIUS_KEY_PASSWORD }}
  RADIUS_KEY_PASSWORD: {{ .Values.radius.RADIUS_KEY_PASSWORD | quote }}
  {{- end }}
  {{- if .Values.radius.RADIUS_CA_FILE }}
  RADIUS_CA_FILE: {{ .Values.radius.RADIUS_CA_FILE | quote }}
  {{- end }}
  {{- if .Values.radius.RADIUS_CA_TYPE }}
  RADIUS_CA_TYPE: {{ .Values.radius.RADIUS_CA_TYPE | quote }}
  {{- end }}
  {{- if .Values.radius.RADIUS_CA_PASSWORD }}
  RADIUS_CA_PASSWORD: {{ .Values.radius.RADIUS_CA_PASSWORD | quote }}
  {{- end }}
  {{- if .Values.radius.RADIUS_TRUST_ALL }}
  RADIUS_TRUST_ALL: {{ .Values.radius.RADIUS_TRUST_ALL | quote }}
  {{- end }}
  {{- if .Values.radius.RADIUS_RETRIES }}
  RADIUS_RETRIES: {{ .Values.radius.RADIUS_RETRIES | quote }}
  {{- end }}
  {{- if .Values.radius.RADIUS_TIMEOUT }}
  RADIUS_TIMEOUT: {{ .Values.radius.RADIUS_TIMEOUT | quote }}
  {{- end }}
  {{- if .Values.radius.RADIUS_EAP_TTLS_INNER_PROTOCOL }}
  RADIUS_EAP_TTLS_INNER_PROTOCOL: {{ .Values.radius.RADIUS_EAP_TTLS_INNER_PROTOCOL | quote }}
  {{- end }}
  {{- end }}
  {{/* LDAP */}}
  {{- if and .Values.ldap.LDAP_HOSTNAME .Values.ldap.LDAP_USER_BASE_DN }}
  LDAP_HOSTNAME: {{ .Values.ldap.LDAP_HOSTNAME | quote }}
  LDAP_USER_BASE_DN: {{ .Values.ldap.LDAP_USER_BASE_DN | quote }}
  {{- if .Values.ldap.LDAP_PORT }}
  LDAP_PORT: {{ .Values.ldap.LDAP_PORT | quote }}
  {{- end }}
  {{- if .Values.ldap.LDAP_ENCRYPTION_METHOD }}
  LDAP_ENCRYPTION_METHOD: {{ .Values.ldap.LDAP_ENCRYPTION_METHOD | quote }}
  {{- end }}
  {{- if .Values.ldap.LDAP_MAX_SEARCH_RESULTS }}
  LDAP_MAX_SEARCH_RESULTS: {{ .Values.ldap.LDAP_MAX_SEARCH_RESULTS | quote }}
  {{- end }}
  {{- if .Values.ldap.LDAP_SEARCH_BIND_DN }}
  LDAP_SEARCH_BIND_DN: {{ .Values.ldap.LDAP_SEARCH_BIND_DN | quote }}
  {{- end }}
  {{- if .Values.ldap.LDAP_USER_ATTRIBUTES }}
  LDAP_USER_ATTRIBUTES: {{ .Values.ldap.LDAP_USER_ATTRIBUTES | quote }}
  {{- end }}
  {{- if .Values.ldap.LDAP_SEARCH_BIND_PASSWORD }}
  LDAP_SEARCH_BIND_PASSWORD: {{ .Values.ldap.LDAP_SEARCH_BIND_PASSWORD | quote }}
  {{- end }}
  {{- if .Values.ldap.LDAP_USERNAME_ATTRIBUTE }}
  LDAP_USERNAME_ATTRIBUTE: {{ .Values.ldap.LDAP_USERNAME_ATTRIBUTE | quote }}
  {{- end }}
  {{- if .Values.ldap.LDAP_MEMBER_ATTRIBUTE }}
  LDAP_MEMBER_ATTRIBUTE: {{ .Values.ldap.LDAP_MEMBER_ATTRIBUTE | quote }}
  {{- end }}
  {{- if .Values.ldap.LDAP_USER_SEARCH_FILTER }}
  LDAP_USER_SEARCH_FILTER: {{ .Values.ldap.LDAP_USER_SEARCH_FILTER | quote }}
  {{- end }}
  {{- if .Values.ldap.LDAP_CONFIG_BASE_DN }}
  LDAP_CONFIG_BASE_DN: {{ .Values.ldap.LDAP_CONFIG_BASE_DN | quote }}
  {{- end }}
  {{- if .Values.ldap.LDAP_GROUP_BASE_DN }}
  LDAP_GROUP_BASE_DN: {{ .Values.ldap.LDAP_GROUP_BASE_DN | quote }}
  {{- end }}
  {{- if .Values.ldap.LDAP_GROUP_SEARCH_FILTER }}
  LDAP_GROUP_SEARCH_FILTER: {{ .Values.ldap.LDAP_GROUP_SEARCH_FILTER | quote }}
  {{- end }}
  {{- if .Values.ldap.LDAP_MEMBER_ATTRIBUTE_TYPE }}
  LDAP_MEMBER_ATTRIBUTE_TYPE: {{ .Values.ldap.LDAP_MEMBER_ATTRIBUTE_TYPE | quote }}
  {{- end }}
  {{- if .Values.ldap.LDAP_GROUP_NAME_ATTRIBUTE }}
  LDAP_GROUP_NAME_ATTRIBUTE: {{ .Values.ldap.LDAP_GROUP_NAME_ATTRIBUTE | quote }}
  {{- end }}
  {{- if .Values.ldap.LDAP_DEREFERENCE_ALIASES }}
  LDAP_DEREFERENCE_ALIASES: {{ .Values.ldap.LDAP_DEREFERENCE_ALIASES | quote }}
  {{- end }}
  {{- if eq .Values.ldap.LDAP_FOLLOW_REFERRALS "true"}}
  LDAP_FOLLOW_REFERRALS: {{ .Values.ldap.LDAP_FOLLOW_REFERRALS | quote }}
  {{- if .Values.ldap.LDAP_MAX_REFERRAL_HOPS }}
  LDAP_MAX_REFERRAL_HOPS: {{ .Values.ldap.LDAP_MAX_REFERRAL_HOPS | quote }}
  {{- end }}
  {{- end }}
  {{- if .Values.ldap.LDAP_OPERATION_TIMEOUT }}
  LDAP_OPERATION_TIMEOUT: {{ .Values.ldap.LDAP_OPERATION_TIMEOUT | quote }}
  {{- end }}
  {{- end }}
  {{/* SAML */}}
  {{- if or .Values.saml.SAML_IDP_METADATA_URL ( and ( .Values.saml.SAML_ENTITY_ID ) ( .Values.saml.SAML_CALLBACK_URL ) ) }}
  {{- if .Values.saml.SAML_IDP_METADATA_URL }}
  SAML_IDP_METADATA_URL: {{ .Values.saml.SAML_IDP_METADATA_URL | quote }}
  {{- end }}
  {{- if .Values.saml.SAML_ENTITY_ID }}
  SAML_ENTITY_ID: {{ .Values.saml.SAML_ENTITY_ID | quote }}
  {{- end }}
  {{- if .Values.saml.SAML_CALLBACK_URL }}
  SAML_CALLBACK_URL: {{ .Values.saml.SAML_CALLBACK_URL | quote }}
  {{- end }}
  {{- if .Values.saml.SAML_IDP_URL }}
  SAML_IDP_URL: {{ .Values.saml.SAML_IDP_URL | quote }}
  {{- end }}
  {{- if .Values.saml.SAML_STRICT }}
  SAML_STRICT: {{ .Values.saml.SAML_STRICT | quote }}
  {{- end }}
  {{- if .Values.saml.SAML_DEBUG }}
  SAML_DEBUG: {{ .Values.saml.SAML_DEBUG | quote }}
  {{- end }}
  {{- if .Values.saml.SAML_COMPRESS_REQUEST }}
  SAML_COMPRESS_REQUEST: {{ .Values.saml.SAML_COMPRESS_REQUEST | quote }}
  {{- end }}
  {{- if .Values.saml.SAML_COMPRESS_RESPONSE }}
  SAML_COMPRESS_RESPONSE: {{ .Values.saml.SAML_COMPRESS_RESPONSE | quote }}
  {{- end }}
  {{- if .Values.saml.SAML_GROUP_ATTRIBUTE }}
  SAML_GROUP_ATTRIBUTE: {{ .Values.saml.SAML_GROUP_ATTRIBUTE | quote }}
  {{- end }}
  {{- end }}
  {{/* PROXY */}}
  {{- if .Values.proxy.REMOTE_IP_VALVE_ENABLED }}
  REMOTE_IP_VALVE_ENABLED: {{ .Values.proxy.REMOTE_IP_VALVE_ENABLED | quote }}
  {{- if .Values.proxy.PROXY_BY_HEADER }}
  PROXY_BY_HEADER: {{ .Values.proxy.PROXY_BY_HEADER | quote }}
  {{- end }}
  {{- if .Values.proxy.PROXY_PROTOCOL_HEADER }}
  PROXY_PROTOCOL_HEADER: {{ .Values.proxy.PROXY_PROTOCOL_HEADER | quote }}
  {{- end }}
  {{- if .Values.proxy.PROXY_PROTOCOL_HEADER }}
  PROXY_PROTOCOL_HEADER: {{ .Values.proxy.PROXY_PROTOCOL_HEADER | quote }}
  {{- end }}
  {{- if .Values.proxy.PROXY_IP_HEADER }}
  PROXY_IP_HEADER: {{ .Values.proxy.PROXY_IP_HEADER | quote }}
  {{- end }}
  {{- if .Values.proxy.PROXY_ALLOWED_IPS_REGEX }}
  PROXY_ALLOWED_IPS_REGEX: {{ .Values.proxy.PROXY_ALLOWED_IPS_REGEX | quote }}
  {{- end }}
  {{- end }}
{{- end -}}
