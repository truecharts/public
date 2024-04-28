{{- define "tc.v1.common.lib.volsync.storage" -}}
  {{- $creds := .creds -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $volsyncData := .volsyncData -}}
  {{- $target := get $volsyncData .target -}}

  {{- with $target.storageClassName }}
storageClassName: {{ . }}
  {{- end -}}

  {{- with $target.accessModes }}
accessModes:
    {{- range . }}
  - {{ . }}
    {{- end }}
  {{- end -}}

  {{- with $target.volumeSnapshotClassName }}
volumeSnapshotClassName: {{ . }}
  {{- end -}}
{{- end -}}
