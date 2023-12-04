{{/* Renders the cnpg objects required by the chart */}}
{{- define "tc.v1.common.spawner.cnpg" -}}

  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}

  {{- range $name, $cnpg := $.Values.cnpg -}}

    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $cnpg
                    "name" $name "caller" "CNPG"
                    "key" "cnpg")) -}}

    {{/* Create a copy */}}
    {{- $objectData := mustDeepCopy $cnpg -}}
    {{- $objectName := printf "%s-cnpg-%s" $fullname $name -}}

    {{/* Set the name */}}
    {{- $_ := set $objectData "name" $objectName -}}
    {{/* Short name is the one that defined on the chart*/}}
    {{- $_ := set $objectData "shortName" $name -}}
    {{/* Set the cluster name */}}
    {{- $_ := set $objectData "clusterName" (include "tc.v1.common.lib.cnpg.clusterName" (dict "objectData" $objectData)) -}}

    {{/* Handle recovery string */}}
    {{- $recoveryValue := "" -}}
    {{- $recoveryKey := "recovery-string" -}}
    {{- $recoveryConfigMapName := printf "cnpg-%s-%s" $objectData.shortName $recoveryKey -}}

    {{/* If there are previous configmap, fetch value */}}
    {{- with (lookup "v1" "ConfigMap" $.Release.Namespace $recoveryConfigMapName) -}}
      {{- $recoveryValue = (index .data $recoveryKey) -}}
    {{- end -}}

    {{/* If forced recovery is requested... */}}
    {{- if $objectData.forceRecovery -}}
      {{- $recoveryValue = randAlphaNum 5 -}}
    {{- end -}}

    {{/* Recreate the configmap if there is a recovery value */}}
    {{- if $recoveryValue -}}
      {{- $_ := set $objectData "recoveryValue" $recoveryValue -}}
      {{- $recConfig := include "tc.v1.common.lib.cnpg.configmap.recoverystring" (dict "recoveryString" $recoveryValue "recoveryKey" $recoveryKey) | fromYaml -}}
      {{- $_ := set $.Values.configmap $recoveryConfigMapName $recConfig -}}
    {{- end -}}

    {{- if eq $enabled "true" -}}

      {{/* Handle Backups/ScheduledBackups */}}
      {{- if and (hasKey $objectData "backups") $objectData.backups.enabled -}}

        {{/* Create Backups */}}
        {{- include "tc.v1.common.lib.cnpg.spawner.backups" (dict "rootCtx" $ "objectData" $objectData) -}}

        {{/* Create ScheduledBackups */}}
        {{- include "tc.v1.common.lib.cnpg.spawner.scheduledBackups" (dict "rootCtx" $ "objectData" $objectData) -}}

        {{/* Create secret for backup store */}}
        {{- include "tc.v1.common.lib.cnpg.provider.secret.spawner" (dict "rootCtx" $ "objectData" $objectData "type" "backup") -}}
      {{- end -}}

      {{/* Handle Pooler(s) */}}
      {{- include "tc.v1.common.lib.cnpg.spawner.pooler" (dict "rootCtx" $ "objectData" $objectData) -}}

      {{/* Handle Cluster */}}
      {{/* Validate Cluster */}}
      {{- include "tc.v1.common.lib.cnpg.cluster.validation" (dict "objectData" $objectData) -}}

      {{- if and (eq $objectData.mode "recovery") (eq $objectData.recovery.method "object_store") -}}
        {{/* Create secret for recovery store */}}
        {{- include "tc.v1.common.lib.cnpg.provider.secret.spawner" (dict "rootCtx" $ "objectData" $objectData "type" "recovery") -}}
      {{- end -}}

      {{/* Create the Cluster object */}}
      {{- include "tc.v1.common.class.cnpg.cluster" (dict "rootCtx" $ "objectData" $objectData) -}}

      {{/* TODO: Create configmaps for cluster.monitoring.customQueries */}}
    {{- end -}}

    {{/* Fetch db pass from Secret */}}
    {{- $dbPass := "" -}}
    {{- with (lookup "v1" "Secret" $.Release.Namespace (printf "%s-user" $objectData.name)) -}}
      {{- $dbPass = (index .data "password") | b64dec -}}
    {{- end -}}

    {{/* Either enebled or if there was a dbpass fetched. Required to keep the generated password around */}}
    {{- if or (eq $enabled "true") $dbPass -}}
      {{/* If enabled or dbPass fetched from secret, recreate the secret */}}
      {{- if not $dbPass -}}
        {{/* Use provided password or fallback to generating new password */}}
        {{- $dbPass = $objectData.password | default (randAlphaNum 62) -}}
      {{- end -}}
      {{/* Set password back to password field */}}
      {{- $_ := set $objectData "password" $dbPass -}}

      {{/* Handle DB Credentials Secret, will also inject creds to cnpg.creds */}}
      {{- include "tc.v1.common.lib.cnpg.db.credentials.secrets" (dict "rootCtx" $ "cnpg" $cnpg "objectData" $objectData) -}}
    {{- end -}}

  {{- end -}}
{{- end -}}
