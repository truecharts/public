{{- define "tc.v1.common.values.volumeSnapshotList" -}}
  {{- $rootCtx := . -}}

  {{- range $idx, $volSnapValues := $rootCtx.Values.volumeSnapshotsList -}}

      {{- $name := (printf "vs-list-%s" (toString $idx)) -}}

      {{- with $volSnapValues.name -}}
        {{- $name = . -}}
      {{- end -}}

      {{- if not (hasKey $rootCtx.Values "volumeSnapshots") -}}
        {{- $_ := set $rootCtx.Values "volumeSnapshots" dict -}}
      {{- end -}}

      {{- $_ := set $rootCtx.Values.volumeSnapshots $name $volSnapValues -}}
  {{- end -}}
{{- end -}}
