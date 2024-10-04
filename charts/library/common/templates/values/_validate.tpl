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

    {{- fail (printf "%s \n %s \n\n %s \n %v \n %s \n\n %s"
          "Chart - Values contain an error that may be a result of merging. Make sure you don't have any invalid YAML characters starting a value."
          "Renderd Values containing the error:"
          "============================================================================================="
          $allValues
          "============================================================================================="
          "See error above values."
    ) -}}
  {{- end -}}

{{- end -}}
