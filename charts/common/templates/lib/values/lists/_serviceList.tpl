{{/* merge serviceList with service */}}
{{- define "tc.common.lib.values.service.list" -}}
  {{- $portsDict := dict }}
  {{- range $index, $item := .Values.serviceList -}}
  {{- if $item.enabled }}
    {{- $name := ( printf "list-%s" ( $index | toString ) ) }}
    {{- if $item.name }}
      {{- $name = $item.name }}
    {{- end }}
    {{- $_ := set $portsDict $name $item }}
  {{- end }}
  {{- end }}
  {{- $srv := merge .Values.service $portsDict }}
  {{- $_ := set .Values "service" (deepCopy $srv) -}}
{{- end -}}
