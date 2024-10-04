{{- define "tc.v1.common.class.cnpg.pooler" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{/* Naming */}}
  {{- $poolerName := printf "%s-pooler-%s" $objectData.name $objectData.pooler.type -}}
  {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $poolerName "length" 253) -}}
  {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "CNPG Pooler") -}}

  {{/* Metadata */}}
  {{- $objLabels := $objectData.labels | default dict -}}
  {{- $poolerLabels := $objectData.pooler.labels | default dict -}}
  {{- $poolerLabels = mustMerge $poolerLabels $objLabels -}}

  {{- $objAnnotations := $objectData.annotations | default dict -}}
  {{- $poolerAnnotations := $objectData.pooler.annotations | default dict -}}
  {{- $poolerAnnotations = mustMerge $poolerAnnotations $objAnnotations -}}

  {{- $instances := $objectData.pooler.instances | default 2 -}}
  {{/* Stop All */}}
  {{- if or $objectData.hibernate (include "tc.v1.common.lib.util.stopAll" $rootCtx) -}}
    {{- $instances = 0 -}}
  {{- end }}

---
apiVersion: postgresql.cnpg.io/v1
kind: Pooler
metadata:
  name: {{ $poolerName }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "CNPG Pooler") }}
  labels:
    cnpg.io/reload: "on"
  {{- $labels := (mustMerge $poolerLabels (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
    {{- . | nindent 4 }}
  {{- end }}
  annotations:
    checksum/secrets: {{ toJson $rootCtx.Values.secret | sha256sum }}
  {{- $annotations := (mustMerge $poolerAnnotations (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
    {{- . | nindent 4 }}
  {{- end }}
spec:
  cluster:
    name: {{ $objectData.clusterName }}
  instances: {{ $instances }}
  type: {{ $objectData.pooler.type }}
  pgbouncer:
    poolMode: {{ $objectData.pooler.poolMode | default "session" }}
    {{/* https://cloudnative-pg.io/documentation/1.15/connection_pooling/#pgbouncer-configuration-options */}}
    {{- with $objectData.pooler.parameters }}
    parameters:
      {{- range $key, $value := . }}
      {{ $key }}: {{ tpl $value $rootCtx | quote }}
      {{- end -}}
    {{- end -}}
{{- end -}}
