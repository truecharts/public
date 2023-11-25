{{- define "tc.v1.common.values.volumeSnapshotClassList" -}}
  {{- $rootCtx := . -}}

  {{- range $idx, $volSnapValues := $rootCtx.Values.volumeSnapshotClassList -}}

      {{- $name := (printf "vs-list-%s" (toString $idx)) -}}

      {{- with $volSnapValues.name -}}
        {{- $name = . -}}
      {{- end -}}

      {{- if not (hasKey $rootCtx.Values "volumeSnapshotClass") -}}
        {{- $_ := set $rootCtx.Values "volumeSnapshotClass" dict -}}
      {{- end -}}

      {{- $_ := set $rootCtx.Values.volumeSnapshotClass $name $volSnapValues -}}
  {{- end -}}
{{- end -}}
