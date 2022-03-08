{{/* Define the cronjob */}}
{{- define "matomo.cronjob" -}}
{{- $jobName := include "common.names.fullname" . }}

---
apiVersion: batch/v1
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
          securityContext:
            runAsUser: {{ .Values.podSecurityContext.runAsUser }}
            runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
          restartPolicy: Never
          {{- with (include "common.controller.volumes" . | trim) }}
          volumes:
            {{- nindent 12 . }}
          {{- end }}
          containers:
            - name: {{ .Chart.Name }}
              image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
              imagePullPolicy: {{ default .Values.image.pullPolicy }}
              env:
                - name: MATOMO_DATABASE_HOST
                  valueFrom:
                    secretKeyRef:
                      name: mariadbcreds
                      key: plainhost
                - name: MATOMO_DATABASE_PASSWORD
                  valueFrom:
                    secretKeyRef:
                      name: mariadbcreds
                      key: mariadb-password
                - name: MATOMO_DATABASE_DBNAME
                  value: "{{ .Values.mariadb.mariadbDatabase }}"
                - name: MATOMO_DATABASE_USERNAME
                  value: "{{ .Values.mariadb.mariadbUsername }}"
                - name: PHP_MEMORY_LIMIT
                  value: "2048"
              command:
              - /bin/bash
              - -c
              - /usr/local/bin/php /var/www/html/console scheduled-tasks:run
              {{- with (include "common.controller.volumeMounts" . | trim) }}
              volumeMounts:
                {{ nindent 16 . }}
              {{- end }}
              securityContext:
                privileged: false
                readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
                allowPrivilegeEscalation: false
                runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
                # capabilities:
                #   drop:
                #     - ALL
              resources:
{{ toYaml .Values.resources | indent 16 }}

{{- end -}}
