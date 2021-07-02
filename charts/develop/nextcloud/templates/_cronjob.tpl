{{/* Define the cronjob */}}
{{- define "nextcloud.cronjob" -}}
{{- $jobName := include "common.names.fullname" . -}}
---
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: {{ printf "%s-auto-permissions" $jobName }}
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
              image: "{{ default .Values.image.repository .Values.cronjob.image.repository }}:{{ default .Values.image.tag .Values.cronjob.image.tag }}"
              imagePullPolicy: {{ default .Values.image.pullPolicy .Values.cronjob.image.pullPolicy }}
              command: [ "curl" ]
              args:
                - "-k"
                - "--fail"
                - "-L"
                - "http://{{ template "common.names.fullname" . }}:{{ .Values.service.port }}/cron.php"
              # Will mount configuration files as www-data (id: 33) for nextcloud
              securityContext:
                {{- if .Values.securityContext }}
                {{- with .Values.securityContext }}
                {{- toYaml . | nindent 17 }}
                {{- end }}
                {{- end }}
              {{- end }}
              resources:
{{ toYaml (default .Values.resources .Values.cronjob.resources) | indent 16 }}
          {{- if .Values.rbac.enabled }}
          serviceAccountName: {{ .Values.rbac.serviceaccount.name }}
          {{- end }}
    {{- with (default .Values.nodeSelector .Values.cronjob.nodeSelector) }}
          nodeSelector:
{{ toYaml . | indent 12 }}
    {{- end }}
    {{- with (default .Values.affinity .Values.cronjob.affinity) }}
          affinity:
{{ toYaml . | indent 12 }}
    {{- end }}
    {{- with (default .Values.tolerations .Values.cronjob.tolerations) }}
          tolerations:
{{ toYaml . | indent 12 }}
    {{- end }}
{{- end }}
{{- end -}}
