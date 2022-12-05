{{/* Returns tolerations */}}
{{- define "ix.v1.common.tolerations" -}}
  {{- range .Values.tolerations }}
    {{- $operator := (tpl (default "Equal" .operator) $)  -}}
    {{- if not (has $operator (list "Exists" "Equal")) -}}
      {{- fail "Invalid <operator>. Valid options are Exists, Equal." -}}
    {{- end -}}

    {{- $key := (tpl (default "" .key) $) -}} {{/* Empty key matches all keys */}}
    {{- if and (eq $operator "Equal") (not $key) -}}
      {{- fail "<key> is required when <operator> is set to <Equal>" -}}
    {{- end -}}

    {{- $value := (tpl (default "" .value) $) -}}
    {{- if and (eq $operator "Exists") $value -}}
      {{- fail "When <operator> is set to <Exists>, you cannot define a <value>" -}}
    {{- end -}}

    {{- $effect := (tpl (default "" .effect) $) -}} {{/* Empty effect matches all effects with the key */}}
    {{- if and $effect (not (has $effect (list "NoExecute" "NoSchedule" "PreferNoSchedule"))) -}}
      {{- fail (printf "Invalid <effect> (%s). Valid options are NoExecute, NoSchedule, PreferNoSchedule" $effect) -}}
    {{- end -}}

    {{- $tolSeconds := (default "" .tolerationSeconds) -}}
    {{- if and $tolSeconds (not (has (kindOf $tolSeconds) (list "float64" "int"))) -}}
      {{- fail "<tolerationSeconds> must result to an integer." -}}
    {{- end }}
- operator: {{ $operator }}
    {{- with $key }}
  key: {{ . }}
    {{- end }}
    {{- with $effect }}
  effect: {{ . }}
    {{- end }}
    {{- with $value }}
  value: {{ . }}
    {{- end -}}
    {{- with $tolSeconds }}
  tolerationSeconds: {{ . }}
    {{- end -}}
  {{- end -}}
{{- end -}}
