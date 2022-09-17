{{/* Define the secret */}}
{{- define "umami.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}

---

{{/* This secrets are loaded on both main authentik container and worker */}}
apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{/* Secret Key */}}
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  HASH_SALT: {{ index .data "HASH_SALT" }}
  {{- else }}
  HASH_SALT: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
{{- end }}
