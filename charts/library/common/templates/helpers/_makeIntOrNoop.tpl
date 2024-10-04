{{- define "tc.v1.common.helper.makeIntOrNoop" -}}
  {{- $value := . -}}

  {{/*
      - Ints in Helm can be either int, int64 or float64.
      - Values that start with zero should not be converted
        to int again as this will strip leading zeros.
      - Numbers converted to E notation by Helm will
        always contain the "e" character. So we only
        convert those.
  */}}
  {{- if and
      (mustHas (kindOf $value) (list "int" "int64" "float64"))
      (not (hasPrefix "0" ($value | toString)))
      (contains "e" ($value | toString | lower))
  -}}
    {{- $value | int -}}
  {{- else -}}
    {{- $value -}}
  {{- end -}}
{{- end -}}
