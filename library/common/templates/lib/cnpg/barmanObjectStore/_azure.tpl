{{- define "tc.v1.common.lib.cnpg.cluster.barmanObjectStoreConfig.azure" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $type := .type -}}
  {{- $data := .data -}}

  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $rootCtx -}}
  {{- $secretName := (printf "%s-cnpg-%s-provider-%s-azure-creds" $fullname $objectData.shortName $type) -}}

  {{- $calcData := include "tc.v1.common.lib.cnpg.cluster.barmanObjectStoreConfig.getData" (dict
    "rootCtx" $rootCtx
    "objectData" $objectData
    "type" $type
    ) | fromYaml -}}

  {{- $serverName := $calcData.serverName -}}
  {{- $endpointURL := $calcData.endpointURL -}}
  {{- $destinationPath := $calcData.destinationPath -}}
  {{- $key := $calcData.key -}}

  {{- if not $destinationPath -}}
    {{- if not $data.storageAccount -}}
      {{- fail (printf "CNPG %s - You need to specify [%s.azure.storageAccount] or [%s.destinationPath]" ($type | camelcase) $key $key) -}}
    {{- end -}}
    {{- if not $data.serviceName -}}
      {{- fail (printf "CNPG %s - You need to specify [%s.azure.serviceName] or [%s.destinationPath]" ($type | camelcase) $key $key) -}}
    {{- end -}}
    {{- if not $data.containerName -}}
      {{- fail (printf "CNPG %s - You need to specify [%s.azure.containerName] or [%s.destinationPath]" ($type | camelcase) $key $key) -}}
    {{- end -}}
    {{- if $data.path -}}
    {{- $destinationPath = (printf "https://%s.%s.core.windows.net/%s/%s/%s/cnpg" $data.storageAccount $data.serviceName $data.containerName ($data.path  | trimSuffix "/") $rootCtx.Release.Name) -}}
    {{- else -}}
    {{- $destinationPath = (printf "https://%s.%s.core.windows.net/%s/%s/cnpg" $data.storageAccount $data.serviceName $data.containerName $rootCtx.Release.Name) -}}
    {{- end -}}
  {{- end }}
endpointURL: {{ $endpointURL }}
destinationPath: {{ $destinationPath }}
serverName: {{ $serverName }}
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
