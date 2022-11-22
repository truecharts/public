{{/* Template for RBAC object ((Cluster)Role, (Cluster)RoleBinding), can only be called by the spawner */}}
{{/* An rbac object, an SA object and "root" is passed from the spawner */}}
{{- define "ix.v1.common.class.rbac" -}}
  {{- $rbacValues := .rbac -}}
  {{- $saValues := .serviceAccount -}}
  {{- $root := .root -}}

  {{- $saName := include "ix.v1.common.names.fullname" $root -}}
  {{- $rbacName := include "ix.v1.common.names.fullname" $root -}}

  {{- if and (hasKey $rbacValues "nameOverride") $rbacValues.nameOverride -}}
    {{- $rbacName = (printf "%v-%v" $rbacName $rbacValues.nameOverride) -}}
  {{- end -}}

  {{/* Prepare values for either cluster rbac or namespaced rbac */}}
  {{- $roleAPI := include "ix.v1.common.capabilities.role.apiVersion" $root -}}
  {{- $roleBindingAPI := include "ix.v1.common.capabilities.roleBinding.apiVersion" $root -}}
  {{- $roleKind := "Role" -}}
  {{- $roleBindingKind := "RoleBinding" -}}
  {{- $clusterWide := false -}}
  {{- if hasKey $rbacValues "clusterWide" -}}
    {{- if $rbacValues.clusterWide -}}
      {{- $roleKind = "ClusterRole" -}}
      {{- $roleBindingKind = "ClusterRoleBinding" -}}
      {{- $clusterWide = true -}}
      {{- $roleAPI = include "ix.v1.common.capabilities.clusterRole.apiVersion" $root -}}
      {{- $roleBindingAPI = include "ix.v1.common.capabilities.clusterRoleBinding.apiVersion" $root -}}
    {{- end -}}
  {{- end }}

---
apiVersion: {{ $roleAPI }}
kind: {{ $roleKind }}
metadata:
  name: {{ $rbacName }}
  {{- if not $clusterWide }}
  namespace: {{ $root.Release.Namespace }}
  {{- end }}
  {{- $labels := (mustMerge ($rbacValues.labels | default dict) (include "ix.v1.common.labels" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $root "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end }}
  {{- $annotations := (mustMerge ($rbacValues.annotations | default dict) (include "ix.v1.common.annotations" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $root "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
{{- with $rbacValues.rules -}}
rules:
  {{/* TODO: Make sure that still works with values like "" also with tpl and on subjects*/}}
  {{- range . }}
  - apiGroups:
    {{- range (required "<apiGroups> are required in RBAC rules." .apiGroups) }}
      - {{ tpl . $root }}
    {{- end }}
    resources:
    {{- range (required "<resources> are required in RBAC rules." .resources) }}
      - {{ tpl . $root }}
    {{- end }}
    verbs:
    {{- range (required "<verbs> are required in RBAC rules." .verbs) }}
      - {{ tpl . $root }}
    {{- end }}
  {{- end }}
{{- end }}

---
apiVersion: {{ $roleBindingAPI }}
kind: {{ $roleBindingKind }}
metadata:
  name: {{ $rbacName }}
  {{- if not $clusterWide }}
  namespace: {{ $root.Release.Namespace }}
  {{- end }}
  {{- $labels := (mustMerge ($rbacValues.labels | default dict) (include "ix.v1.common.labels" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $root "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end }}
  {{- $annotations := (mustMerge ($rbacValues.annotations | default dict) (include "ix.v1.common.annotations" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $root "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
roleRef:
  apiGroup: {{ $roleAPI }}
  kind: {{ $roleKind }}
  name: {{ $rbacName }}
subjects:
  - kind: ServiceAccount
    name: {{ $saName }}
    namespace: {{ $root.Release.Namespace }}
  {{- with $rbacValues.subjects -}}
    {{- range . }}
  - kind: {{ tpl (required "<kind> is required in RBAC subjects." .kind) $root }}
    name: {{ tpl (required "<name> is required in RBAC subjects." .name) $root }}
    apiGroup: {{ tpl (required "<apiGroup> is required in RBAC subjects." .apiGroup) $root }}
    {{- end }}
  {{- end -}}
{{- end -}}
