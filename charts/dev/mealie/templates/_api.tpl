{{- define "mealie.api" -}}
enabled: true
imageSelector: apiImage
imagePullPolicy: {{ .Values.apiImage.pullPolicy }}
envFrom:
  - secretRef:
      name: 'api-secret'
  - configMapRef:
      name: 'api-config'
probes:
  readiness:

    path: /docs
      port: {{ .Values.service.api.ports.api.port }}




  liveness:

    path: /docs
      port: {{ .Values.service.api.ports.api.port }}




  startup:

    path: /docs
      port: {{ .Values.service.api.ports.api.port }}




{{- end -}}
