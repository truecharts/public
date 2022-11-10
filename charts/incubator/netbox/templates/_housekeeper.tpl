{{/* Define the housekeeper container */}}
{{- define "netbox.housekeeper" -}}
image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
imagePullPolicy: {{ .Values.image.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
command:
  - /bin/bash
  - -c
  - |
    echo "Starting housekeeper..."
    until $(curl --output /dev/null --silent --head --fail http://127.0.0.1:8080/login); do
      echo "Waiting for the main netbox container..."
      sleep 5
    done
    /opt/netbox/housekeeping.sh
    echo "Housekeeper finished, exiting..."
volumeMounts:
  - name: config
    mountPath: /etc/netbox/config
  - name: reports
    mountPath: /etc/netbox/reports
  - name: scripts
    mountPath: /etc/netbox/scritps
  - name: media
    mountPath: /opt/netbox/netbox/media
  - name: configfile
    mountPath: /etc/netbox/config/01-config.py
    subPath: config.py
{{- end -}}
