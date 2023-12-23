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
  {{- $provider := $objectData.backups.provider -}}
  {{/* Fetch provider data */}}
  {{- $data := (get $objectData.backups $provider) -}}
  {{- include (printf "tc.v1.common.lib.cnpg.cluster.barmanObjectStoreConfig.%s" $provider) (dict "rootCtx" $rootCtx "objectData" $objectData "data" $data "type" "backup") | nindent 4 -}}
{{- end -}}
