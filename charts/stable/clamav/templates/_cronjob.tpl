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
          {{- with (include "common.controller.volumes" . | trim) }}
          volumes:
            {{- nindent 12 . }}
          {{- end }}
          containers:
            - name: {{ .Chart.Name }}
              image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
              env:
                # - name: date_format
                #   value: {{ .Values.clamav.date_format }}
                - name: report_path
                  value: {{ .Values.clamav.report_path | trimSuffix "/" }}
              command: ["sh", "-c"]
              args:
                - >
                  export date_format="%m-%d-%Y"
                  export now=$(date +"%m-%d-%Y");
                  export report_file=$report_path/clamdscan_report_${now};
                  touch $report_file;
                  echo "Starting scan of \"/scandir\"";
                  clamdscan /scandir --log=$report_file;
                  export status=$?;
                  if [ $status -eq 0 ];
                    then
                      echo "Exit Status: $status No Virus found!";
                  else
                    echo "Exit Status: $status. Check scan \"/scandir/clamdscan_report_${now}\".";
                  fi;
                  cat $report_file;
              {{- with (include "common.controller.volumeMounts" . | trim) }}
              volumeMounts:
                {{ nindent 16 . }}
              {{- end }}
              resources:
{{ toYaml .Values.resources | indent 16 }}
{{- end -}}
