{{/* Define the configmap */}}
{{- define "briefkasten.config" -}}

{{- $configName := printf "%s-config" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{- with .Values.briefkasten.general.nextauth_url }}
  NEXTAUTH_URL: {{ . }}
  {{- end }}
  {{- with .Values.briefkasten.supabase.url }}
  SUPABASE_URL: {{ . }}
  {{- end }}
  {{- with .Values.briefkasten.mail.server }}
  SMTP_SERVER: {{ . }}
  {{- end }}
  {{- with .Values.briefkasten.mail.from }}
  SMTP_FROM: {{ . }}
  {{- end }}
{{- end -}}
