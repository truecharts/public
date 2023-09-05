{{/* Define the configmap */}}
{{- define "sonsoftheforest.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $server := .Values.sonsoftheforest.server -}}

sonsoftheforest-dscfg:
  enabled: true
  data:
    dedicatedserver.cfg: |
      {
        "IpAddress": "0.0.0.0",
        "GamePort": "{{ .Values.service.main.ports.main.port }}",
        "QueryPort": "{{ .Values.service.query.ports.query.port }}",
        "BlobSyncPort": "{{ .Values.service.sync.ports.sync.port }}",
        "ServerName": "{{ $server.ServerName }}",
        "MaxPlayers": "{{ $server.MaxPlayers }}",
        "Password": "{{ $server.Password }}",
        "LanOnly": "{{ $server.LanOnly }}",
        "SaveSlot": "{{ $server.SaveSlot }}",
        "SaveMode": "{{ $server.SaveMode }}",
        "GameMode": "{{ $server.GameMode }}",
        "SaveInterval": "{{ $server.SaveInterval }}",
        "IdleDayCycleSpeed": "{{ $server.IdleDayCycleSpeed }}",
        "IdleTargetFramerate": "{{ $server.IdleTargetFramerate }}",
        "ActiveTargetFramerate": "{{ $server.ActiveTargetFramerate }}",
        "LogFilesEnabled": "{{ $server.LogFilesEnabled }}",
        "TimestampLogFilenames": "{{ $server.TimestampLogFilenames }}",
        "TimestampLogEntries": "{{ $server.TimestampLogEntries }}",
        "SkipNetworkAccessibilityTest": "{{ $server.SkipNetworkAccessibilityTest }}",
        "GameSettings": {
          "Gameplay.TreeRegrowth": "{{ $server.GameSettings.TreeRegrowth }}",
          "Structure.Damage": "{{ $server.GameSettings.StructureDamage }}"
          },
        "CustomGameModeSettings": {
          "GameSetting.Multiplayer.Cheats": "{{ $server.CustomGameModeSettings.Cheats }}",
          "GameSetting.Vail.EnemySpawn": "{{ $server.CustomGameModeSettings.EnemySpawn }}",
          "GameSetting.Vail.EnemyHealth": "{{ $server.CustomGameModeSettings.EnemyHealth }}",
          "GameSetting.Vail.EnemyDamage": "{{ $server.CustomGameModeSettings.EnemyDamage }}",
          "GameSetting.Vail.EnemyArmour": "{{ $server.CustomGameModeSettings.EnemyArmour }}",
          "GameSetting.Vail.EnemyAggression": "{{ $server.CustomGameModeSettings.EnemyAggression }}",
          "GameSetting.Vail.AnimalSpawnRate": "{{ $server.CustomGameModeSettings.AnimalSpawnRate }}",
          "GameSetting.Environment.StartingSeason": "{{ $server.CustomGameModeSettings.StartingSeason }}",
          "GameSetting.Environment.SeasonLength": "{{ $server.CustomGameModeSettings.SeasonLength }}",
          "GameSetting.Environment.DayLength": "{{ $server.CustomGameModeSettings.DayLength }}",
          "GameSetting.Environment.PrecipitationFrequency": "{{ $server.CustomGameModeSettings.PrecipitationFrequency }}",
          "GameSetting.Survival.ConsumableEffects": "{{ $server.CustomGameModeSettings.ConsumableEffects }}",
          "GameSetting.Survival.PlayerStatsDamage": "{{ $server.CustomGameModeSettings.PlayerStatsDamage }}",
          "GameSetting.Survival.ColdPenalties": "{{ $server.CustomGameModeSettings.ColdPenalties }}",
          "GameSetting.Survival.ReducedFoodInContainers": "{{ $server.CustomGameModeSettings.ReducedFoodInContainers }}",
          "GameSetting.Survival.SingleUseContainers": "{{ $server.CustomGameModeSettings.SingleUseContainers }}"
        }
      }

{{- end -}}
