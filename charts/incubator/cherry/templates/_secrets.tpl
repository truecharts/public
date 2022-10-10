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
  {{- with .Values.cherry.google_oauth_id }}
  GOOGLE_OAUTH_CLIENT_ID: {{ . | b64enc }}
  {{- end }}
  {{- with .Values.cherry.google_oauth_secret }}
  GOOGLE_OAUTH_CLIENT_SECRET: {{ . | b64enc }}
  {{- end }}
{{- end -}}
