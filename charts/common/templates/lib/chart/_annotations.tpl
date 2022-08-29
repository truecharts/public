{{/* Common annotations shared across objects */}}
{{- define "tc.common.annotations" -}}
  {{- with .Values.global.annotations }}
    {{- range $k, $v := . }}
      {{- $name := $k }}
      {{- $value := tpl $v $ }}
{{ $name }}: {{ quote $value }}
    {{- end }}
  {{- end }}
{{- end -}}

{{/* Annotations on all workload spec objects */}}
{{- define "tc.common.annotations.workload.spec" -}}
{{- if .Values.ixExternalInterfacesConfigurationNames }}
k8s.v1.cni.cncf.io/networks: {{ join ", " .Values.ixExternalInterfacesConfigurationNames }}
{{- end }}
{{- end -}}

{{/* Annotations on all workload objects */}}
{{- define "tc.common.annotations.workload" -}}
rollme: {{ randAlphaNum 5 | quote }}
{{- end -}}
