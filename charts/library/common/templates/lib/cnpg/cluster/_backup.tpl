{{- define "tc.v1.common.lib.cnpg.cluster.backup" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
backup:
  {{- with $objectData.backups.target }}
  target: {{ . }}
  {{- end }}
  retentionPolicy: {{ $objectData.backups.retentionPolicy }}
  barmanObjectStore:
    data:
      jobs: {{ $objectData.backups.jobs | default 2 }}
  {{- if and $objectData.backups.encryption $objectData.backups.encryption.enabled }}
      compression: "gzip"
      encryption: "AES256"
    wal:
      compression: "gzip"
      encryption: "AES256"
  {{- end -}}
  {{/* Fetch provider data */}}
  {{/* Get the creds defined in backup.$provider */}}
  {{- $creds := (get $rootCtx.Values.credentials $objectData.backups.credentials) -}}
  {{- include "tc.v1.common.lib.credentials.validation" (dict "rootCtx" $rootCtx "caller" "CNPG Backup" "credName" $objectData.backups.credentials) -}}

  {{- include (printf "tc.v1.common.lib.cnpg.cluster.barmanObjectStoreConfig.%s" $creds.type) (dict "rootCtx" $rootCtx "objectData" $objectData "data" $creds "type" "backup") | nindent 4 -}}
{{- end -}}
