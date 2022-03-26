{{/* Define the cronjob */}}
{{- define "clamav.cronjob" -}}
{{- $jobName := include "common.names.fullname" . }}

---
apiVersion: batch/v1
kind: CronJob
metadata:
  name: {{ printf "%s-cronjob" $jobName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
spec:
  schedule: "{{ .Values.clamav.cron_schedule }}"
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
              image: "{{ .Values.iamge.repository }}:{{ .Values.iamge.tag }}"
              command: ["sh", "-c"]
              args:
                - >
                  echo "Starting scan of \"/scandir\"";
                  clamdscan /scandir;
                  echo "Scan finished!";
              resources:
{{ toYaml .Values.resources | indent 16 }}
{{- end -}}
