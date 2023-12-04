{{- define "tc.v1.common.lib.cnpg.pooler.validation" -}}
  {{- $objectData := .objectData -}}

  {{- $validTypes := (list "rw" "ro") -}}
  {{- if not (mustHas $objectData.pooler.type $validTypes) -}}
    {{- fail (printf "CNPG Pooler - Expected [type] to be one one of [%s], but got [%s]" (join ", " $validTypes) $objectData.pooler.type) -}}
  {{- end -}}

  {{- $validPgModes := (list "session" "transaction") -}}
  {{- if $objectData.pooler.poolMode -}}
    {{- if not (mustHas $objectData.pooler.poolMode $validPgModes) -}}
      {{- fail (printf "CNPG Pooler - Expected [poolMode] to be one of [%s], but got [%s]" (join ", " $validPgModes) $objectData.pooler.poolMode) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
