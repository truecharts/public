{{- define "tc.v1.common.lib.cnpg.cluster.barmanObjectStoreConfig.google" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $type := .type -}}
  {{- $data := .data -}}

  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $rootCtx -}}
  {{- $secretName := (printf "%s-cnpg-%s-provider-%s-google-creds" $fullname $objectData.shortName $type) -}}

  {{- $gkeEnv := false -}}
  {{- if (kindIs "bool" $data.gkeEnvionment) -}}
    {{- $gkeEnv = $data.gkeEnvionment -}}
  {{- end -}}

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
      {{- fail (printf "CNPG %s - You need to specify [%s.google.bucket] or [%s.destinationPath]" ($type | camelcase) $key $key) -}}
    {{- end -}}
    {{- if $data.path -}}
    {{- $destinationPath = (printf "gs://%s/%s/%s/cnpg" $data.bucket ($data.path | trimSuffix "/") $rootCtx.Release.Name) -}}
    {{- else -}}
    {{- $destinationPath = (printf "gs://%s/%s/cnpg" $data.bucket  $rootCtx.Release.Name) -}}
    {{- end -}}
  {{- end }}
endpointURL: {{ $endpointURL }}
destinationPath: {{ $destinationPath }}
serverName: {{ $serverName }}
googleCredentials:
  gkeEnvironment: {{ $gkeEnv }}
  applicationCredentials:
    name: {{ $secretName }}
    key: APPLICATION_CREDENTIALS
{{- end -}}
