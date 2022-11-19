{{/* Returns tolerations */}}
{{- define "ix.v1.common.tolerations" -}}
  {{- $tolerations := .tolerations -}}
  {{- $root := .root -}}

  {{- range $tolerations }}
    {{- $operator := (tpl (default "Equal" .operator) $root)  -}}
    {{- if not (mustHas $operator (list "Exists" "Equal")) -}}
      {{- fail "Invalid <operator>. Valid options are Exists, Equal." -}}
    {{- end -}}

    {{- $key := (tpl (default "" .key) $root) -}} {{/* Empty key matches all keys */}}
    {{- if and (eq $operator "Equal") (not $key) -}}
      {{- fail "<key> is required when <operator> is set to <Equal>" -}}
    {{- end -}}

    {{- $value := (tpl (default "" .value) $root) -}}
    {{- if and (eq $operator "Exists") $value -}}
      {{- fail "When <operator> is set to <Exists>, you cannot define a <value>" -}}
    {{- end -}}

    {{- $effect := (tpl (default "" .effect) $root) -}} {{/* Empty effect matches all effects with the key */}}
    {{- if and $effect (not (mustHas $effect (list "NoExecute" "NoSchedule" "PreferNoSchedule"))) -}}
      {{- fail (printf "Invalid <effect> (%s). Valid options are NoExecute, NoSchedule, PreferNoSchedule" $effect) -}}
    {{- end -}}

    {{- $tolSeconds := (default "" .tolerationSeconds) -}}
    {{- if and $tolSeconds (not (mustHas (kindOf $tolSeconds) (list "float64" "int"))) -}}
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
