{{/* Define the crowdsec agent container */}}
{{- define "crowdsec.agent" -}}
image: {{ .Values.crowdsecAgentImage.repository }}:{{ .Values.crowdsecAgentImage.tag }}
imagePullPolicy: '{{ .Values.crowdsecAgentImage.pullPolicy }}'
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: true
  runAsNonRoot: true
ports:
  - containerPort: 8080
  - containerPort: 6060
envFrom:
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-crowdsec-env'
volumeMounts:
  - name: crowdsec_config
    mountPath: "/etc/crowdsec"
  - name: crowdsec_data
    mountPath: "/var/lib/crowdsec/data"
  - name: logs
    mountPath: "/var/log/traefik"
    readOnly: true
  - name: crowdsec-acquis
    mountPath: "/etc/crowdsec/acquis.yaml"
    readOnly: true
    subPath: acquis.yaml
{{- end -}}
