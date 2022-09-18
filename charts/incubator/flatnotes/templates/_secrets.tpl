{{/* Define the secrets */}}
{{- define "flatnotes.secrets" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}
---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  FLATNOTES_SECRET_KEY: {{ index .data "FLATNOTES_SECRET_KEY" }}
  {{- else }}
  FLATNOTES_SECRET_KEY: {{ randAlphaNum 32 | b64enc }}
  {{- end }}

{{- end -}}
