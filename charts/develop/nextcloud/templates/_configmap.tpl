{{/* Define the configmap */}}
{{- define "nextcloud.configmap" -}}

{{- $hosts := "" }}
{{- if $values.ingress.enabled }}
{{ range $index, $host := $values.ingress.main.hosts }}
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
