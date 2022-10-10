{{/* Define the secrets */}}
{{- define "cherry.secrets" -}}

{{- $secretName := printf "%s-cherry-secret" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  JWT_SECRET: {{ index .data "JWT_SECRET" }}
  {{- else }}
  JWT_SECRET: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  GOOGLE_OAUTH_CLIENT_ID: {{ .Values.cherry.google_oauth_id | b64enc }}
  GOOGLE_OAUTH_CLIENT_SECRET: {{ .Values.cherry.google_oauth_secret | b64enc }}
{{- end -}}
