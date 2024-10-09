{{- define "tc.v1.common.lib.util.diagnosticMode" -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $diagMode := "" -}}

  {{- $itemsToCheck := (list $rootCtx.Values $rootCtx.Values.global) -}}

  {{- range $item := $itemsToCheck -}}
    {{- if hasKey $item "diagnosticMode" -}}
      {{- if not (kindIs "map" $item.diagnosticMode) -}}
        {{- fail (printf "Diagnostic Mode - Expected [diagnosticMode] to be a map, but got [%s]" (kindOf $item.diagnosticMode)) -}}
      {{- end -}}
      {{- if hasKey $item.diagnosticMode "enabled" -}}
        {{- if not (kindIs "bool" $item.diagnosticMode.enabled) -}}
          {{- fail (printf "Diagnostic Mode - Expected [diagnosticMode.enabled] to be a bool, but got [%s]" (kindOf $item.diagnosticMode.enabled)) -}}
        {{- end -}}
      {{- end -}}

      {{/* Ignore if its not true as we want any item
          that is true to apply regardless of the order
      */}}
      {{- if $item.diagnosticMode.enabled -}}
        {{- $diagMode = true -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- $diagMode | toString -}}
{{- end -}}
