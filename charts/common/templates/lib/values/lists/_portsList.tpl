{{/* merge portsList with ports */}}
{{- define "tc.common.lib.values.ports.list" -}}
  {{- range $index, $item := .Values.service -}}
  {{- if $item.enabled }}
  {{- $portsDict := dict }}
  {{- range $index2, $item2 :=  $item.portsList -}}
  {{- if $item2.enabled }}
    {{- $name := ( printf "list-%s" ( $index2 | toString ) ) }}
    {{- if $item2.name }}
      {{- $name = $item2.name }}
    {{- end }}
    {{- $_ := set $portsDict $name $item2 }}
  {{- end }}
  {{- $tmp := $item.ports }}
  {{- $ports := merge $tmp $portsDict }}
  {{- $_ := set $item "ports" (deepCopy $ports) -}}
  {{- end }}
  {{- end }}
  {{- end }}
{{- end -}}
