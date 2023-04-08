{{/* Define the cronjob */}}
{{- define "fireflyiii.cronjob" -}}
{{- $basename := include "tc.v1.common.lib.chart.names.fullname" $ -}}
enabled: true
type: "CronJob"
schedule: "0 8 * * *"
podSpec:
  restartPolicy: Never
  containers:
    cron:
      enabled: true
      primary: true
      probes:
        startup:
          enabled: false
        readiness:
          enabled: false
        liveness:
          enabled: false
      imageSelector: alpineImage
      args:
      - curl
      - "http://{{ $basename }}.ix-{{ .Release.Name }}.svc.cluster.local:{{ .Values.service.main.ports.main.port }}/api/v1/cron/$(STATIC_CRON_TOKEN)"
      env:
        STATIC_CRON_TOKEN:
          secretKeyRef:
            name: secrets
            key: STATIC_CRON_TOKEN



{{- end -}}
