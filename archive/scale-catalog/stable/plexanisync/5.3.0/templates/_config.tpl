{{- define "plexanisync.config" -}}
{{- $pas := .Values.plexanisync }}
enabled: true
data:
  SETTINGS_FILE: {{ .Values.persistence.settings.mountPath }}
  INTERVAL: {{ $pas.interval | quote }}
{{- end -}}
