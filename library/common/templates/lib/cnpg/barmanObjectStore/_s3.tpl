{{- define "tc.v1.common.lib.cnpg.cluster.barmanObjectStoreConfig.s3" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $type := .type -}}
  {{- $data := .data -}}

  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $rootCtx -}}
  {{- $secretName := (printf "%s-cnpg-%s-provider-%s-s3-creds" $fullname $objectData.shortName $type) -}}

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
    {{- if not $data.bucket -}}
      {{- fail (printf "CNPG %s - You need to specify [%s.s3.bucket] or [%s.destinationPath]" ($type | camelcase) $key $key) -}}
    {{- end -}}
    {{- $destinationPath = (printf "s3://%s/%s" $data.bucket (($objectData.path | default "/") | trimSuffix "/")) -}}
  {{- end -}}
  {{- if not $endpointURL -}}
    {{- if not $data.region -}}
      {{- fail (printf "CNPG %s - You need to specify [%s.s3.region] or [%s.endpointURL]" ($type | camelcase) $key $key) -}}
    {{- end -}}
    {{- $endpointURL = (printf "https://s3.%s.amazonaws.com" $data.region) -}}
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
