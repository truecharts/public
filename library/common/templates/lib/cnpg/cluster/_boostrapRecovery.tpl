{{/* Recovery Template, called when mode is recovery */}}
{{- define "tc.v1.common.lib.cnpg.cluster.bootstrap.recovery" }}
  {{- $objectData := .objectData }}
recovery:
  secret:
    name: {{ printf "%s-user" $objectData.clusterName }}
  database: {{ $objectData.database }}
  owner: {{ $objectData.user }}
  {{- if eq $objectData.recovery.method "backup" }}
  backup:
    name: {{ $objectData.recovery.backupName }}
  {{- else if eq $objectData.recovery.method "object_store" -}}
    {{- $serverName := $objectData.recovery.serverName | default $objectData.clusterName -}}
    {{- if $objectData.recovery.revision -}}
      {{- $serverName = printf "%s-r%s" $serverName $objectData.recovery.revision -}}
    {{- end }}
  source: {{ $serverName }}
  {{- end -}}
  {{- if $objectData.recovery.pitrTarget -}}
    {{- with $objectData.recovery.pitrTarget.time }}
  recoveryTarget:
    targetTime: {{ . | quote }}
    {{- end -}}
  {{- end -}}
{{- end -}}
