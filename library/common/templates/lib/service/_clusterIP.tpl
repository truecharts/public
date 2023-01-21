{{- define "ix.v1.common.class.serivce.clusterIP" -}}
  {{- $svcValues := .svc -}}

  {{- with $svcValues.clusterIP }}
clusterIP: {{ . }}
  {{- end -}}
{{- end -}}
