{{- define "nextcloud.wait.nextcloud" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}
{{- $ncURL := printf "%v-nextcloud:%v" $fullname .Values.service.nextcloud.ports.nextcloud.targetPort }}
enabled: true
type: init
imageSelector: image
securityContext:
resources:
  limits:
    "nvidia.com/gpu": "0"
    "amd.com/gpu": "0"
    "gpu.intel.com/i915": "0"
command: /bin/sh
args:
  - -c
  - |
    echo "Waiting Nextcloud [{{ $ncURL }}] to be ready and installed..."
    until \
          REQUEST_METHOD="GET" \
          SCRIPT_NAME="status.php" \
          SCRIPT_FILENAME="status.php" \
          cgi-fcgi -bind -connect "{{ $ncURL }}" | grep -q '"installed":true';
    do
      echo "Waiting Nextcloud [{{ $ncURL }}] to be ready and installed..."
      sleep 3
    done

    echo "Nextcloud is ready and installed..."
    echo "Starting Nginx..."
{{- end -}}
