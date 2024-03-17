{{/* Define the portalHook */}}
{{- define "traefik.portalhook" -}}
{{- if .Values.portalhook.enabled -}}
  {{- $name := "portalhook" -}}
  {{- if $.Values.ingressClass.enabled -}}
    {{- $name = printf "portalhook-%v" .Release.Name -}}
  {{- end }}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $name }}
data:
  {{- $ports := dict }}
  {{- range $.Values.service }}
  {{- range $name, $value := .ports }}
  {{- $_ := set $ports $name $value }}
  {{- end }}
  {{- end }}
  {{- range $name, $value := $ports }}
  {{ $name }}: {{ $value.port | quote }}
  {{- end }}
{{- end }}
{{- end -}}
