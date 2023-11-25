{{- define "tc.v1.common.values.backupStorageLocationList" -}}
  {{- $rootCtx := . -}}

  {{- range $idx, $bslValues := $rootCtx.Values.backupStorageLocationList -}}

      {{- $name := (printf "bsl-list-%s" (toString $idx)) -}}

      {{- with $bslValues.name -}}
        {{- $name = . -}}
      {{- end -}}

      {{- if not (hasKey $rootCtx.Values "backupStorageLocation") -}}
        {{- $_ := set $rootCtx.Values "backupStorageLocation" dict -}}
      {{- end -}}

      {{- $_ := set $rootCtx.Values.backupStorageLocation $name $bslValues -}}
  {{- end -}}
{{- end -}}
