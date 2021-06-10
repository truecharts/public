{{- if .Values.portal }}
{{- if .Values.portal.enabled }}
{{- $ingr := dict -}}
{{- $host := "$node_ip" }}
{{- $port := 443 }}
{{- $protocol := "https" }}
{{- $portProtocol := "" }}
{{- $path := "/" }}

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

{{- if eq $host "$node_ip" }}
  {{- $port = .Values.ports.traefik.exposedPort }}
{{- end }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: portal
data:
  protocol: {{ $protocol }}
  host: {{ $host | quote }}
  port: {{ $port | quote }}
  path: {{ $path | quote }}
  url: {{ ( printf "%v://%v:%v%v" $protocol $host $port $path ) | quote }}
{{- end }}
{{- end }}
