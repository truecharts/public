{{/* Define the configmap */}}
{{- define "nextcloud.configmap" -}}

{{- $hosts := "" }}
{{- if .Values.ingress.main.enabled }}
{{- range .Values.ingress }}
{{- range $index, $host := .hosts }}
    {{- if $index }}
    {{ $hosts = ( printf "%v %v" $hosts $host.host ) }}
    {{- else }}
    {{ $hosts = ( printf "%s" $host.host ) }}
    {{- end }}
{{- end }}
{{- end }}
{{- end }}


---
apiVersion: v1
kind: ConfigMap
metadata:
  name: nextcloudconfig
data:
  ACCESS_URL: {{ if .Values.ingress.main.enabled }}{{ with (first .Values.ingress.main.hosts) }}https://{{ .host }}{{ end }}{{ else }}http://{{ .Values.env.AccessIP }}{{ end }}
  NEXTCLOUD_TRUSTED_DOMAINS: {{ ( printf "%v %v %v %v %v" "test.fakedomain.dns" ( .Values.env.ACCESS_HOST | default "localhost" ) ( printf "%v-%v" .Release.Name "nextcloud" ) ( printf "%v-%v" .Release.Name "nextcloud-hpb" ) $hosts ) | quote }}
  {{- if .Values.ingress.main.enabled }}
  APACHE_DISABLE_REWRITE_IP: "1"
  {{- end }}

{{- end -}}
