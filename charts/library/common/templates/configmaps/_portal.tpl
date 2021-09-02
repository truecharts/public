{{- define "common.configmap.portal" -}}

{{- if .Values.portal }}
{{- if .Values.portal.enabled }}
{{- $primaryService := get .Values.service (include "common.service.primary" .) }}
{{- $primaryPort := get $primaryService.ports (include "common.classes.service.ports.primary" (dict "values" $primaryService)) -}}
{{- $ingr := index .Values.ingress (keys .Values.ingress | first) -}}
{{- $host := "$node_ip" }}
{{- $port := 443 }}
{{- $protocol := "https" }}
{{- $portProtocol := "" }}
{{- $path := "/" }}
{{- $ingressport := 443 }}

{{- if $ingr }}
  {{- if $ingr.enabled }}
    {{- range $ingr.hosts }}
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

{{- $traefikportalhook := lookup "v1" "ConfigMap" "traefikmiddlewares" "portalhook" }}
{{- if .Values.portal.ingressPort  }}
  {{- $ingressport = .Values.portal.ingressPort }}
{{- else if $traefikportalhook }}
  {{- if $traefikportalhook.data.websecureport }}
    {{- $ingressport = ( index $traefikportalhook.data "websecureport" ) }}
  {{- end }}
{{- end }}

{{- if ne $host "$node_ip" }}
  {{- $port = $ingressport }}
{{- else  if eq $host "$node_ip" }}
  {{- if eq $primaryService.type "NodePort" }}
    {{- $port = $primaryPort.nodePort }}
    {{- if or ( eq $primaryPort.protocol "HTTP" ) ( eq $primaryPort.protocol "HTTPS" ) }}
      {{- $portProtocol = $primaryPort.protocol }}
    {{- end }}
  {{- end }}
{{- end }}

{{- if and ( $portProtocol ) ( eq $host "$node_ip" ) }}
  {{- $protocol = $portProtocol }}
{{- else if and ( ne $host "$node_ip" ) }}
  {{- if $ingr.tls }}
    {{- $protocol = "https" }}
  {{- end }}
{{- end }}

{{- if and ( .Values.portal.host ) ( eq $host "$node_ip" ) }}
  {{- $host = .Values.portal.host }}
{{- end }}

{{- if and ( .Values.portal.path ) }}
  {{- $path = .Values.portal.path }}
{{- end }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: portal
  labels: {{ include "common.labels" . | nindent 4 }}
  annotations:
    rollme: {{ randAlphaNum 5 | quote }}
data:
  protocol: {{ $protocol }}
  host: {{ $host | quote }}
  port: {{ $port | quote }}
  path: {{ $path | quote }}
  url: {{ ( printf "%v://%v:%v%v" $protocol $host $port $path ) | quote }}
{{- end }}
{{- end }}
{{- end -}}
