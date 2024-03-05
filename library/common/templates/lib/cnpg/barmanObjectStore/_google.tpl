{{- define "tc.v1.common.lib.cnpg.cluster.barmanObjectStoreConfig.google" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $type := .type -}}
  {{- $data := .data -}}

  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $rootCtx -}}
  {{- $secretName := (printf "%s-cnpg-%s-provider-%s-google-creds" $fullname $objectData.shortName $type) -}}
  {{- $serverName :=  $objectData.clusterName -}}

  {{- $gkeEnv := false -}}
  {{- if (kindIs "bool" $data.gkeEnvionment) -}}
    {{- $gkeEnv = $data.gkeEnvionment -}}
  {{- end -}}

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
    {{- if not $data.bucket -}}
      {{- fail (printf "CNPG %s - You need to specify [%s.google.bucket] or [%s.destinationPath]" ($type | camelcase) $k $k) -}}
    {{- end -}}
    {{- $destinationPath = (printf "gs://%s/%s" $data.bucket (($data.path | default "/") | trimSuffix "/")) -}}
  {{- end }}
endpointURL: {{ $endpointURL }}
destinationPath: {{ $destinationPath }}
serverName: {{  $serverName }}
googleCredentials:
  gkeEnvironment: {{ $gkeEnv }}
  applicationCredentials:
    name: {{ $secretName }}
    key: APPLICATION_CREDENTIALS
{{- end -}}
