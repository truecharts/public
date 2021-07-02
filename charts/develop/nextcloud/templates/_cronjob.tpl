{{/* Define the cronjob */}}
{{- define "nextcloud.cronjob" -}}
{{- $jobName := include "common.names.fullname" . -}}

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
              image: "{{ .Values.image.repository }}:{{ default .Values.image.tag }}"
              imagePullPolicy: {{ default .Values.image.pullPolicy }}
              command: [ "curl" ]
              args:
                - "-k"
                - "--fail"
                - "-L"
                - "http://{{ template "common.names.fullname" . }}:{{ .Values.service.main.ports.main.port }}/cron.php"
              # Will mount configuration files as www-data (id: 33) by default for nextcloud
              securityContext:
                {{- if .Values.securityContext }}
                {{- with .Values.securityContext }}
                {{- toYaml . | nindent 17 }}
                {{- end }}
                {{- end }}
              resources:
{{ toYaml .Values.resources | indent 16 }}

{{- end -}}
