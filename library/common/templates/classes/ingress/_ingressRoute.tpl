{{/*
This template serves as a blueprint for all ingressRoute objects that are created
within the common library.
*/}}
{{- define "common.classes.ingressRoute" -}}
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

apiVersion: traefik.containo.us/v1alpha1
{{- if eq $values.type "UDP" }}
kind: IngressRouteUDP
{{- else if eq $values.type "TCP" }}
kind: IngressRouteTCP
{{- else }}
kind: IngressRoute
{{- end }}
metadata:
  name: {{ $ingressName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
  annotations:
    {{- with $values.annotations }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  entryPoints:
    - {{ $values.entrypoint }}
  routes:
  {{- if eq $values.type "UDP" }}
  - services:
    - name: {{ $svcName }}
      port: {{ $svcPort }}
      weight: 10
  {{- else if eq $values.type "TCP" }}
  - match: HostSNI(`*`)
    services:
    - name: {{ $svcName }}
      port: {{ $svcPort }}
      weight: 10
      terminationDelay: 400
  {{- else }}
  - kind: Rule
    match: Host(`{{ (index  $values.hosts 0).host }}`)
    services:
      - name: {{ $svcName }}
        {{- if $values.serviceKind }}
        kind: {{ $values.serviceKind }}
        {{- else }}
        port: {{ $svcPort }}
        {{- end }}
    middlewares:
      - name: traefik-middlewares-chain-public@kubernetescrd
      {{- if $values.authForwardURL }}
      - name: "{{ $ingressName }}-auth-forward"
      {{- end }}
  {{- end }}

{{- if not ( eq $values.type "UDP" ) }}
{{- if or ( eq $values.certType "selfsigned") (eq $values.certType "ixcert") }}
  tls:
    domains:
      - main: {{ (index  $values.hosts 0).host }}
        sans:
            {{- range $values.hosts }}
            - {{ .host | quote }}
            {{- end }}

	{{- if $values.tls }}
	{{- range $values.tls }}

	{{- if .hosts }}
      - main: {{ index  .hosts 0 }}
    {{- range .hosts }}
        sans:
            {{- range .hosts }}
            - {{ . | quote }}
            {{- end }}
	{{- end }}
	{{- end }}

	{{- if .hosts }}
      - main: {{ index  .hostsTpl 0 }}
    {{- range .hosts }}
        sans:
            {{- range .hostsTpl }}
            - {{ tpl . $ | quote }}
            {{- end }}
	{{- end }}
	{{- end }}

	{{- end }}
	{{- end }}

	{{- if eq $values.certType "ixcert" }}
	secretName: {{ $ingressName }}
    {{- end }}
    passthrough: false

{{- end }}
{{- end }}

{{- end }}
