{{- define "common.resources.portal" -}}

{{- if .Values.portal }}
{{- if .Values.portal.enabled }}
{{- $host := "$node_ip" }}
{{- $port := 443 }}
{{- $protocol := "https" }}

{{- if hasKey .Values "ingress" }}
  {{- if hasKey .Values.ingress "main" -}}
    {{- range .Values.ingress.main.hosts }}
      {{- if .hostTpl }}
         {{- $host = ( tpl .hostTpl $ | quote ) }}
      {{- else }}
        {{- $host = ( .host | quote ) }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}

{{- if and ( .Values.portal.ingressPort ) ( ne $host "$node_ip" ) }}
  {{- $port = .Values.portal.ingressPort }}
{{- else  if and ( eq $host "$node_ip" ) ( hasKey .Values "services" ) }}
  {{- if hasKey .Values.services "main" }}
    {{- if and (hasKey .Values.services.main.port "nodePort" ) ( eq .Values.services.main.type "NodePort" ) }}
      {{- $port = .Values.services.main.port.nodePort }}
    {{- end }}
  {{- end }}
{{- end }}

{{- if and (.Values.portal.nodePortProtocol ) ( eq $host "$node_ip" ) }}
  {{- $protocol = .Values.portal.nodePortProtocol }}
{{- else if and ( ne $host "$node_ip" ) }}
  {{- if .Values.ingress.main.certType }}
    {{- if eq .Values.ingress.main.certType "" }}
      {{- $protocol = "http" }}
    {{- end }}
  {{- end }}
{{- end }}

{{- if and ( .Values.portal.host ) ( eq $host "$node_ip" ) }}
  {{- $host = .Values.portal.host }}
{{- end }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: portal
  labels: {{ include "common.labels" . | nindent 4 }}
data:
  protocol: {{ $protocol }}
  host: {{ $host }}
  port: {{ $port | quote }}

{{- end }}
{{- end }}
{{- end -}}
