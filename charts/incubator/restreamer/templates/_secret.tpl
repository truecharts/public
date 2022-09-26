{{/* Define the secrets */}}
{{- define "restreamer.secrets" -}}

{{- $secretName := printf "%s-restreamer-secret" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
data:
  {{- with (lookup "v1" "Secret" .Release.Namespace $secretName) }}
  CORE_API_AUTH_JWT_SECRET: {{ index .data "CORE_API_AUTH_JWT_SECRET" }}
  {{- else }}
  CORE_API_AUTH_JWT_SECRET: {{ randAlphaNum 32 | b64enc }}
  {{- end }}
  {{- with .Values.restreamer.api.api_auth_username }}
  CORE_API_AUTH_USERNAME: {{ . | b64enc }}
  {{- end }}
  {{- with .Values.restreamer.api.api_auth_password }}
  CORE_API_AUTH_PASSWORD: {{ .| b64enc }}
  {{- end }}
  {{- with .Values.restreamer.storage_mem.storage_mem_auth_username }}
  CORE_STORAGE_MEMORY_AUTH_USERNAME: {{ . | b64enc }}
  {{- end }}
  {{- with .Values.restreamer.storage_mem.storage_mem_auth_password }}
  CORE_STORAGE_MEMORY_AUTH_PASSWORD: {{ . | b64enc }}
  {{- end }}
  {{- with .Values.restreamer.rtmp.rtmp_token }}
  CORE_RTMP_TOKEN: {{ . | b64enc }}
  {{- end }}
{{- end -}}
