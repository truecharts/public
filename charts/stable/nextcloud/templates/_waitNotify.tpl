{{- define "nextcloud.wait.notify" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}
enabled: true
type: init
imageSelector: nginxImage
command: /bin/sh
args:
  - -c
  - |
    echo "Waiting for notify container to be ready ..."
    until curl --silent --output /dev/null http://{{ printf "%v-notify" $fullname }}:{{ .Values.service.notify.ports.notify.targetPort }}/push/test/cookie; do
      echo "Waiting for notify container to be ready ..."
      sleep 5
    done
    echo "Done"
{{- end -}}
