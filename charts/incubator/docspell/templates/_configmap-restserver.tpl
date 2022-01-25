{{/* Define the configmap */}}
{{- define "docspell-restserver.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: docspell-restserver-env
data:
  DOCSPELL_SERVER_BACKEND_JDBC_USER: "{{ .Values.postgresql.postgresqlUsername }}"
  {{/* General */}}
  DOCSPELL_SERVER_APP__ID: "restserver-{{ randAlphaNum 10 }}"
  DOCSPELL_SERVER_APP__NAME: "{{ .Values.rest.app.name }}"
  DOCSPELL_SERVER_BACKEND_FILES_CHUNK__SIZE: "{{ .Values.rest.app.chunk_size }}"
  DOCSPELL_SERVER_INTERNAL__URL: "http://{{ include "common.names.fullname" . }}.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.service.main.ports.main.port }}"
  DOCSPELL_SERVER_BASE__URL: "{{ .Values.rest.app.base_url }}"
  DOCSPELL_SERVER_MAX__ITEM__PAGE__SIZE: "{{ .Values.rest.app.max_page_size }}"
  DOCSPELL_SERVER_MAX__NOTE__LENGTH: "{{ .Values.rest.app.max_char_length }}"
  DOCSPELL_SERVER_SHOW__CLASSIFICATION__SETTINGS: "{{ .Values.rest.app.classification_enabled }}"
  DOCSPELL_SERVER_BIND_ADDRESS: {{ .Values.rest.app.bind_address}}
  DOCSPELL_SERVER_BIND_PORT: "{{ .Values.service.main.ports.main.port }}"
  {{/* Mail */}}
  DOCSPELL_SERVER_BACKEND_MAIL__DEBUG: "{{ .Values.rest.mail.debug_enabled }}"
  {{/* SOLR */}}
  DOCSPELL_SERVER_FULL__TEXT__SEARCH_ENABLED: "{{ .Values.rest.solr.enabled }}"
  DOCSPELL_SERVER_FULL__TEXT__SEARCH_SOLR_COMMIT__WITHIN: "{{ .Values.rest.solr.commit_within}}"
  DOCSPELL_SERVER_FULL__TEXT__SEARCH_SOLR_DEF__TYPE: "{{ .Values.rest.solr.parser }}"
  DOCSPELL_SERVER_FULL__TEXT__SEARCH_SOLR_LOG__VERBOSE: "{{ .Values.rest.solr.debug_enabled }}"
  DOCSPELL_SERVER_FULL__TEXT__SEARCH_SOLR_Q__OP: "{{ .Values.rest.solr.combiner }}"
  DOCSPELL_SERVER_FULL__TEXT__SEARCH_SOLR_URL: "http://{{ include "common.names.fullname" . }}.{{ .Release.Namespace }}.svc.cluster.local:{{ .Values.service.solr.ports.solr.port }}/solr/docspell"
  {{/* Auth */}}
  DOCSPELL_SERVER_AUTH_REMEMBER__ME_ENABLED: "{{ .Values.rest.auth.remember_me_enabled }}"
  DOCSPELL_SERVER_AUTH_REMEMBER__ME_VALID: "{{ .Values.rest.auth.remember_me_valid }}"
  DOCSPELL_SERVER_AUTH_SESSION__VALID: "{{ .Values.rest.auth.session_valid }}"
  DOCSPELL_SERVER_AUTH_SERVER__SECRET: "{{ .Values.rest.auth.server_secret }}"
  DOCSPELL_SERVER_ADMIN__ENDPOINT_SECRET: "{{ .Values.rest.auth.admin_endpoint_secret }}"
  {{/* Singup */}}
  DOCSPELL_SERVER_BACKEND_SIGNUP_MODE: "{{ .Values.rest.singup.mode }}"
  DOCSPELL_SERVER_BACKEND_SIGNUP_INVITE__TIME: "{{ .Values.rest.singup.invite_time }}"
  DOCSPELL_SERVER_BACKEND_SIGNUP_NEW__INVITE__PASSWORD: "{{ .Values.rest.singup.invite_password }}"
  {{/* Integration */}}
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_ENABLED: "{{ .Values.rest.integration.enabled }}"
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_PRIORITY: "{{ .Values.rest.integration.priority }}"
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_SOURCE__NAME: "{{ .Values.rest.integration.source_name }}"
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_ALLOWED__IPS_ENABLED: "{{ .Values.rest.integration.allowed_ips_enabled }}"
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_HTTP__BASIC_ENABLED: "{{ .Values.rest.integration.http_basic_enabled }}"
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_HTTP__HEADER_ENABLED: "{{ .Values.rest.integration.http_header_enabled }}"
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_HTTP__HEADER_HEADER__NAME: "{{ .Values.rest.integration.http_header_name }}"
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_HTTP__HEADER_HEADER__VALUE: "{{ .Values.rest.integration.http_header_value }}"
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_HTTP__BASIC_USER: "{{ .Values.rest.integration.http_basic_user }}"
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_HTTP__BASIC_PASSWORD: "{{ .Values.rest.integration.http_basic_password }}"
  DOCSPELL_SERVER_INTEGRATION__ENDPOINT_HTTP__BASIC_REALM: "{{ .Values.rest.integration.http_basic_realm }}"
{{- end -}}
