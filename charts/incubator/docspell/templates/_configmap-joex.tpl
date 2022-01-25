{{/* Define the configmap */}}
{{- define "docspell-joex.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: docspell-joex-env
data:
  DOCSPELL_JOEX_JDBC_USER: "{{ .Values.postgresql.postgresqlUsername }}"
  {{/* General */}}
  DOCSPELL_JOEX_APP__ID: "{{ .Values.joex.app.id }}"
  DOCSPELL_JOEX_BASE__URL: "{{ .Values.joex.app.base_url }}"
  DOCSPELL_JOEX_BIND_ADDRESS: "{{ .Values.joex.app.bind_address }}"
  DOCSPELL_JOEX_BIND_PORT: "{{ .Values.joex.app.bind_port }}"
  {{/* SOLR */}}
  DOCSPELL_JOEX_FULL__TEXT__SEARCH_ENABLED: "{{ .Values.joex.solr.enabled }}"
  DOCSPELL_JOEX_FULL__TEXT__SEARCH_SOLR_URL: "{{ .Values.joex.solr.url }}"
{{- end -}}
