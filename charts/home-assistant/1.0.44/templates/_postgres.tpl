{{/*
Get Home assistance Postgres Database Name
*/}}
{{- define "postgres.DatabaseName" -}}
{{- print "homeassistance" -}}
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
{{ include "common.storage.configureAppVolumes" (dict "appVolumeMounts" .Values.postgresAppVolumeMounts "emptyDirVolumes" .Values.emptyDirVolumes "ixVolumes" .Values.ixVolumes) | nindent 0 }}
{{- end -}}


{{/*
Retrieve postgres volume mounts configuration
*/}}
{{- define "postgres.volumeMountsConfiguration" -}}
{{ include "common.storage.configureAppVolumeMountsInContainer" (dict "appVolumeMounts" .Values.postgresAppVolumeMounts ) | nindent 0 }}
{{- end -}}

