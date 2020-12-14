{{/*
Retrieve previous chart version from which we are upgrading to a newer chart version
*/}}
{{- define "tn.chart.old_version" -}}
{{- if .Values.ixChartContext.is_upgrade -}}
{{- .Values.ixChartContext.upgradeMetadata.oldChartVersion -}}
{{- else -}}
{{- fail "A chart upgrade is not taking place" -}}
{{- end -}}
{{- end -}}

{{/*
Retrieve new chart version to which we are upgrading from an old chart version
*/}}
{{- define "tn.chart.new_version" -}}
{{- if .Values.ixChartContext.is_upgrade -}}
{{- .Values.ixChartContext.upgradeMetadata.newChartVersion -}}
{{- else -}}
{{- fail "A chart upgrade is not taking place" -}}
{{- end -}}
{{- end -}}
