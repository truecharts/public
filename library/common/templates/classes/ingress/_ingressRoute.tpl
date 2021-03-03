{{/*
This template serves as a blueprint for all ingressRoute objects that are created
within the common library.
*/}}
{{- define "common.classes.ingressRoute" -}}
{{- $ingressName := include "common.names.fullname" . -}}
{{- $values := .Values.ingress -}}
{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.ingress -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}
{{- if hasKey $values "nameSuffix" -}}
  {{- $ingressName = printf "%v-%v" $ingressName $values.nameSuffix -}}
{{ end -}}
{{- $svcName := $values.serviceName | default (include "common.names.fullname" .) -}}
{{- $svcPort := $values.servicePort | default $.Values.services.main.port.port -}}
apiVersion: traefik.containo.us/v1alpha1
{{- if eq $values.type "UDP" }}
kind: IngressRouteUDP
{{- else }}
kind: IngressRouteTCP
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
  {{- else }}
  - match: HostSNI(`*`)
    services:
    - name: {{ $svcName }}
      port: {{ $svcPort }}
      weight: 10
      terminationDelay: 400
  {{- end }}

{{- if eq $values.type "TCP" }}
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
