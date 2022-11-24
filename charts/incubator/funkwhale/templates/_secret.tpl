{{/* Define the secret */}}
{{- define "funkwhale.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) -}}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  DJANGO_SECRET_KEY: {{ (index .data "DJANGO_SECRET_KEY") }}
  {{- else }}
  DJANGO_SECRET_KEY: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
{{- end -}}
