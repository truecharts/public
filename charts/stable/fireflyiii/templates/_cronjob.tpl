{{/* Define the cronjob */}}
{{- define "fireflyiii.cronjob" -}}
{{- $jobName := include "common.names.fullname" . }}

---
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: {{ printf "%s-cronjob" $jobName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
spec:
  schedule: "{{ .Values.cronjob.schedule }}"
  concurrencyPolicy: Forbid
  {{- with .Values.cronjob.failedJobsHistoryLimit }}
  failedJobsHistoryLimit: {{ . }}
  {{- end }}
  {{- with .Values.cronjob.successfulJobsHistoryLimit }}
  successfulJobsHistoryLimit: {{ . }}
  {{- end }}
  jobTemplate:
    metadata:
    spec:
      template:
        metadata:
        spec:
          restartPolicy: Never
          containers:
            - name: {{ .Chart.Name }}
              image: radial/busyboxplus:curl
              imagePullPolicy: {{ default .Values.image.pullPolicy }}
              args:
              - curl
              - "http://{{ $jobName }}.ix-{{ .Release.Name }}.svc.cluster.local:{{ .Values.service.main.ports.main.port }}/api/v1/cron/{{ .Values.env.STATIC_CRON_TOKEN }}"
              resources:
{{ toYaml .Values.resources | indent 16 }}

{{- end -}}
