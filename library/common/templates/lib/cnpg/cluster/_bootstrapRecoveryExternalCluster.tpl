{{/* Recovery from externalClusters Template, called when mode is recovery */}}
{{- define "tc.v1.common.lib.cnpg.cluster.bootstrap.recovery.externalCluster" }}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- if eq $objectData.recovery.method "object_store" }}
externalClusters:
    {{- $serverName := $objectData.recovery.serverName | default $objectData.clusterName -}}
    {{- if $objectData.recovery.revision -}}
      {{- $serverName = printf "%s-r%s" $serverName $objectData.recovery.revision -}}
    {{- end }}
  - name: {{ $serverName }}
    barmanObjectStore:

    {{/* Fetch provider data */}}
    {{/* Get the creds defined in backup.$provider */}}
    {{- $creds := (get $rootCtx.Values.credentials $objectData.recovery.credentials) -}}
    {{ $provider := $creds.type -}}
    {{- include (printf "tc.v1.common.lib.cnpg.cluster.barmanObjectStoreConfig.%s" $provider) (dict "rootCtx" $rootCtx "objectData" $objectData "data" $creds "type" "recovery") | nindent 6 -}}
    {{- end -}}
{{- end -}}
