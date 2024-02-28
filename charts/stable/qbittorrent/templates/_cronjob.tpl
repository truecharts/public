{{/* Define the cronjob */}}
{{- define "qbittorrent.cronjob" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) }}
enabled: "{{ .Values.qbitportforward.enabled }}"
type: "CronJob"
schedule: "0 8 * * *"
podSpec:
  restartPolicy: Never
  containers:
    qbitportforward:
      primary: true
      enabled: true
      imageSelector: qbitportforwardImage
      probes:
        liveness:
          enabled: false
        readiness:
          enabled: false
        startup:
          enabled: false
      cmd: ./main.sh
      env:
        QBT_USERNAME: "{{ .Values.qbitportforward.QBT_USERNAME }}"
        QBT_PASSWORD: "{{ .Values.qbitportforward.QBT_PASSWORD }}"
        QBT_ADDR: '{{ printf "http://%v:%v" (include "tc.v1.common.lib.chart.names.fullname" $) .Values.service.main.ports.main.port }}'
        GTN_ADDR: '{{ printf "http://%v-gluetun:8000" (include "tc.v1.common.lib.chart.names.fullname" $) }}'



{{- end -}}
