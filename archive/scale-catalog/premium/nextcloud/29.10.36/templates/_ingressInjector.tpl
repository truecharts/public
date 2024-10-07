{{- define "nextcloud.ingressInjector" -}}
  {{- if .Values.ingress.main.enabled -}}
    {{- $injectPaths := list -}}
    {{- if .Values.nextcloud.collabora.enabled -}}
      {{- $injectPaths = mustAppend $injectPaths (include "nextcloud.collabora.ingress" $ | fromYaml) -}}
    {{- end -}}
    {{/* Append more paths here if needed */}}

    {{- range $host := .Values.ingress.main.hosts -}}
      {{- $paths := $host.paths -}}
      {{- $paths = concat $paths $injectPaths -}}
      {{- $_ := set $host "paths" $paths -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "nextcloud.collabora.ingress" -}}
path: /collabora/
pathType: Prefix
overrideService:
  name: collabora
  port: {{ .Values.service.collabora.ports.collabora.port }}
{{- end -}}
