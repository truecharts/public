{{- define "tc.common.scale.portal" -}}
{{- if .Values.ixChartContext }}
{{- if .Values.portal }}
{{- if .Values.portal.enabled }}
{{- $primaryService := get .Values.service (include "tc.common.lib.util.service.primary" .) }}
{{- $primaryPort := get $primaryService.ports (include "tc.common.lib.util.service.ports.primary" (dict "values" $primaryService)) -}}
{{- $ingr := index .Values.ingress (keys .Values.ingress | first) -}}
{{- $host := "$node_ip" }}
{{- $port := 443 }}
{{- $protocol := "https" }}
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

{{- $namespace := "default" }}
{{- if $ingr.ingressClassName }}
{{- $namespace := ( printf "ix-%s" $ingr.ingressClassName ) }}
{{- end }}
{{- $traefikportalhook := lookup "v1" "ConfigMap" $namespace "portalhook" }}

{{- $entrypoint := "websecure" }}
{{- if $ingr.entrypoint }}
  {{- $entrypoint = $ingr.entrypoint }}
{{- end }}

{{- if .Values.portal.ingressPort  }}
  {{- $ingressport = .Values.portal.ingressPort }}
{{- else if $traefikportalhook }}
  {{- if ( index $traefikportalhook.data $entrypoint ) }}
    {{- $ingressport = ( index $traefikportalhook.data $entrypoint ) }}
  {{- end }}
{{- end }}

{{- if eq $host "$node_ip" }}
  {{- if eq $primaryService.type "NodePort" }}
    {{- $port = $primaryPort.nodePort }}
  {{- end }}
  {{- if eq $primaryService.type "LoadBalancer" }}
    {{- $port = $primaryPort.port }}
  {{- end }}
    {{- if eq $primaryPort.protocol "HTTP" }}
      {{- $protocol = "http" }}
    {{- end }}
{{- else }}
  {{- $port = $ingressport }}
  {{- if $ingr.tls }}
    {{- $protocol = "https" }}
  {{- end }}
{{- end }}


{{- if and ( .Values.portal.host ) ( eq $host "$node_ip" ) }}
  {{- $host = ( tpl .Values.portal.host $ ) }}
{{- end }}

{{- if .Values.portal.path }}
  {{- $path = ( tpl .Values.portal.path $ ) }}
{{- end }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: portal
  labels:
  {{ include "tc.common.labels" . | nindent 4 }}
data:
  protocol: {{ $protocol }}
  host: {{ $host | quote }}
  port: {{ $port | quote }}
  path: {{ $path | quote }}
  url: {{ ( printf "%v://%v:%v%v" $protocol $host $port $path ) | quote }}
{{- end }}
{{- end }}
{{- end }}
{{- end -}}
