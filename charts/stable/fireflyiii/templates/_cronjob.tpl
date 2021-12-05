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
          {{- with (include "common.controller.volumes" . | trim) }}
          volumes:
            {{- nindent 12 . }}
          {{- end }}
          containers:
            - name: {{ .Chart.Name }}
              image: "{{ .Values.image.repository }}:{{ default .Values.image.tag }}"
              imagePullPolicy: {{ default .Values.image.pullPolicy }}
              command: [ "php" ]
              args:
                - "/var/www/html/artisan firefly-iii:cron"
              # Will mount configuration files as root (id: 0) by default for fireflyiii
              {{- with (include "common.controller.volumeMounts" . | trim) }}
              volumeMounts:
                {{ nindent 16 . }}
              {{- end }}
              securityContext:
                runAsUser: 0
                runAsGroup: 0
              resources:
{{ toYaml .Values.resources | indent 16 }}

{{- end -}}
