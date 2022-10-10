{{/* Define the configmap */}}
{{- define "cherry.configmap" -}}

{{- $configName := printf "%s-cherry-configmap" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:  {{- include "tc.common.labels" . | nindent 4 }}
data:
  DATABASE_PATH: /data/cherry.sqlite
  ENABLE_PUBLIC_REGISTRATION: {{ ternary "1" "0" .Values.cherry.public_registration  | quote }}
  USE_INSECURE_COOKIE: {{ ternary "1" "0" .Values.cherry.insecure_cookie | quote }}
  PAGE_BOOKMARK_LIMIT: {{ .Values.cherry.page_bookmark_limit | quote }}
  {{- with .Values.cherry.google_oauth_uri }}
  GOOGLE_OAUTH_REDIRECT_URI: {{ . }}
  {{- end }}
{{- end -}}
