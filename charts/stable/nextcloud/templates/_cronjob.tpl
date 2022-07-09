{{/* Define the cronjob */}}
{{- define "nextcloud.cronjob" -}}
{{- if .Values.cronjob.enabled -}}
{{- $jobName := include "tc.common.names.fullname" . }}

---
apiVersion: batch/v1
kind: CronJob
metadata:
  name: {{ printf "%s-cronjob" $jobName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
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
          {{- with (include "tc.common.controller.volumes" . | trim) }}
          volumes:
            {{- nindent 12 . }}
          {{- end }}
          containers:
            - name: {{ .Chart.Name }}
              image: '{{ include "tc.common.images.selector" . }}'
              imagePullPolicy: {{ default .Values.image.pullPolicy }}
              command:
                - "/bin/sh"
                - "-c"
                - |
                  /bin/bash <<'EOF'
                  echo "running nextcloud cronjob..."
                  php -f /var/www/html/cron.php
                  echo "cronjob finished"
                  {{- if .Values.cronjob.generatePreviews }}
                  echo "Pre-generating Previews..."
                  php /var/www/html/occ preview:pre-generate
                  echo "Previews generated."
                  {{- end }}
                  EOF
              # Will mount configuration files as www-data (id: 33) by default for nextcloud
              {{- with (include "tc.common.controller.volumeMounts" . | trim) }}
              volumeMounts:
                {{ nindent 16 . }}
              {{- end }}
              securityContext:
                runAsUser: 33
                runAsGroup: 33
                readOnlyRootFilesystem: true
                runAsNonRoot: true
              resources:
{{ toYaml .Values.resources | indent 16 }}
{{- end -}}
{{- end -}}
