{{- define "tc.v1.common.values.volumeSnapshotLocationList" -}}
  {{- $rootCtx := . -}}

  {{- range $idx, $vslValues := $rootCtx.Values.volumeSnapshotLocationList -}}

      {{- $name := (printf "vs-list-%s" (toString $idx)) -}}

      {{- with $vslValues.name -}}
        {{- $name = . -}}
      {{- end -}}

      {{- if not (hasKey $rootCtx.Values "volumeSnapshotLocation") -}}
        {{- $_ := set $rootCtx.Values "volumeSnapshotLocation" dict -}}
      {{- end -}}

      {{- $_ := set $rootCtx.Values.volumeSnapshotLocation $name $vslValues -}}
  {{- end -}}
{{- end -}}
