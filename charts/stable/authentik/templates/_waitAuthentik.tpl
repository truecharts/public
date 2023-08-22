{{- define "authentik.wait.server" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}
{{- $serverUrl := printf "https://%v:%v/-/health/ready/" $fullname .Values.service.main.ports.main.port }}
enabled: true
type: init
imageSelector: alpineImage
command: /bin/sh
args:
  - -c
  - |
    echo "Waiting Authentik Server [{{ $serverUrl }}] to be ready..."
    until wget --no-check-certificate --spider --quiet "{{ $serverUrl }}";
    do
      echo "Waiting Authentik Server [{{ $serverUrl }}] to be ready..."
      sleep 3
    done

    echo "Authentik [{{ $serverUrl }}] is ready..."
    echo "Starting Outpost..."
{{- end -}}
