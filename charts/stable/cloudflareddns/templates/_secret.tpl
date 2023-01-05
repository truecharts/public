{{/* Define the secret */}}
{{- define "cloudflareddns.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}

---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
stringData:

  {{/* API */}}

  {{- with .cloudflareddns.api_token }}
  CF_APITOKEN: {{ . | quote }}
  {{- end }}

  {{- with .cloudflareddns.api_key }}
  CF_APIKEY: {{ . | quote }}
  {{- end }}

  {{- with .cloudflareddns.api_token_zone }}
  CF_APITOKEN_ZONE: {{ . | quote }}
  {{- end }}

  {{- with .cloudflareddns.user }}
  CF_USER: {{ . | quote }}
  {{- end }}

  {{- with .cloudflareddns.interval }}
  INTERVAL: {{ . | quote }}
  {{- end }}

  {{- with .cloudflareddns.log_level }}
  LOG_LEVEL: {{ . | quote }}
  {{- end }}

  {{/* TODO host_and_record  */}}


{{- end -}}
