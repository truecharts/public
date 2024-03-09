{{- define "tc.v1.common.lib.cnpg.cluster.barmanObjectStoreConfig.getData" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $type := .type -}}

  {{- $serverName :=  $objectData.clusterName -}}
  {{- $endpointURL := "" -}}
  {{- $destinationPath := "" -}}
  {{- $key := "" -}}

  {{- if eq $type "recovery" -}}
    {{- $endpointURL = $objectData.recovery.endpointURL -}}
    {{- $destinationPath = $objectData.recovery.destinationPath -}}
    {{- $key = "recovery" -}}

    {{- if $objectData.recovery.serverName -}}
      {{- $serverName = $objectData.recovery.serverName -}}
    {{- end -}}
    {{- if $objectData.recovery.revision -}}
      {{- $serverName = printf "%s-r%s" $serverName $objectData.recovery.revision -}}
    {{- end -}}

  {{- else if eq $type "backup" -}}

    {{- $endpointURL = $objectData.backups.endpointURL -}}
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
    "key" $key
  ) -}}

  {{- $data | toYaml -}}
{{- end -}}
