{{- define "tc.v1.common.values.deviceList" -}}
  {{- $rootCtx := . -}}

  {{- range $idx, $deviceValues := $rootCtx.Values.deviceList -}}
    {{- if eq $deviceValues.type "device" -}}
      {{- $name := (printf "device-%s" (toString $idx)) -}}

      {{- with $deviceValues.name -}}
        {{- $name = . -}}
      {{- end -}}

      {{- if not (hasKey $rootCtx.Values "persistence") -}}
        {{- $_ := set $rootCtx.Values "persistence" dict -}}
      {{- end -}}

      {{- $_ := set $rootCtx.Values.persistence $name $deviceValues -}}
    {{- else -}}
      {{- fail (printf "Device List - Only [device] type can be defined in deviceList, but got [%s]" $deviceValues.type) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
