{{/* Common annotations shared across objects */}}
{{- define "common.annotations.workload.spec" -}}
rollme: {{ randAlphaNum 5 | quote }}
{{- if .Values.externalInterfaces }}
k8s.v1.cni.cncf.io/networks: {{ join ", " .Values.externalInterfaces }}
{{- end }}
{{- end -}}

{{- define "common.annotations.workload" -}}
rollme: {{ randAlphaNum 5 | quote }}
{{- end -}}
