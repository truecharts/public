{{/* Define the cronjob */}}
{{- define "plextraktsync.cronjob" -}}
enabled: true
type: "CronJob"
schedule: "{{ .Values.plextraktsync.schedule }}"
podSpec:
  restartPolicy: Never
  containers:
    cron:
      enabled: true
      primary: true
      imageSelector: "image"
      command:
          - plextraktsync
          {{- if  .Values.plextraktsync.task }}
          - {{ .Values.plextraktsync.task }}
          {{- else }}
          - sync --sync=all
          {{- end }}
      probes:
        liveness:
          enabled: false
        readiness:
          enabled: false
        startup:
          enabled: false
{{- end -}}
