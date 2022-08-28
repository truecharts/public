{{/* Define the secrets */}}
{{- define "wg.config-secret" -}}

{{- $secretName := printf "%s-wg-config-secret" (include "tc.common.names.fullname" .) }}
---
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  wg0.conf: |
{{ .Values.wg.config.data | b64enc | indent 4 }}
{{- end -}}
