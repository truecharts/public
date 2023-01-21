{{- define "ix.v1.common.class.serivce.externalIPs" -}}
  {{- $svcValues := .svc -}}
  {{- $root := .root -}}

  {{- with $svcValues.externalIPs }}
externalIPs:
    {{- range . }}
  - {{ tpl . $root }}
    {{- end -}}
  {{- end -}}
{{- end -}}
