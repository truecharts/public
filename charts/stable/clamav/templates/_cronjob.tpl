{{/* Define the cronjob */}}
{{- define "clamav.cronjob" -}}
{{- $jobName := include "tc.common.names.fullname" . }}

---
apiVersion: batch/v1
kind: CronJob
metadata:
  name: {{ printf "%s-cronjob" $jobName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
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
          {{- with (include "tc.common.controller.volumes" . | trim) }}
          volumes:
            {{- nindent 12 . }}
          {{- end }}
          containers:
            - name: {{ .Chart.Name }}
              image: "{{ .Values.image.repository }}:{{ .Values.image.tag }}"
              env:
                - name: date_format
                  value: {{ .Values.clamav.date_format }}
                - name: log_file_name
                  value: {{ .Values.clamav.log_file_name }}
                - name: report_path
                  value: {{ .Values.clamav.report_path | trimSuffix "/" }}
                - name: extra_args
                  value: {{ .Values.clamav.extra_args }}
              command: ["sh", "-c"]
              args:
                - >
                  export databasePath=/var/lib/clamav;
                  if [ "$(ls -A $databasePath)" ];
                    then
                      echo "Virus database exists...";
                  else
                      echo "Virus database does not exist yet...";
                      echo "Exiting...";
                      exit 1;
                  fi;
                  export status=99;
                  export now=$(date ${date_format});
                  export log_file=$report_path/${log_file_name}_${now};
                  touch $log_file;
                  echo "Starting scan of \"/scandir\"";
                  echo "Args for clamscan: --database=${databasePath} --log=$log_file --recursive ${extra_args}";
                  clamscan --database=${databasePath} --log=$log_file --recursive ${extra_args} /scandir;
                  status=$?;
                  if [ $status -eq 0 ];
                    then
                      echo "Exit Status: $status";
                      echo "No Virus found!";
                  elif [ $status -eq 1 ];
                    then
                      echo "Exit Status: $status.";
                      echo "Virus(es) found. Check \"${log_file}\".";
                  elif [ $status -eq 2 ];
                    then
                      echo "Exit Status: $status.";
                      echo "Some error(s) occured.";
                  else
                    echo "Exit Status: $status.";
                  fi;
              {{- with (include "tc.common.controller.volumeMounts" . | trim) }}
              volumeMounts:
                {{ nindent 16 . }}
              {{- end }}
              resources:
{{ toYaml .Values.resources | indent 16 }}
{{- end -}}
