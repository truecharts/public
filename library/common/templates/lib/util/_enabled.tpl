{{- define "tc.v1.common.lib.util.enabled" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $key := .key -}}
  {{- $name := (.name | toString) -}}
  {{- $caller := .caller -}}

  {{- $enabled := false -}}
  {{- if hasKey $objectData "enabled" -}}
    {{- if not (kindIs "invalid" $objectData.enabled) -}}
      {{- $enabled = $objectData.enabled -}}
    {{- else -}}
      {{- fail (printf "%s - Expected the defined key [enabled] in [%s.%s] to not be empty" $caller $key $name) -}}
    {{- end -}}
  {{- end -}}

  {{- if kindIs "string" $enabled -}}
    {{- $enabled = tpl $enabled $rootCtx -}}
    {{- if eq $enabled "true" -}}
      {{- $enabled = true -}}
    {{- else if eq $enabled "false" -}}
      {{- $enabled = false -}}
    {{- end -}}
  {{- end -}}

  {{/* NOTE: Always treat the returned result as string */}}
  {{- $enabled -}}
{{- end -}}
