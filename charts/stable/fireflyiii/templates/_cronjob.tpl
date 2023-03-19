{{/* Define the cronjob */}}
{{- define "fireflyiii.cronjob" -}}

enabled: true
type: "CronJob"
schedule: "0 8 * * *"
podSpec:
  restartPolicy: Never
  containers:
    cron:
      env:
        STATIC_CRON_TOKEN:
          valueFrom:
            secretKeyRef:
              name: fireflyiii-secrets
              key: STATIC_CRON_TOKEN
      enabled: true
      imageSelector: ubuntuImage
      args:
      - curl
      - "http://{{ $jobName }}.ix-{{ .Release.Name }}.svc.cluster.local:{{ .Values.service.main.ports.main.port }}/api/v1/cron/$(STATIC_CRON_TOKEN)"



{{- end -}}
