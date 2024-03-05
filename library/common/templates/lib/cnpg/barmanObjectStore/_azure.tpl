{{- define "tc.v1.common.lib.cnpg.cluster.barmanObjectStoreConfig.azure" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $type := .type -}}
  {{- $data := .data -}}

  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $rootCtx -}}
  {{- $secretName := (printf "%s-cnpg-%s-provider-%s-azure-creds" $fullname $objectData.shortName $type) -}}
  {{- $serverName :=  $objectData.clusterName -}}

  {{- $endpointURL := "" -}}
  {{- $destinationPath := "" -}}
  {{- $k := "" -}}
  {{- if eq $type "recovery" -}}
    {{- $endpointURL = $objectData.recovery.endpointURL -}}
    {{- $destinationPath = $objectData.recovery.destinationPath -}}
    {{- $k = "recovery" -}}
    {{- if $objectData.recovery.serverName -}}
      {{- $serverName = $objectData.recovery.serverName -}}
    {{- end -}}
    {{- if $objectData.recovery.revision -}}
      {{- $serverName = printf "%s-%s" $serverName $objectData.recovery.revision -}}
    {{- end -}}
  {{- else if eq $type "backup" -}}
    {{- $endpointURL = $objectData.backups.endpointURL -}}
    {{- $destinationPath = $objectData.backups.destinationPath -}}
    {{- $k = "backups" -}}
    {{- if $objectData.backups.serverName -}}
      {{- $serverName = $objectData.backups.serverName -}}
    {{- end -}}
    {{- if $objectData.backups.revision -}}
      {{- $serverName = printf "%s-%s" $serverName $objectData.backups.revision -}}
    {{- end -}}
  {{- end -}}
  {{- if not $destinationPath -}}
    {{- if not $data.storageAccount -}}
      {{- fail (printf "CNPG %s - You need to specify [%s.azure.storageAccount] or [%s.destinationPath]" ($type | camelcase) $k $k) -}}
    {{- end -}}
    {{- if not $data.serviceName -}}
      {{- fail (printf "CNPG %s - You need to specify [%s.azure.serviceName] or [%s.destinationPath]" ($type | camelcase) $k $k) -}}
    {{- end -}}
    {{- if not $data.containerName -}}
      {{- fail (printf "CNPG %s - You need to specify [%s.azure.containerName] or [%s.destinationPath]" ($type | camelcase) $k $k) -}}
    {{- end -}}
    {{- $destinationPath = (printf "https://%s.%s.core.windows.net/%s/%s" $data.storageAccount $data.serviceName $data.containerName (($data.path | default "/") | trimSuffix "/")) -}}
  {{- end }}
endpointURL: {{ $endpointURL }}
destinationPath: {{ $destinationPath }}
serverName: {{  $serverName }}
azureCredentials:
  connectionString:
    name: {{ $secretName }}
    key: CONNECTION_STRING
  storageAccount:
    name: {{ $secretName }}
    key: STORAGE_ACCOUNT
  storageKey:
    name: {{ $secretName }}
    key: STORAGE_KEY
  storageSasToken:
    name: {{ $secretName }}
    key: STORAGE_SAS_TOKEN
{{- end -}}
