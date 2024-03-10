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
      {{- $pgVersion := $objectData.pgVersion | default $.Values.global.fallbackDefaults.pgVersion -}}
      {{- $versionConfigMapName := printf "cnpg-%s-pgversion" $objectData.shortName -}}

      {{/* If there are previous configmap, fetch value */}}
      {{- with (lookup "v1" "ConfigMap" $.Release.Namespace (printf "%s-%s" $fullname $versionConfigMapName)) -}}
        {{/* If a different version is set and upgrade is enabled, upgrade */}}
        {{- if and (ne $pgVersion .data.version) $objectData.upgradeMajor -}}
          {{/* TODO: actually handle postgres version updates here */}}
        {{- else -}}
          {{- $pgVersion = .data.version -}}
        {{- end -}}
      {{- end -}}

      {{/* Set the updated pgVersion version to objectData */}}
      {{- $_ := set $objectData "pgVersion" ($pgVersion | toString) -}}

      {{/* Ensure configmap with pgVersion is updated */}}
      {{- $verConfig := include "tc.v1.common.lib.cnpg.configmap.pgVersion" (dict "version" $pgVersion) | fromYaml -}}
      {{- $_ := set $.Values.configmap $versionConfigMapName $verConfig -}}

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
