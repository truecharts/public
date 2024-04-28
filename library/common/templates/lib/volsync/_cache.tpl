{{- define "tc.v1.common.lib.volsync.cache" -}}
  {{- $creds := .creds -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $volsyncData := .volsyncData -}}
  {{- $target := get $volsyncData .target -}}

  {{- with $target.cacheCapacity }}
cacheCapacity: {{ $target.cacheCapacity }}
  {{- end -}}

  {{- with $target.cacheStorageClassName }}
cacheStorageClassName: {{ $target.cacheStorageClassName }}
  {{- end -}}

  {{- with $target.cacheAccessModes }}
cacheAccessModes:
    {{- range . }}
  - {{ . }}
    {{- end }}
  {{- end -}}
{{- end -}}
