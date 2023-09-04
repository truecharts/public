{{/* Define the configmap */}}
{{- define "sonsoftheforest.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $stf := .Values.sonsoftheforest -}}

sonsoftheforest-config:
  enabled: true
  data:
    dedicatedserver.cfg: |
      {
        "IpAddress": "0.0.0.0",
        "GamePort": "{{ .Values.service.main.ports.main.port }}",
        "QueryPort": "{{ .Values.service.query.ports.query.port }}",
        "BlobSyncPort": "{{ .Values.service.sync.ports.sync.port }}",
        "ServerName": "{{ $stf.ServerName }}",
        "MaxPlayers": "{{ $stf.MaxPlayers }}",
        "Password": "{{ $stf.Password }}",
        "LanOnly": "{{ $stf.LanOnly }}",
        "SaveSlot": "{{ $stf.SaveSlot }}",
        "SaveMode": "{{ $stf.SaveMode }}",
        "GameMode": "{{ $stf.GameMode }}",
        "SaveInterval": "{{ $stf.SaveInterval }}",
        "IdleDayCycleSpeed": "{{ $stf.IdleDayCycleSpeed }}",
        "IdleTargetFramerate": "{{ $stf.IdleTargetFramerate }}",
        "ActiveTargetFramerate": "{{ $stf.ActiveTargetFramerate }}",
        "LogFilesEnabled": "{{ $stf.LogFilesEnabled }}",
        "TimestampLogFilenames": "{{ $stf.TimestampLogFilenames }}",
        "TimestampLogEntries": "{{ $stf.TimestampLogEntries }}",
        "GameSettings": {},
        "CustomGameModeSettings": {}
      }

{{- end -}}
