{{- define "common.classes.portal" -}}

{{- if .Values.portal }}
{{- if .Values.portal.enabled }}
{{- $svc := index .Values.services (keys .Values.services | first) -}}
{{- $host := "$node_ip" }}
{{- $port := 443 }}
{{- $protocol := "https" }}
{{- $portProtocol := "" }}
{{- $path := "/" }}

{{- if hasKey .Values "ingress" }}
  {{- if .Values.ingress.enabled }}
    {{- range .Values.ingress.hosts }}
      {{- if .hostTpl }}
        {{ $host = ( tpl .hostTpl $ ) }}
      {{- else if .host }}
        {{ $host = .host }}
      {{- else }}
        {{ $host = "$node_ip" }}
      {{- end }}
      {{- if .paths }}
        {{- $path = (first .paths).path  }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}

{{- if and ( .Values.portal.ingressPort ) ( ne $host "$node_ip" ) }}
  {{- $port = .Values.portal.ingressPort }}
{{- else  if eq $host "$node_ip" }}
  {{- if eq $svc.type "NodePort" }}
    {{- $port = $svc.port.nodePort }}
    {{- if or ( eq $svc.port.protocol "HTTP" ) ( eq $svc.port.protocol "HTTPS" ) }}
      {{- $portProtocol = $svc.port.protocol }}
    {{- end }}
  {{- end }}
{{- end }}

{{- if and ( $portProtocol ) ( eq $host "$node_ip" ) }}
  {{- $protocol = $portProtocol }}
{{- else if and ( ne $host "$node_ip" ) }}
  {{- if $.Values.ingress.tls }}
    {{- $protocol = "https" }}
  {{- end }}
{{- end }}

{{- if and ( .Values.portal.host ) ( eq $host "$node_ip" ) }}
  {{- $host = .Values.portal.host }}
{{- end }}

{{- if and ( .Values.portal.path ) }}
  {{- $path = .Values.portal.path }}
{{- end }}

{{- print "---" | nindent 0 -}}

apiVersion: v1
kind: ConfigMap
metadata:
  name: portal
  labels: {{ include "common.labels" . | nindent 4 }}
data:
  protocol: {{ $protocol }}
  host: {{ $host | quote }}
  port: {{ $port | quote }}
  path: {{ $path | quote }}
  url: {{ ( printf "%v://%v:%v%v" $protocol $host $port $path ) | quote }}
{{- end }}
{{- end }}
{{- end -}}
