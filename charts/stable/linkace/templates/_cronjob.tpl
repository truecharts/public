{{/* Define the cronjob */}}
{{- define "linkace.cronjob" -}}
{{- if .Values.secret.CRON_TOKEN }}
{{- $basename := include "tc.v1.common.lib.chart.names.fullname" $ -}}
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
      - "http://{{ $basename }}.ix-{{ .Release.Name }}.svc.cluster.local:{{ .Values.service.main.ports.main.port }}/cron/$(CRON_TOKEN)"



{{- end -}}
{{- end }}
