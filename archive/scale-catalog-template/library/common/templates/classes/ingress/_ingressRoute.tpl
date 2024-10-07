{{/*
This template serves as a blueprint for all ingressRoute objects that are created
within the common library.
*/}}
{{- define "common.classes.ingressRoute" -}}
{{- $ingressName := include "common.names.fullname" . -}}
{{- $values := .Values -}}
{{- $svcPort := 80 }}
{{- $portProtocol := "" }}
{{- $ingressService := $.Values }}
{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.ingress -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}

{{- if hasKey $values "nameSuffix" -}}
  {{- $ingressName = printf "%v-%v" $ingressName $values.nameSuffix -}}
  {{- if and ( $.Values.services ) ( not $values.servicePort ) }}
    {{- $ingressService := index  $.Values.services ( $values.nameSuffix | quote) }}
    {{- $svcPort = $ingressService.port.port }}
    {{- $portProtocol = $ingressService.port.protocol | default "" }}
  {{ end -}}
{{- else if and ( $.Values.services ) ( not $values.servicePort ) }}
  {{- $svcPort = $.Values.services.main.port.port }}
  {{- $portProtocol = $.Values.services.main.port.protocol  | default "" }}
{{ end -}}

{{- $authForwardName := ( printf "%v-%v" $ingressName "auth-forward" ) -}}

{{- $svcName := $values.serviceName | default $ingressName -}}

{{- if $values.servicePort }}
  {{- $svcPort = $values.servicePort }}
{{- end }}

{{- if $values.serviceType }}
    {{- $portProtocol = $values.serviceType }}
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
    match: Host(`{{ (index  $values.hosts 0).host }}`) && PathPrefix(`{{ (index  $values.hosts 0).path | default "/" }}`)
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
      - name: "{{ printf "%v-%v@%v" .Release.Namespace $authForwardName "kubernetescrd" }}"
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
    {{- if eq $values.certType "ixcert" }}
    secretName: {{ $ingressName }}
    {{- end }}
    passthrough: false

{{- end }}
{{- end }}

{{- if $values.authForwardURL }}
---

apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: {{ $authForwardName }}
spec:
  forwardAuth:
    address: {{ $values.authForwardURL | quote }}
    tls:
      insecureSkipVerify: true
    trustForwardHeader: true
    authResponseHeaders:
      - Remote-User
      - Remote-Groups
      - Remote-Name
      - Remote-Email

{{- end }}
{{- end }}
