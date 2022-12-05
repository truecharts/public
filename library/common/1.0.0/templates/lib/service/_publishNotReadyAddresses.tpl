{{- define "ix.v1.common.class.serivce.publishNotReadyAddresses" -}}
  {{- $pubNotReadAddr := false -}}

  {{- with .publishNotReadyAddresses -}}
    {{- $pubNotReadAddr = true -}}
  {{- end }}
publishNotReadyAddresses: {{ $pubNotReadAddr }}
{{- end -}}
