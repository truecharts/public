{{/* Define the worker container */}}
{{- define "authentik.worker" -}}
enabled: true
imageSelector: image.repository }}:{{ .Values.image.tag }}
imagePullPolicy: {{ .Values.image.pullPolicy }}
args: ["worker"]
envFrom:
  - secretRef:
      name: 'authentik-secret'
  - configMapRef:
      name: 'authentik-config'
probes:
  readiness:
    exec:
      command:
        - /lifecycle/ak
        - healthcheck




  liveness:
    exec:
      command:
        - /lifecycle/ak
        - healthcheck




  startup:
    exec:
      command:
        - /lifecycle/ak
        - healthcheck

{{- end -}}
