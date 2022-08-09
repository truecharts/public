{{/* Define the secret */}}
{{- define "authentik.secret" -}}

{{- $authentikSecretName := printf "%s-authentik-secret" (include "tc.common.names.fullname" .) }}
{{- $geoipSecretName := printf "%s-geoip-secret" (include "tc.common.names.fullname" .) }}
{{- $ldapSecretName := printf "%s-ldap-secret" (include "tc.common.names.fullname" .) }}

---
{{/* This secrets are loaded on ldap container */}}
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $ldapSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{/* Placeholder in case of empty secret */}}
  PLACEHOLDER: "PLACEHOLDER"
  {{- with .Values.outposts.ldap.token }}
  AUTHENTIK_TOKEN: {{ . }}
  {{- end }}
---
{{/* This secrets are loaded on geoip container */}}
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $geoipSecretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{/* Placeholder in case of empty secret */}}
  PLACEHOLDER: "PLACEHOLDER"
  {{/* Credentials */}}
  {{- with .Values.geoip.account_id }}
  GEOIPUPDATE_ACCOUNT_ID: {{ . }}
  {{- end }}
  {{- with .Values.geoip.license_key }}
  GEOIPUPDATE_LICENSE_KEY: {{ . }}
  {{- end }}
  {{/* Proxy */}}
  {{- with .Values.geoip.proxy }}
  GEOIPUPDATE_PROXY: {{ . }}
  {{- end }}
  {{- with .Values.geoip.proxy_user_pass }}
  GEOIPUPDATE_PROXY_USER_PASSWORD: {{ . }}
  {{- end }}
{{- end }}
