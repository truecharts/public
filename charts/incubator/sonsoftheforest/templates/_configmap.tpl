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
        "SkipNetworkAccessibilityTest": "{{ $stf.SkipNetworkAccessibilityTest }}",
        "GameSettings": {
          "Gameplay.TreeRegrowth": "{{ $stf.GameSettings.TreeRegrowth }}",
          "Structure.Damage": "{{ $stf.GameSettings.StructureDamage }}"
          },
        "CustomGameModeSettings": {
          "GameSetting.Multiplayer.Cheats": "{{ $stf.CustomGameModeSettings.Cheats }}",
          "GameSetting.Vail.EnemySpawn": "{{ $stf.CustomGameModeSettings.EnemySpawn }}",
          "GameSetting.Vail.EnemyHealth": "{{ $stf.CustomGameModeSettings.EnemyHealth }}",
          "GameSetting.Vail.EnemyDamage": "{{ $stf.CustomGameModeSettings.EnemyDamage }}",
          "GameSetting.Vail.EnemyArmour": "{{ $stf.CustomGameModeSettings.EnemyArmour }}",
          "GameSetting.Vail.EnemyAggression": "{{ $stf.CustomGameModeSettings.EnemyAggression }}",
          "GameSetting.Vail.AnimalSpawnRate": "{{ $stf.CustomGameModeSettings.AnimalSpawnRate }}",
          "GameSetting.Environment.StartingSeason": "{{ $stf.CustomGameModeSettings.StartingSeason }}",
          "GameSetting.Environment.SeasonLength": ""{{ $stf.CustomGameModeSettings.SeasonLength }}",
          "GameSetting.Environment.DayLength": "{{ $stf.CustomGameModeSettings.DayLength }}",
          "GameSetting.Environment.PrecipitationFrequency": "{{ $stf.CustomGameModeSettings.PrecipitationFrequency }}",
          "GameSetting.Survival.ConsumableEffects": "{{ $stf.CustomGameModeSettings.ConsumableEffects }}",
          "GameSetting.Survival.PlayerStatsDamage": "{{ $stf.CustomGameModeSettings.PlayerStatsDamage }}",
          "GameSetting.Survival.ColdPenalties": "{{ $stf.CustomGameModeSettings.ColdPenalties }}",
          "GameSetting.Survival.ReducedFoodInContainers": "{{ $stf.CustomGameModeSettings.ReducedFoodInContainers }}",
          "GameSetting.Survival.SingleUseContainers": "{{ $stf.CustomGameModeSettings.SingleUseContainers }}"
        }
      }

{{- end -}}
