{{/* Radicale htpasswd file */}}
{{- define "radicale.secret" -}}
---
apiVersion: v1
kind: Secret
metadata:
  name: radicale-secret
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:
  users: |-
    {{- range .Values.radicale.auth.users }}
    {{ htpasswd .username .password }}
    {{- end }}

{{- end }}
