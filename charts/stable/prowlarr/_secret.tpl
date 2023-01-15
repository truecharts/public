{{/* Define the secret */}}
{{- define "prowlarr.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}
{{- $prowlarr := .Values.prowlarr -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  {{- if $prowlarr.auth }}
  PROWLARR__AUTHENTICATION_METHOD: "External"
  {{- end }}
{{- end -}}
