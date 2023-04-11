{{- define "tc.v1.common.values.persistenceList" -}}
  {{- $rootCtx := . -}}

  {{- range $idx, $persistenceValues := $rootCtx.Values.persistenceList -}}
    {{- $name := (printf "persist-list-%s" (toString $idx)) -}}

    {{- with $persistenceValues.name -}}
      {{- $name = . -}}
    {{- end -}}

    {{- if not (hasKey $rootCtx.Values "persistence") -}}
      {{- $_ := set $rootCtx.Values "persistence" dict -}}
    {{- end -}}

    {{- $_ := set $rootCtx.Values.persistence $name $persistenceValues -}}

  {{- end -}}
{{- end -}}
