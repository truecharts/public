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

  {{- $endpointURL := "" -}}
  {{- $destinationPath := "" -}}
  {{- $k := "" -}}
  {{- if eq $type "recovery" -}}
    {{- $endpointURL = $objectData.recovery.endpointURL -}}
    {{- $destinationPath = $objectData.recovery.destinationPath -}}
    {{- $k = "recovery" -}}
  {{- else if eq $type "backup" -}}
    {{- $endpointURL = $objectData.backups.endpointURL -}}
    {{- $destinationPath = $objectData.backups.destinationPath -}}
    {{- $k = "backups" -}}
  {{- end -}}
  {{- if not $destinationPath -}}
    {{- if not $data.bucket -}}
      {{- fail (printf "CNPG %s - You need to specify [%s.google.bucket] or [%s.destinationPath]" ($type | camelcase) $k $k) -}}
    {{- end -}}
    {{- $destinationPath = (printf "gs://%s/%s" $data.bucket (($data.path | default "/") | trimSuffix "/")) -}}
  {{- end }}
endpointURL: {{ $endpointURL }}
destinationPath: {{ $destinationPath }}
googleCredentials:
  gkeEnvironment: {{ $gkeEnv }}
  applicationCredentials:
    name: {{ $secretName }}
    key: APPLICATION_CREDENTIALS
{{- end -}}
