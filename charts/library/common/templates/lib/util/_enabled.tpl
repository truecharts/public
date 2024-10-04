{{- define "tc.v1.common.lib.util.enabled" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $key := .key -}}
  {{- $name := (.name | toString) -}}
  {{- $caller := .caller -}}

  {{- $enabled := false -}}
  {{- if not (hasKey $objectData "enabled") -}}
    {{- fail (printf "%s - Expected the key [enabled] in [%s.%s] to exist" $caller $key $name) -}}
  {{- end -}}

  {{- if (kindIs "invalid" $objectData.enabled) -}}
    {{- fail (printf "%s - Expected the defined key [enabled] in [%s.%s] to not be empty" $caller $key $name) -}}
  {{- end -}}
  {{- $enabled = $objectData.enabled -}}

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
