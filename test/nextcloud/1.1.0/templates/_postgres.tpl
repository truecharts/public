{{/*
Get Nextloud Postgres Database Name
*/}}
{{- define "postgres.DatabaseName" -}}
{{- print "nextcloud" -}}
{{- end -}}


{{- define "postgres.imageName" -}}
{{- print "postgres:13.1" -}}
{{- end -}}


{{/*
Retrieve postgres backup name
This will return a unique name based on revision and chart numbers specified.
*/}}
{{- define "postgres.backupName" -}}
{{- $upgradeDict := .Values.ixChartContext.upgradeMetadata -}}
{{- printf "postgres-backup-from-%s-to-%s-revision-%d" $upgradeDict.oldChartVersion $upgradeDict.newChartVersion (int64 $upgradeDict.preUpgradeRevision) -}}
{{- end }}


{{/*
Retrieve postgres credentials for environment variables configuration
*/}}
{{- define "postgres.envVariableConfiguration" -}}
{{ $envList := list }}
{{ $envList = mustAppend $envList (dict "name" "POSTGRES_USER" "valueFromSecret" true "secretName" "db-details" "secretKey" "db-user") }}
{{ $envList = mustAppend $envList (dict "name" "POSTGRES_PASSWORD" "valueFromSecret" true "secretName" "db-details" "secretKey" "db-password") }}
{{ include "common.containers.environmentVariables" (dict "environmentVariables" $envList) }}
{{- end -}}


{{/*
Retrieve postgres volume configuration
*/}}
{{- define "postgres.volumeConfiguration" -}}
{{ $vols := list }}
{{ $vols = mustAppend $vols (dict "name" "postgres-data" "emptyDirVolumes" .Values.emptyDirVolumes "hostPathEnabled" false "pathField" nil "datasetName" (.Values.postgresDataVolume | default dict).datasetName ) }}
{{ $vols = mustAppend $vols (dict "name" "postgres-backup" "emptyDirVolumes" .Values.emptyDirVolumes "hostPathEnabled" false "pathField" nil "datasetName" (.Values.postgresBackupVolume | default dict).datasetName ) }}
{{ include "common.storage.volumesConfiguration" (dict "ixVolumes" .Values.ixVolumes "volumes" $vols) }}
{{- end -}}
