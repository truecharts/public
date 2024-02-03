{{/* Define the configmap */}}
{{- define "palworld.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $adminPassword := .Values.palworld.game.admin_password -}}
{{- $rconPort := .Values.service.rcon.ports.rcon.port }}
{{- $mainPort := .Values.service.main.ports.main.port }}
{{- $palworldGame := .Values.palworld.game }}

palworld-ini:
  enabled: true
  data:
    PalWorldSettings.ini: |
     [/Script/Pal.PalGameWorldSettings]
     OptionSettings=(
     Difficulty={{ $palworldGame.difficulty }},
     DayTimeSpeedRate={{ $palworldGame.day_time_speed_rate }},
     NightTimeSpeedRate={{ $palworldGame.night_time_speed_rate }},
     ExpRate={{ $palworldGame.exp_rate }},
     PalCaptureRate={{ $palworldGame.pal_capture_rate }},
     PalSpawnNumRate={{ $palworldGame.pal_spawn_num_rate }},
     PalDamageRateAttack={{ $palworldGame.pal_damage_rate_attack }},
     PalDamageRateDefense={{ $palworldGame.pal_damage_rate_defense }},
     PlayerDamageRateAttack={{ $palworldGame.player_damage_rate_attack }},
     PlayerDamageRateDefense={{ $palworldGame.player_damage_rate_defense }},
     PlayerStomachDecreaceRate={{ $palworldGame.player_stomach_decreace_rate }},
     PlayerStaminaDecreaceRate={{ $palworldGame.player_stamina_decreace_rate }},
     PlayerAutoHPRegeneRate={{ $palworldGame.player_auto_hp_regene_rate }},
     PlayerAutoHpRegeneRateInSleep={{ $palworldGame.player_auto_hp_regene_rate_in_sleep }},
     PalStomachDecreaceRate={{ $palworldGame.pal_stomach_decreace_rate }},
     PalStaminaDecreaceRate={{ $palworldGame.pal_stamina_decreace_rate }},
     PalAutoHPRegeneRate={{ $palworldGame.pal_auto_hp_regene_rate }},
     PalAutoHpRegeneRateInSleep={{ $palworldGame.pal_auto_hp_regene_rate_in_sleep }},
     BuildObjectDamageRate={{ $palworldGame.build_object_damage_rate }},
     BuildObjectDeteriorationDamageRate={{ $palworldGame.build_object_deterioration_damage_rate }},
     CollectionDropRate={{ $palworldGame.collection_drop_rate }},
     CollectionObjectHpRate={{ $palworldGame.collection_object_hp_rate }},
     CollectionObjectRespawnSpeedRate={{ $palworldGame.collection_object_respawn_speed_rate }},
     EnemyDropItemRate={{ $palworldGame.enemy_drop_item_rate }},
     DeathPenalty={{ $palworldGame.death_penalty }},
     bEnablePlayerToPlayerDamage={{ $palworldGame.enable_pvp_damage }},
     bEnableFriendlyFire={{ $palworldGame.enable_friendly_fire }},
     bEnableInvaderEnemy={{ $palworldGame.enable_invader_enemy }},
     bActiveUNKO={{ $palworldGame.active_unko }},
     bEnableAimAssistPad={{ $palworldGame.enable_aim_assist_pad }},
     bEnableAimAssistKeyboard={{ $palworldGame.enable_aim_assist_kb }},
     DropItemMaxNum={{ $palworldGame.drop_item_max }},
     DropItemMaxNum_UNKO={{ $palworldGame.drop_item_max_unko }},
     BaseCampMaxNum={{ $palworldGame.base_camp_max }},
     BaseCampWorkerMaxNum={{ $palworldGame.base_camp_worker_max }},
     DropItemAliveMaxHours={{ $palworldGame.drop_item_alive_max_hours }},
     bAutoResetGuildNoOnlinePlayers={{ $palworldGame.guild_auto_reset_no_online_players }},
     AutoResetGuildTimeNoOnlinePlayers={{ $palworldGame.auto_reset_guild_time_no_online_players }},
     GuildPlayerMaxNum={{ $palworldGame.max_players_guild }},
     PalEggDefaultHatchingTime={{ $palworldGame.pal_egg_default_hatching_time }},
     WorkSpeedRate={{ $palworldGame.work_speed_rate }},
     bIsMultiplay={{ $palworldGame.is_multiplay }},
     bIsPvP={{ $palworldGame.is_pvp }},
     bCanPickupOtherGuildDeathPenaltyDrop={{ $palworldGame.can_pickup_other_guild_death_penalty_drop }},
     bEnableNonLoginPenalty={{ $palworldGame.enable_non_login_penalty }},
     bEnableFastTravel={{ $palworldGame.enable_fast_travel }},
     bIsStartLocationSelectByMap={{ $palworldGame.is_start_location_select_by_map }},
     bExistPlayerAfterLogout={{ $palworldGame.exist_players_after_logout }},
     bEnableDefenseOtherGuildPlayer={{ $palworldGame.enable_defense_other_guild_player }},
     CoopPlayerMaxNum={{ $palworldGame.max_players_coop }},
     ServerPlayerMaxNum={{ $palworldGame.max_players }},
     ServerName={{ $palworldGame.name }},
     ServerDescription={{ $palworldGame.description }},
     AdminPassword={{ $palworldGame.admin_password }},
     ServerPassword={{ $palworldGame.password }},
     PublicPort={{ $mainPort }},
     PublicIP={{ $palworldGame.public_ip }},
     RCONEnabled="True",
     RCONPort={{ $rconPort }},
     Region={{ $palworldGame.region }},
     bUseAuth={{ $palworldGame.use_auth }},
     BanListURL={{ $palworldGame.ban_list_url }}
     )

palworld-rcon:
  enabled: true
  data:
    rcon.yaml: |
     default:
       address: "{{ printf "%v-rcon:%v" $fullname $rconPort }}"
       password: {{ $adminPassword }}
       log: "rcon-palworld.log"
       timeout: "10s"
{{- end -}}
