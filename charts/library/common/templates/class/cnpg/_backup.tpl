{{- define "tc.v1.common.class.cnpg.backup" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{/* Naming */}}
  {{- $backupName := printf "%v-backup-%v" $objectData.name $objectData.backupName -}}
  {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $backupName "length" 253) -}}
  {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "CNPG Backup") -}}

  {{/* Metadata */}}
  {{- $objLabels := $objectData.labels | default dict -}}
  {{- $globalBackupLabels := $objectData.backups.labels | default dict -}}
  {{- $backupLabels := $objectData.backupLabels | default dict -}}
  {{- $backupLabels = mustMerge $backupLabels $objLabels $globalBackupLabels -}}

  {{- $objAnnotations := $objectData.annotations | default dict -}}
  {{- $globalBackupAnnotations := $objectData.backups.annotations | default dict -}}
  {{- $backupAnnotations := $objectData.backupAnnotations | default dict -}}
  {{- $backupAnnotations = mustMerge $backupAnnotations $objAnnotations $globalBackupAnnotations }}

---
apiVersion: postgresql.cnpg.io/v1
kind: Backup
metadata:
  name: {{ $backupName }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "CNPG Backup") }}
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
  cluster:
    name: {{ $objectData.clusterName }}
{{- end -}}
