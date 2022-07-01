{{/* EteSync superuser credentials and Django SECRET_KEY */}}
{{- define "etesync.secret" -}}
---
{{- $secretName := "etesync-secret" }}
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  secret.txt: {{ index .data "secret.txt" }}
  {{- else }}
  secret.txt: {{ randAlphaNum 32 | b64enc }}
  {{- end }}

{{- end }}
