{{- define "tc.v1.common.lib.cnpg.cluster.barmanObjectStoreConfig.s3" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $type := .type -}}
  {{- $data := .data -}}

  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $rootCtx -}}
  {{- $secretName := (printf "%s-cnpg-%s-provider-%s-s3-creds" $fullname $objectData.shortName $type) -}}

  {{- $calcData := include "tc.v1.common.lib.cnpg.cluster.barmanObjectStoreConfig.getData" (dict
      "rootCtx" $rootCtx "objectData" $objectData "type" $type) | fromYaml
  -}}

  {{- $serverName := $calcData.serverName -}}
  {{- $destinationPath := $calcData.destinationPath -}}
  {{- $endpointURL := $calcData.creds.url -}}
  {{- $bucket := $calcData.creds.bucket -}}
  {{- $path := $calcData.creds.path -}}
  {{- $key := $calcData.key -}}

  {{- if not $destinationPath -}}
    {{- if $path -}}
      {{- $destinationPath = (printf "s3://%s/%s/%s/cnpg" $bucket ($path | trimSuffix "/") $rootCtx.Release.Name) -}}
    {{- else -}}
      {{- $destinationPath = (printf "s3://%s/%s/cnpg" $bucket $rootCtx.Release.Name) -}}
    {{- end -}}
  {{- end }}
endpointURL: {{ $endpointURL }}
destinationPath: {{ $destinationPath }}
serverName: {{ $serverName }}
s3Credentials:
  accessKeyId:
    name: {{ $secretName }}
    key: ACCESS_KEY_ID
  secretAccessKey:
    name: {{ $secretName }}
    key: ACCESS_SECRET_KEY
{{- end -}}
