{{/* Define the secret */}}
{{- define "softserve.secret" -}}
enabled: true
data:
  SOFT_SERVE_BIND_ADDRESS: "0.0.0.0"
  SOFT_SERVE_REPO_PATH: {{ .Values.persistence.repos.mountPath | quote }}
  SOFT_SERVE_PORT: {{ .Values.service.main.ports.main.port | quote }}
  SOFT_SERVE_HOST: {{ .Values.softserve.host | quote }}
  SOFT_SERVE_KEY_PATH: {{ .Values.softserve.key_path | quote }}
  SOFT_SERVE_INITIAL_ADMIN_KEY: {{ .Values.softserve.init_admin_key | quote }}
{{- end }}
