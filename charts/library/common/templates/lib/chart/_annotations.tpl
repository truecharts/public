{{/* Common annotations shared across objects */}}
{{- define "common.annotations.workload" -}}
rollme: {{ randAlphaNum 5 | quote }}
{{- if .Values.ixExternalInterfacesConfigurationNames }}
k8s.v1.cni.cncf.io/networks: {{ join ", " .Values.externalInterfaces }}
{{- end }}
{{- end -}}
