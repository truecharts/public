{{- define "tc.v1.common.lib.volsync.storage" -}}
  {{- $creds := .creds -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $volsyncData := .volsyncData -}}
  {{- $target := get $volsyncData .target -}}

  {{- $accessModes := $rootCtx.Values.global.fallbackDefaults.accessModes -}}
  {{- if $objectData.accessModes -}}
    {{- $accessModes = $objectData.accessModes -}}
  {{- end -}}
  {{- if $target.accessModes -}}
    {{- $accessModes = $target.accessModes -}}
  {{- end -}}

  {{- with $target.storageClassName }}
storageClassName: {{ . }}
  {{- end -}}

accessModes:
    {{- range $accessModes }}
  - {{ . }}
    {{- end -}}

  {{- with $target.volumeSnapshotClassName }}
volumeSnapshotClassName: {{ . }}
  {{- end -}}
{{- end -}}
