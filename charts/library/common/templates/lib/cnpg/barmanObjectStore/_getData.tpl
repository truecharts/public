{{- define "tc.v1.common.lib.cnpg.cluster.barmanObjectStoreConfig.getData" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $type := .type -}}

  {{- $serverName := $objectData.clusterName -}}
  {{- $endpointURL := "" -}}
  {{- $destinationPath := "" -}}
  {{- $creds := dict -}}
  {{- $key := "" -}}

  {{- if eq $type "recovery" -}}
    {{- $creds = (get $rootCtx.Values.credentials $objectData.recovery.credentials) -}}
    {{- include "tc.v1.common.lib.credentials.validation" (dict "rootCtx" $rootCtx "caller" "CNPG BarmanObjectStore" "credName" $objectData.recovery.credentials) -}}
    {{- $destinationPath = $objectData.recovery.destinationPath -}}
    {{- $key = "recovery" -}}

    {{- if $objectData.recovery.serverName -}}
      {{- $serverName = $objectData.recovery.serverName -}}
    {{- end -}}
    {{- if $objectData.recovery.revision -}}
      {{- $serverName = printf "%s-r%s" $serverName $objectData.recovery.revision -}}
    {{- end -}}

  {{- else if eq $type "backup" -}}
    {{- $creds = (get $rootCtx.Values.credentials $objectData.backups.credentials) -}}
    {{- include "tc.v1.common.lib.credentials.validation" (dict "rootCtx" $rootCtx "caller" "CNPG BarmanObjectStore" "credName" $objectData.backups.credentials) -}}
    {{- $destinationPath = $objectData.backups.destinationPath -}}
    {{- $key = "backups" -}}

    {{- if $objectData.backups.serverName -}}
      {{- $serverName = $objectData.backups.serverName -}}
    {{- end -}}
    {{- if $objectData.backups.revision -}}
      {{- $serverName = printf "%s-r%s" $serverName $objectData.backups.revision -}}
    {{- end -}}
  {{- end -}}

  {{- $data := (dict
    "serverName" $serverName
    "endpointURL" $endpointURL
    "destinationPath" $destinationPath
    "creds" $creds
    "key" $key
  ) -}}

  {{- $data | toYaml -}}
{{- end -}}
