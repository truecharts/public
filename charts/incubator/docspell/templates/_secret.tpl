{{/* Define the secret */}}
{{- define "docspell.secret" -}}

{{- $secretName := printf "%s-docspell-secret" (include "tc.common.names.fullname" .) }}

{{ $server := .Values.rest_server }}
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
  DOCSPELL_SERVER_AUTH_SERVER__SECRET: {{ index .data "DOCSPELL_SERVER_AUTH_SERVER__SECRET" }}
  {{- else }}
  {{/* This should ensure that container receivers something like b64:ENCODEDSECRET */}}
  DOCSPELL_SERVER_AUTH_SERVER__SECRET: {{ printf "b64:%v" (randAlphaNum 32 | b64enc) | b64enc }}
  {{- end }}

  {{- with $server.admin_endpoint.secret }}
  DOCSPELL_SERVER_ADMIN__ENDPOINT_SECRET: {{ . | b64enc }}
  {{- end }}













{{- end }}
