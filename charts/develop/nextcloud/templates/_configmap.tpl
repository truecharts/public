{{/* Define the configmap */}}
{{- define "nextcloud.configmap" -}}

{{- $hosts := "" }}
{{- if .Values.ingress.main.enabled }}
{{ range $index, $host := .Values.ingress.main.hosts }}
    {{- if $index }}
    {{ $hosts = ( printf "%v %v" $hosts $host ) }}
    {{- else }}
    {{ $hosts = ( printf "%s" $host ) }}
    {{- end }}
{{ end }}
{{- end }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: nextcloudconfig
data:
  NEXTCLOUD_TRUSTED_DOMAINS: {{ $hosts | quote }}

{{- end -}}
