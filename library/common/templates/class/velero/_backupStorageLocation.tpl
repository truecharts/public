{{/* backupstoragelocation Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.velero.backupstoragelocation" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData:
  name: The name of the backupstoragelocation.
  labels: The labels of the backupstoragelocation.
  annotations: The annotations of the backupstoragelocation.
  namespace: The namespace of the backupstoragelocation. (Optional)
*/}}

{{- define "tc.v1.common.class.velero.backupstoragelocation" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData }}

---
apiVersion: velero.io/v1
kind: BackupStorageLocation
metadata:
  name: {{ $objectData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "backupstoragelocation") }}
  {{- $labels := (mustMerge ($objectData.labels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($objectData.annotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  provider: {{ $objectData.provider }}
  {{- with $objectData.credential }}
  credential:
    name: {{ .name }}
    key: {{ .key }}
  {{- end -}}
  {{- with $objectData.config }}
  config:
    {{- range $k, $v := . }}
      {{- if and (not (kindIs "invalid" $v)) (ne (toString $v) "") }}
    {{ $k }}: {{ tpl (toString $v) $rootCtx | quote }}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- with $objectData.backupSyncPeriod }}
  backupSyncPeriod: {{ . }}
  {{- end -}}
  {{- with $objectData.validationFrequency }}
  validationFrequency: {{ . }}
  {{- end }}
  accessMode: {{ $objectData.accessMode | default "ReadWrite" }}
  objectStorage:
    bucket: {{ $objectData.objectStorage.bucket | quote }}
    {{- with $objectData.objectStorage.prefix }}
    prefix: {{ . | quote }}
    {{- end -}}
    {{- with $objectData.objectStorage.caCert }}
    caCert: {{ . }}
    {{- end -}}
{{- end -}}
