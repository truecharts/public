{{/* Returns tolerations */}}
{{- define "ix.v1.common.tolerations" -}}
  {{- range .Values.tolerations }}
    {{- $operator := (tpl (default "Equal" .operator) $)  -}}
    {{- if and (ne $operator "Exists") (ne $operator "Equal") -}}
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
    {{- if and $effect (ne $effect "NoExecute") (ne $effect "NoSchedule") (ne .effect "PreferNoSchedule") -}}
      {{- fail "Invalid <effect>. Valid options are NoExecute, NoSchedule, PreferNoSchedule" -}}
    {{- end -}}

    {{- $tolSeconds := (default "" .tolerationSeconds) -}}
    {{- if and $tolSeconds (and (not (kindIs "float64" $tolSeconds)) (not (kindIs "int" $tolSeconds))) -}}
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
