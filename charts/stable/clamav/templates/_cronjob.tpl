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
                  echo "Reloading virus database...";
                  clamdscan --reload;
                  echo $?;
                  echo "Starting scan of \"/scandir\"";
                  now=$(date +"%m-%d-%Y")
                  clamdscan /scandir --log=/scandir/clamdscan_report_${now};
                  export status = $?;
                  if [ $status -eq 0 ];
                    then
                      echo "Exit Status: $status No Virus found!";
                  else
                    echo "Exit Status: $status. Check scan \"clamdscan_report_${now}\".";
                  fi;

              resources:
{{ toYaml .Values.resources | indent 16 }}
{{- end -}}
