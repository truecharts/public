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
  - /opt/netbox/housekeeping.sh
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
