{{/* merge ingressList with ingress */}}
{{- define "tc.common.lib.values.ingress.list" -}}
  {{- $ingDict := dict }}
  {{- range $index, $item := .Values.ingressList -}}
    {{- $name := ( printf "list-%s" ( $index | toString ) ) }}
    {{- if $item.name }}
      {{- $name = $item.name }}
    {{- end }}
    {{- $_ := set $ingDict $name $item }}
  {{- end }}
  {{- $ing := merge .Values.ingress $ingDict }}
  {{- $_ := set .Values "ingress" (deepCopy $ing) -}}
{{- end -}}
