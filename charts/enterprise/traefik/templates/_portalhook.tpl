{{/* Define the portalHook */}}
{{- define "traefik.portalhook" -}}
{{- if .Values.portalhook.enabled }}
---

apiVersion: v1
kind: ConfigMap
metadata:
  name: portalhook{{ if .Values.ingressClass.enabled }}-{{ .Release.Name }}{{ end }}
  namespace: tc-system
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
