{{/* Define the cronjob */}}
{{- define "clamav.cronjob" -}}
enabled: true
type: "CronJob"
schedule: "0 8 * * *"
podSpec:
  restartPolicy: Never
  containers:
    cron:
      enabled: true
      primary: true
      imageSelector: "image"
      env:
        date_format: {{ .Values.clamav.date_format }}
        log_file_name: {{ .Values.clamav.log_file_name }}
        report_path: {{ .Values.clamav.report_path | trimSuffix "/" }}
        extra_args: {{ .Values.clamav.extra_args }}
      command: ["sh", "-c"]
      probes:
        liveness:
          enabled: false
        readiness:
          enabled: false
        startup:
          enabled: false
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
{{- end -}}
