{{/* Validates any object that it does not contain helm errors */}}
{{/* This usually can happen after merging values from an include that did not render correcly */}}
{{/* Any object will be passed to "toYaml" */}}
{{/* Call this template:
{{ include "tc.v1.common.values.validate" . }}
*/}}
{{- define "tc.v1.common.values.validate" -}}
  {{- $allValues := (toYaml .) -}}

  {{- if contains "error converting YAML to JSON" $allValues -}}
    {{/* Print values to show values with the error included. */}}
    {{/* Ideally we would want to extract the error only, but because it usually contains ":",
        It gets parsed as dict and it cant regex matched it afterwards */}}

    {{- fail (printf "Chart - Values contain an error that may be a result of merging. Values containing the error: \n\n %v \n\n See error above values." $allValues) -}}
  {{- end -}}

{{- end -}}
