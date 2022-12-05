{{- define "ix.v1.common.class.serivce.externalTrafficPolicy" -}}
  {{- $svcType := .svcType -}}
  {{- $svcValues := .svc -}}

  {{- with $svcValues.externalTrafficPolicy -}}
    {{- if not (mustHas . (list "Cluster" "Local")) -}}
      {{- fail (printf "Invalid option (%s) for <externalTrafficPolicy>. Valid options are Cluster and Local" .) -}}
    {{- end }}
externalTrafficPolicy: {{ . }}
  {{- end -}}
{{- if ne $svcType "ClusterIP" -}}
{{- end -}}
{{- end -}}
