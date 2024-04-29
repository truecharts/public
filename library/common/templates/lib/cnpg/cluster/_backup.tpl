{{- define "tc.v1.common.lib.cnpg.cluster.backup" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
backup:
  {{- with $objectData.backups.target }}
  target: {{ . }}
  {{- end }}
  retentionPolicy: {{ $objectData.backups.retentionPolicy }}
  barmanObjectStore:
    wal:
      compression: gzip
      encryption: AES256
    data:
      compression: gzip
      encryption: AES256
      jobs: {{ $objectData.backups.jobs | default 2 }}
  {{/* Fetch provider data */}}
  {{/* Get the creds defined in backup.$provider */}}
  {{- $creds := (get $rootCtx.Values.credentials $objectData.backups.credentials) -}}
  {{ $provider := $creds.type -}}
  {{- include (printf "tc.v1.common.lib.cnpg.cluster.barmanObjectStoreConfig.%s" $provider) (dict "rootCtx" $rootCtx "objectData" $objectData "data" $creds "type" "backup") | nindent 4 -}}
{{- end -}}
