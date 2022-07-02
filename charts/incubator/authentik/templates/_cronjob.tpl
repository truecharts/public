{{/* Define the cronjob */}}
{{- define "authentik.cronjob" -}}
{{- $jobName := include "tc.common.names.fullname" . }}

---
apiVersion: batch/v1
kind: CronJob
metadata:
  name: {{ printf "%s-cronjob" $jobName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
spec:
  schedule: "0 */{{ .Values.geoip.freqhours }} * * *"
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
              image: "{{ .Values.geoipImage.repository }}:{{ .Values.geoipImage.tag }}"
              env:
                - name: GEOIPUPDATE_FREQUENCY
                  value: "{{ .Values.geoip.GEOIPUPDATE_FREQUENCY }}"
                - name: GEOIPUPDATE_PRESERVE_FILE_TIMES
                  value: "{{ .Values.geoip.GEOIPUPDATE_PRESERVE_FILE_TIMES }}"
                - name: GEOIPUPDATE_ACCOUNT_ID
                  value: {{ .Values.geoip.GEOIPUPDATE_ACCOUNT_ID }}
                - name: GEOIPUPDATE_LICENSE_KEY
                  value: {{ .Values.geoip.GEOIPUPDATE_LICENSE_KEY }}
                - name: GEOIPUPDATE_EDITION_IDS
                  value: {{ .Values.geoip.GEOIPUPDATE_EDITION_IDS }}
                - name: GEOIPUPDATE_HOST
                  value: {{ .Values.geoip.GEOIPUPDATE_HOST }}
              volumeMounts:
              - name: geoip
                mountPath: "/usr/share/GeoIP"
              resources:
{{ toYaml .Values.resources | indent 16 }}
{{- end -}}
