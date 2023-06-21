{{/* Define the typesense container */}}
{{- define "immich.typesense" -}}
enabled: true
type: Deployment
podSpec:
  containers:
    typesense:
      enabled: true
      primary: true
      imageSelector: typesenseImage
      securityContext:
        capabilities:
          disableS6Caps: true
      envFrom:
        - secretRef:
            name: typesense-secret
      args:
        - --api-port
        - {{ .Values.service.typesense.ports.typesense.port | quote }}
      probes:
        readiness:
          enabled: true
          type: http
          path: /health
          port: {{ .Values.service.typesense.ports.typesense.port }}
        liveness:
          enabled: true
          type: http
          path: /health
          port: {{ .Values.service.typesense.ports.typesense.port }}
        startup:
          enabled: true
          type: http
          path: /health
          port: {{ .Values.service.typesense.ports.typesense.port }}
{{- end -}}
