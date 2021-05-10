{{/*
This template serves as a blueprint for all Ingress objects that are created
within the common library.
*/}}
{{- define "common.classes.ingressRoute" -}}
{{- $ingressName := include "common.names.fullname" . -}}
{{- $values := index .Values.ingress (keys .Values.ingressRoute | first) -}}

{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.ingress -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}

{{- if hasKey $values "nameSuffix" -}}
  {{- $ingressName = printf "%v-%v" $ingressName $values.nameSuffix -}}
{{ end -}}

{{- $svc := index .Values.services (keys .Values.services | first) -}}
{{- $svcName := $values.serviceName | default (include "common.names.fullname" .) -}}
{{- $svcPort := $values.servicePort | default $svc.port.port -}}
{{- $svcProtocol := $values.serviceProtocol | default $svc.port.protocol -}}

apiVersion: traefik.containo.us/v1alpha1
kind: ingressRoute
metadata:
  name: {{ $ingressName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
  {{- with $values.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  entrypoints:
  {{- range $values.entrypoints }}
    - {{ . | quote }}
  {{- end}}
  {{- range .entrypointsTpl }}
    - {{ tpl . $ | quote }}
  {{- end}}

  routes:
  {{- range $values.routes }}
    - kind: Rule
      match: {{ if .host }}Host(`{{ .host }}`){{ else if .hostTpl}}Host(`{{ tpl .hostTpl $ | quote }}`){{ else }}{{ .match }}{{- end }}
      priority: {{ .priority | default 0 }}
      middlewares:
        {{- range .middlewares }}
        - name: {{ .name }}
          namespace: {{ .namespace | default .Release.Namespace }}
        {{- end}}
      services:
        {{- range .services }}
        - kind: Service
          name: {{ .name | default $svcName }}
          port: {{ .port | default $svcPort }}
          passHostHeader: {{ .passHostHeader | default false }}
          scheme: {{ .scheme | default $svcProtocol }}
          weight: {{ .weight | default 10 }}
          terminationDelay: {{ .terminationDelay | default 100 }}
          strategy: {{ .strategy | default "RoundRobin" }}
        {{- end}}
  {{- end}}

  {{- if $values.tls }}
  tls:
    {{- if or $values.tls.secretNameTpl $values.tls.secretName $values.tls.scaleCert }}
    {{- if $values.tls.scaleCert }}
    secretName: {{ ( printf "%v-%v-%v" $ingressName "ixcert" $values.tls.scaleCert ) }}
    {{- else if $values.tls.secretNameTpl }}
    secretName: {{ tpl $values.tls.secretNameTpl $ | quote}}
    {{- else }}
    secretName: {{ $values.tls.secretName }}
    {{- end }}
    {{- end }}
    domains:
      {{- range $values.tls.domains }}
      - main: {{ if .main }}{{ .main }}{{ else if .mainTpl }}{{ tpl .mainTpl $ | quote }}{{ end }}
        sans:
          {{- range .sans }}
          - {{ . | quote }}
          {{- end }}
          {{- range .sansTpl }}
          - {{ tpl . $ | quote }}
          {{- end }}
        passthrough: {{ .passthrough | default false }}
      {{- end }}
  {{- end }}

{{- end }}
