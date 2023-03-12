{{/* Define the cronjob */}}
{{- define "linkace.cronjob" -}}
{{- if .Values.secret.CRON_TOKEN }}
enabled: true
type: "CronJob"

podSpec:
  restartPolicy: Never
  containers:
    cron:
      env:
        CRON_TOKEN: {{ .Values.secret.CRON_TOKEN }}
      enabled: true
      imageSelector: ubuntuImage
      args:
      - curl
      - "http://{{ $jobName }}.ix-{{ .Release.Name }}.svc.cluster.local:{{ .Values.service.main.ports.main.port }}/cron/$(CRON_TOKEN)"



{{- end -}}
{{- end }}
