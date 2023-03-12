{{/* Define the web container */}}
{{- define "immich.web" -}}
  {{- if hasKey .Values "imageWeb" -}} {{/* For smooth upgrade, Remove later */}}
    {{- $img := .Values.imageWeb -}}
    {{- $_ := set .Values "webImage" (dict "repository" $img.repository "tag" $img.tag "pullPolicy" $img.pullPolicy) -}}
  {{- end }}
enabled: true
imageSelector: webImage
imagePullPolicy: {{ .Values.webImage.pullPolicy }}
command:
  - /bin/sh
  - ./entrypoint.sh
envFrom:
  - configMapRef:
      name: 'common-config'
probes:
  readiness:

    path: /
    port: 3000




  liveness:

    path: /
    port: 3000




  startup:

    path: /
    port: 3000




{{- end -}}
