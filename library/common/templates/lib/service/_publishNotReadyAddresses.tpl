{{- define "ix.v1.common.class.serivce.publishNotReadyAddresses" -}}
  {{- $pubNotReadyAddr := false -}}

  {{- if .publishNotReadyAddresses -}}
    {{- $pubNotReadyAddr = true -}}
  {{- end }}
publishNotReadyAddresses: {{ $pubNotReadyAddr }}
{{- end -}}
