{{- define "tc.v1.common.lib.cnpg.cluster.barmanObjectStoreConfig.s3" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $type := .type -}}
  {{- $data := .data -}}

  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $rootCtx -}}
  {{- $secretName := (printf "%s-cnpg-%s-provider-%s-s3-creds" $fullname $objectData.shortName $type) -}}
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
      {{- $serverName = printf "%s-r%s" $serverName $objectData.recovery.revision -}}
    {{- end -}}
  {{- else if eq $type "backup" -}}
    {{- $endpointURL = $objectData.backups.endpointURL -}}
    {{- $destinationPath = $objectData.backups.destinationPath -}}
    {{- $k = "backups" -}}
    {{- if $objectData.backups.serverName -}}
      {{- $serverName = $objectData.backups.serverName -}}
    {{- end -}}
    {{- if $objectData.backups.revision -}}
      {{- $serverName = printf "%s-r%s" $serverName $objectData.backups.revision -}}
    {{- end -}}
  {{- end -}}
  {{- if not $destinationPath -}}
    {{- if not $data.bucket -}}
      {{- fail (printf "CNPG %s - You need to specify [%s.s3.bucket] or [%s.destinationPath]" ($type | camelcase) $k $k) -}}
    {{- end -}}
    {{- $destinationPath = (printf "s3://%s/%s" $data.bucket (($data.path | default "/") | trimSuffix "/")) -}}
  {{- end -}}
  {{- if not $endpointURL -}}
    {{- if not $data.region -}}
      {{- fail (printf "CNPG %s - You need to specify [%s.s3.region] or [%s.endpointURL]" ($type | camelcase) $k $k) -}}
    {{- end -}}
    {{- $endpointURL = (printf "https://s3.%s.amazonaws.com" $data.region) -}}
  {{- end }}

endpointURL: {{ $endpointURL }}
destinationPath: {{ $destinationPath }}
serverName: {{  $serverName }}
s3Credentials:
  accessKeyId:
    name: {{ $secretName }}
    key: ACCESS_KEY_ID
  secretAccessKey:
    name: {{ $secretName }}
    key: ACCESS_SECRET_KEY
{{- end -}}
