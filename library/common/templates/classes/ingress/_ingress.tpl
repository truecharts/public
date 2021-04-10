{{/*
This template serves as a blueprint for all Ingress objects that are created
within the common library.
*/}}
{{- define "common.classes.ingress" -}}
{{- $ingressName := include "common.names.fullname" . -}}
{{- $values := .Values -}}
{{- $svcPort := 80 -}}
{{- $portProtocol := "" -}}
{{- $ingressService := $.Values -}}
{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.ingress -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}

{{- if hasKey $values "nameSuffix" -}}
  {{- $ingressName = printf "%v-%v" $ingressName $values.nameSuffix -}}
  {{- if and ( $.Values.services ) ( not $values.servicePort ) }}
    {{- $ingressService := index  $.Values.services ( $values.nameSuffix | quote ) }}
    {{- $svcPort = $ingressService.port.port -}}
    {{- $portProtocol = $ingressService.port.protocol | default "" }}
  {{ end -}}
{{- else if and ( $.Values.services ) ( not $values.servicePort ) }}
  {{- $svcPort = $.Values.services.main.port.port -}}
  {{- $portProtocol = $.Values.services.main.port.protocol | default "" -}}
{{ end -}}

{{- $svcName := $values.serviceName | default $ingressName -}}

{{- if $values.dynamicServiceName }}
  {{- $dynamicServiceName := printf "%v-%v" .Release.Name $values.dynamicServiceName -}}
  {{- $svcName = $dynamicServiceName -}}
{{- end }}

{{- if $values.servicePort }}
  {{- $svcPort = $values.servicePort -}}
{{- end }}

{{- if $values.serviceType }}
  {{- $portProtocol = $values.serviceType -}}
{{- end }}

apiVersion: {{ include "common.capabilities.ingress.apiVersion" . }}
kind: Ingress
metadata:
  name: {{ $ingressName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
  annotations:
    {{- if eq $portProtocol "HTTPS" }}
    traefik.ingress.kubernetes.io/service.serversscheme: https
    {{- end }}
    traefik.ingress.kubernetes.io/router.entrypoints: {{ $values.entrypoint | default "websecure" }}
    traefik.ingress.kubernetes.io/router.middlewares: traefik-middlewares-chain-public@kubernetescrd{{ if $values.authForwardURL }},{{ $ingressName }}-auth-forward{{ end }}
    {{- with $values.annotations }}
      {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  {{- if eq (include "common.capabilities.ingress.apiVersion" $) "networking.k8s.io/v1" }}
  {{- if $values.ingressClassName }}
  ingressClassName: {{ $values.ingressClassName }}
  {{- end }}
  {{- end }}
  {{- if or ( eq $values.certType "selfsigned") (eq $values.certType "ixcert") }}
  tls:
    - hosts:
        {{- if $values.host}}
        - {{ $values.host | quote }}
        {{- else }}
        {{- range $values.hosts }}
        - {{ .host | quote }}
        {{- end }}
        {{- end }}
      {{- if eq $values.certType "ixcert" }}
      secretName: {{ $ingressName }}
      {{- end }}
  {{- end }}
  rules:
  {{- if $values.host }}
    - host: {{ $values.host | quote }}
      http:
        paths:
          - path: {{ $values.path | default "/" }}
            {{- if eq (include "common.capabilities.ingress.apiVersion" $) "networking.k8s.io/v1" }}
            pathType: Prefix
            {{- end }}
            backend:
            {{- if eq (include "common.capabilities.ingress.apiVersion" $) "networking.k8s.io/v1" }}
              service:
                name: {{ $svcName }}
                port:
                  number: {{ $svcPort }}
            {{- else }}
              serviceName: {{ $svcName }}
              servicePort: {{ $svcPort }}
            {{- end }}
  {{- end }}
  {{- range $values.hosts }}
    - host: {{ .host | quote }}
      http:
        paths:
          - path: {{ .path | default "/" }}
            {{- if eq (include "common.capabilities.ingress.apiVersion" $) "networking.k8s.io/v1" }}
            pathType: Prefix
            {{- end }}
            backend:
            {{- if eq (include "common.capabilities.ingress.apiVersion" $) "networking.k8s.io/v1" }}
              service:
                name: {{ $svcName }}
                port:
                  number: {{ $svcPort }}
            {{- else }}
              serviceName: {{ $svcName }}
              servicePort: {{ $svcPort }}
            {{- end }}
  {{- end }}
{{- end }}
