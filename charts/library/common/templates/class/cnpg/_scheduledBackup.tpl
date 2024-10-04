{{- define "tc.v1.common.class.cnpg.scheduledbackup" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{/* Naming */}}
  {{- $backupName := printf "%v-sched-backup-%v" $objectData.name $objectData.backupName -}}
  {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $backupName "length" 253) -}}
  {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "CNPG Scheduled Backup") -}}

  {{/* Metadata */}}
  {{- $objLabels := $objectData.labels | default dict -}}
  {{- $globalBackupLabels := $objectData.backups.labels | default dict -}}
  {{- $backupLabels := $objectData.backupLabels | default dict -}}
  {{- $backupLabels = mustMerge $backupLabels $objLabels $globalBackupLabels -}}

  {{- $objAnnotations := $objectData.annotations | default dict -}}
  {{- $globalBackupAnnotations := $objectData.backups.annotations | default dict -}}
  {{- $backupAnnotations := $objectData.backupAnnotations | default dict -}}
  {{- $backupAnnotations = mustMerge $backupAnnotations $objAnnotations $globalBackupAnnotations -}}

  {{/* Data */}}
  {{- $suspend := false -}}
  {{- if (hasKey $objectData.schedData "suspend") -}}
    {{- $suspend = $objectData.schedData.suspend -}}
  {{- end -}}
  {{- if or $objectData.hibernate (include "tc.v1.common.lib.util.stopAll" $rootCtx) -}}
    {{- $suspend = true -}}
  {{- end -}}
  {{- $immediate := false -}}
  {{- if (hasKey $objectData.schedData "immediate") -}}
    {{- $immediate = $objectData.schedData.immediate -}}
  {{- end }}

---
apiVersion: postgresql.cnpg.io/v1
kind: ScheduledBackup
metadata:
  name: {{ $backupName }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "CNPG Scheduled Backup") }}
  labels:
    cnpg.io/cluster: {{ $objectData.clusterName }}
  {{- $labels := (mustMerge $backupLabels (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge $backupAnnotations (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  schedule: {{ $objectData.schedData.schedule }}
  backupOwnerReference: {{ $objectData.schedData.backupOwnerReference | default "none" }}
  suspend: {{ $suspend }}
  immediate: {{ $immediate }}
  cluster:
    name: {{ $objectData.clusterName }}
{{- end -}}
