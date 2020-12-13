{{/*
Get Nextloud Postgres Database Name
*/}}
{{- define "postgres.DatabaseName" -}}
{{- print "nextcloud" -}}
{{- end -}}

{{/*
Postgres Selector labels
*/}}
{{- define "nextcloud.postgres.selectorLabels" -}}
app.kubernetes.io/name: {{ include "nextcloud.name" . }}-postgres
app.kubernetes.io/instance: {{ .Release.Name }}-postgres
{{- end }}

{{/*
Retrieve postgres backup name
This will return a unique name based on revision and chart numbers specified.
*/}}
{{- define "postgres.backupName" -}}
{{- $upgradeDict := .Values.ixChartContext.upgradeMetadata -}}
{{- printf "postgres-backup-from-%s-to-%s-revision-%d" $upgradeDict.oldChartVersion $upgradeDict.newChartVersion (int64 $upgradeDict.preUpgradeRevision) -}}
{{- end }}

