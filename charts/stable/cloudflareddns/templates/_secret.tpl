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

  {{- $cfddns := get .Values "cloudflareddns" }}

  {{/* API */}}
  {{- with $cfddns.api_token }}
  CF_APITOKEN: {{ . | quote }}
  {{- end }}

  {{- with $cfddns.api_key }}
  CF_APIKEY: {{ . | quote }}
  {{- end }}

  {{- with $cfddns.api_token_zone }}
  CF_APITOKEN_ZONE: {{ . | quote }}
  {{- end }}

  {{- with $cfddns.user }}
  CF_USER: {{ . | quote }}
  {{- end }}

  {{- with $cfddns.interval }}
  INTERVAL: {{ . | quote }}
  {{- end }}

  {{- with $cfddns.log_level }}
  LOG_LEVEL: {{ . | quote }}
  {{- end }}

  DETECTION_MODE: {{ ternary $cfddns.detect_mode $cfddns.detection_mode (eq $cfddns.detection_mode "") | quote }}

  {{/* TODO host_and_record  */}}

{{- end -}}
