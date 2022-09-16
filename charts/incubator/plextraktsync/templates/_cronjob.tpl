{{/* Define the cronjob */}}
{{- define "plextraktsync.cronjob" -}}
{{- $jobName := include "tc.common.names.fullname" . }}

---
apiVersion: batch/v1
kind: CronJob
metadata:
  name: {{ printf "%s-cronjob" $jobName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
spec:
  schedule: "{{ .Values.plexTraktSync.schedule }}"
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
          securityContext:
            runAsUser: 0
            runAsGroup: 0
          restartPolicy: Never
          containers:
            - name: {{ .Chart.Name }}
              securityContext:
                privileged: false
                readOnlyRootFilesystem: false
                allowPrivilegeEscalation: false
                runAsNonRoot: false
                capabilities:
                  drop:
                    - ALL
              image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
              command:
                - plextraktsync
                {{- if .Values.plexTraktSync.task }}
                - {{ .Values.plexTraktSync.task }}
                {{- else }}
                - sync --sync=all
                {{- end }}
              resources:
{{ toYaml .Values.resources | indent 16 }}

{{- end -}}
