{{- define "tc.v1.common.lib.volsync.storage" -}}
  {{- $creds := .creds -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $volsyncData := .volsyncData -}}
  {{- $target := get $volsyncData .target -}}

  {{- with $target.storageClassName }}
storageClassName: {{ . }}
  {{- end -}}

accessModes:
  {{- if $target.accessModes }}

    {{- range $target.accessModes }}
  - {{ . }}
    {{- end }}
  {{- else if $objectData.accessModes }}
    {{- range  $objectData.accessModes }}
  - {{ . }}
    {{- end }}
  {{- else }}
    {{- range  $rootCtx.Values.global.fallbackDefaults.accessModes }}
  - {{ . }}
    {{- end }}
  {{- end -}}

  {{- with $target.volumeSnapshotClassName }}
volumeSnapshotClassName: {{ . }}
  {{- end -}}
{{- end -}}
