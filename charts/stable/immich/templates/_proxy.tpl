{{/* Define the proxy container */}}
{{- define "immich.proxy" -}}
  {{- if hasKey .Values "imageProxy" -}} {{/* For smooth upgrade, Remove later */}}
    {{- $img := .Values.imageProxy -}}
    {{- $_ := set .Values "proxyImage" (dict "repository" $img.repository "tag" $img.tag "pullPolicy" $img.pullPolicy) -}}
  {{- end -}}
  {{- if not .Values.service.main.ports.main.targetPort -}} {{/* For smooth upgrade, Remove later */}}
    {{- $_ := set .Values.service.main.ports.main "targetPort" 8080 -}}
  {{- end }}
enabled: true
imageSelector: proxyImage
imagePullPolicy: {{ .Values.proxyImage.pullPolicy }}
envFrom:
  - configMapRef:
      name: 'common-config'
probes:
  readiness:

    path: /api/server-info/ping
      port: {{ .Values.service.main.ports.main.targetPort }}




  liveness:

    path: /api/server-info/ping
      port: {{ .Values.service.main.ports.main.targetPort }}




  startup:

    path: /api/server-info/ping
      port: {{ .Values.service.main.ports.main.targetPort }}




{{- end -}}
