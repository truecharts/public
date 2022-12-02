{{- define "ix.v1.common.class.serivce.externalIPs" -}}
  {{- $externalIPs := .externalIPs -}}
  {{- $root := .root -}}
externalIPs:
  {{- range $externalIPs }}
  - {{ tpl . $root }}
  {{- end }}
{{- end -}}
