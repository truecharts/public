{{/* RBAC Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.rbac" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData:
  name: The name of the rbac.
  labels: The labels of the rbac.
  annotations: The annotations of the rbac.
  clusterWide: Whether the rbac is cluster wide or not.
  rules: The rules of the rbac.
  subjects: The subjects of the rbac.
*/}}

{{- define "tc.v1.common.class.rbac" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData }}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: {{ ternary "ClusterRole" "Role" $objectData.clusterWide }}
metadata:
  name: {{ $objectData.name }}
  {{- if not $objectData.clusterWide }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "RBAC") }}
  {{- end }}
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
rules:
  {{- include "tc.v1.common.lib.rbac.rules" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 2 }}
---
apiVersion: rbac.authorization.k8s.io/v1
kind: {{ ternary "ClusterRoleBinding" "RoleBinding" $objectData.clusterWide }}
metadata:
  name: {{ $objectData.name }}
  {{- if not $objectData.clusterWide }}
  namespace: {{ $rootCtx.Release.Namespace }}
  {{- end }}
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
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: {{ ternary "ClusterRole" "Role" $objectData.clusterWide }}
  name: {{ $objectData.name }}
subjects:
  {{- include "tc.v1.common.lib.rbac.serviceAccount" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 2 }}
  {{- include "tc.v1.common.lib.rbac.subjects" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 2 }}
{{- end -}}
