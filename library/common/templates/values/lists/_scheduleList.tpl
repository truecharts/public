{{- define "tc.v1.common.values.schedulesList" -}}
  {{- $rootCtx := . -}}

  {{- range $idx, $scheduleValues := $rootCtx.Values.schedulesList -}}

      {{- $name := (printf "schedules-list-%s" (toString $idx)) -}}

      {{- with $scheduleValues.name -}}
        {{- $name = . -}}
      {{- end -}}

      {{- if not (hasKey $rootCtx.Values "schedules") -}}
        {{- $_ := set $rootCtx.Values "schedules" dict -}}
      {{- end -}}

      {{- $_ := set $rootCtx.Values.schedules $name $scheduleValues -}}
  {{- end -}}
{{- end -}}
