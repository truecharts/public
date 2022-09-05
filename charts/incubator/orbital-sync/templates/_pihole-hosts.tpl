{{- define "orbital.hosts" -}}

{{- $secretName := printf "%s-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  PRIMARY_HOST_BASE_URL: {{ .Values.orbital.primary_host_base_url | b64enc }}
  PRIMARY_HOST_PASSWORD: {{ .Values.orbital.primary_host_password | b64enc }}
  {{- with .Values.orbital.honeybadger_api_key }}
  HONEYBADGER_API_KEY: {{ . | b64enc }}
  {{- end }}

{{ $idx := 1 }}
{{- range .Values.orbital.secondary_hosts }}
  SECONDARY_HOST_{{$idx}}_BASE_URL: {{ .host | b64enc }}
  SECONDARY_HOST_{{$idx}}_PASSWORD: {{ .password | b64enc }}
  {{ $idx = add1 $idx }}
{{- end }}
{{- end -}}
