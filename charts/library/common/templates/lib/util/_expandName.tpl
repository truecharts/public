{{- define "tc.v1.common.lib.util.expandName" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $key := .key -}}
  {{- $name := (.name | toString) -}}
  {{- $caller := .caller -}}

  {{- $expandName := true -}}
  {{- if (hasKey $objectData "expandObjectName") -}}
    {{- if not (kindIs "invalid" $objectData.expandObjectName) -}}
      {{- $expandName = $objectData.expandObjectName -}}
    {{- else -}}
      {{- fail (printf "%s - Expected the defined key [expandObjectName] in [%s.%s] to not be empty" $caller $key $name) -}}
    {{- end -}}
  {{- end -}}

  {{- if kindIs "string" $expandName -}}
    {{- $expandName = tpl $expandName $rootCtx -}}

    {{/* After tpl it becomes a string, not a bool */}}
    {{- if eq $expandName "true" -}}
      {{- $expandName = true -}}
    {{- else if eq $expandName "false" -}}
      {{- $expandName = false -}}
    {{- end -}}
  {{- end -}}

  {{/* NOTE: Always treat the returned result as string */}}
  {{- $expandName -}}
{{- end -}}
