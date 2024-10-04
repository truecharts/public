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
    {{- $_ := set $objectData "clusterName" $objectData.name -}}

    {{- if eq $enabled "true" -}}

      {{/* Handle version string */}}
      {{- $pgVersion := ($objectData.pgVersion | default $.Values.global.fallbackDefaults.pgVersion) | toString -}}

      {{/* Set the updated pgVersion version to objectData */}}
      {{- $_ := set $objectData "pgVersion" $pgVersion -}}

      {{/* allow for injecting major upgrade code */}}
      {{- if $objectData.upgradeMajor -}}
        {{/* TODO: actually handle postgres version updates here */}}
      {{- end -}}

      {{- include "tc.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

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
      {{- if and $objectData.pooler $objectData.pooler.enabled -}}
        {{- include "tc.v1.common.lib.cnpg.spawner.pooler" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{- end -}}

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

    {{/* Handle DB Credentials Secret, will also inject creds to cnpg.creds */}}
    {{- include "tc.v1.common.lib.cnpg.db.credentials.secrets" (dict "rootCtx" $ "cnpg" $cnpg "objectData" $objectData) -}}
    {{- end -}}

  {{- end -}}
{{- end -}}
