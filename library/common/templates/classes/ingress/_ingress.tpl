{{/*
This template serves as a blueprint for all Ingress objects that are created
within the common library.
*/}}
{{- define "common.classes.ingress" -}}
{{- $ingressName := include "common.names.fullname" . -}}
{{- $values := .Values -}}
{{- $svcPort := 80 }}
{{- $ingressService := $.Values }}
{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.ingress -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}

{{- if hasKey $values "nameSuffix" -}}
  {{- $ingressName = printf "%v-%v" $ingressName $values.nameSuffix -}}
  {{- if and ( $.Values.services ) ( not $values.servicePort ) }}
    {{- $ingressService := index  $.Values.services $values.nameSuffix }}
    {{- $svcPort = $ingressService.port.port }}
  {{ end -}}
{{- else if and ( $.Values.services ) ( not $values.servicePort ) }}
  {{- $svcPort = $.Values.services.main.port.port }}
{{ end -}}

{{- $svcName := $values.serviceName | default $ingressName -}}

{{- if $values.servicePort }}
  {{- $svcPort = $values.servicePort -}}
{{- end }}

apiVersion: {{ include "common.capabilities.ingress.apiVersion" . }}
kind: Ingress
metadata:
  name: {{ $ingressName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
  annotations:
    traefik.ingress.kubernetes.io/router.entrypoints: {{ $values.entrypoint }}
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
  {{- if or ( eq $values.certType "selfsigned") (eq $values.certType "ixcert") ( $values.tls ) }}
  tls:
    {{- if $values.tls }}
    {{- range $values.tls }}
    - hosts:
	    {{- if and ( not .hosts ) ( not .hostsTpl ) }}
        {{- range $values.hosts }}
        - {{ .host | quote }}
        {{- end }}
		{{- end }}
        {{- range .hosts }}
        - {{ . | quote }}
        {{- end }}
        {{- range .hostsTpl }}
        - {{ tpl . $ | quote }}
        {{- end }}
      {{- if .secretNameTpl }}
      secretName: {{ tpl .secretNameTpl $ | quote}}
	  {{- else if eq $values.certType "ixcert" }}
	  secretName: {{ $ingressName }}
      {{- else if .secretName }}
      secretName: {{ .secretName }}
      {{- end }}
    {{- end }}
	{{- else }}
    - hosts:
        {{- range $values.hosts }}
        - {{ .host | quote }}
        {{- end }}
	  {{- if eq $values.certType "ixcert" }}
	  secretName: {{ $ingressName }}
      {{- end }}
	{{- end }}
  {{- end }}
  rules:
  {{- range $values.hosts }}
  {{- if .hostTpl }}
    - host: {{ tpl .hostTpl $ | quote }}
  {{- else }}
    - host: {{ .host | quote }}
  {{- end }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
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
{{- end }}
