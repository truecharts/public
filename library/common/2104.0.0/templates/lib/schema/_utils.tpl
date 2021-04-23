{{/*
Checks if a list of keys are present in a dictionary
*/}}
{{- define "common.schema.validateKeys" -}}
{{- $values := . -}}
{{- if and (hasKey $values "values") (hasKey $values "checkKeys") -}}
{{- $missingKeys := list -}}
{{- range $values.checkKeys -}}
{{- if eq (hasKey $values.values . ) false -}}
{{- $missingKeys = mustAppend $missingKeys . -}}
{{- end -}}
{{- end -}}
{{- if $missingKeys -}}
{{- fail (printf "Missing %s from dictionary" ($missingKeys | join ", ")) -}}
{{- end -}}
{{- else -}}
{{- fail "A dictionary and list of keys to check must be provided" -}}
{{- end -}}
{{- end -}}
