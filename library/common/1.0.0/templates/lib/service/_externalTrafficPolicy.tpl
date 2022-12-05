{{- define "ix.v1.common.class.serivce.externalTrafficPolicy" -}}
{{- $svcType := .svcType -}}
{{- $svcValues := .svc -}}

{{- if ne $svcType "ClusterIP" -}}
  {{- with $svcValues.externalTrafficPolicy -}}
    {{- if not (has . (list "Cluster" "Local")) -}}
      {{- fail (printf "Invalid option (%s) for <externalTrafficPolicy>. Valid options are Cluster and Local" .) -}}
    {{- end }}
externalTrafficPolicy: {{ . }}
  {{- end -}}
{{- end -}}
{{- end -}}
