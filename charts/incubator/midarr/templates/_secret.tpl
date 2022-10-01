{{/* Define the secret */}}
{{- define "midarr.secret" -}}

{{- $secretName := printf "%s-secret" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: Secret
type: Opaque
metadata:
  name: {{ $secretName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  DB_PASSWORD: {{ .Values.postgresql.postgresqlPassword | trimAll "\"" | b64enc }}
  {{- with .Values.midarr.admin.pass }}
  SETUP_ADMIN_PASSWORD: {{ . | b64enc }}
  {{- end }}
  {{- with .Values.midarr.radarr.api_key }}
  RADARR_API_KEY: {{ . | b64enc }}
  {{- end }}
  {{- with .Values.midarr.sonarr.api_key }}
  SONARR_API_KEY: {{ . | b64enc }}
  {{- end }}
  {{- with .Values.midarr.general.sendgrid_api_key }}
  SENDGRID_API_KEY: {{ . | b64enc }}
  {{- end }}
{{- end }}
