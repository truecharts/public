{{/* Define the portalHook */}}
{{- define "traefik.portalhook" -}}
{{- if .Values.portalhook.enabled }}
{{- $namespace := ( printf "ix-%s" .Release.Name ) }}
{{- if or ( not .Values.ingressClass.enabled ) ( and ( .Values.ingressClass.enabled ) ( .Values.ingressClass.isDefaultClass ) ) }}
{{- $namespace = "traefikmiddlewares" }}
{{- end }}
---

apiVersion: v1
kind: ConfigMap
metadata:
  name: portalhook
  namespace: {{ $namespace }}
data:
  {{- $ports := dict }}
  {{- range $.Values.service }}
  {{- range $name, $value := .ports }}
  {{- $_ := set $ports $name $value }}
  {{- end }}
  {{- end }}
  websecureport: {{ $ports.websecure.exposedPort | quote }}
  {{- range $name, $value := $ports }}
  {{ $name }}: {{ $value.port | quote }}
  {{- end }}
{{- end }}
{{- end -}}
