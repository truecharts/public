{{/* Template for RBAC object ((Cluster)Role, (Cluster)RoleBinding), can only be called by the spawner */}}
{{/* An rbac object, an SA object and "root" is passed from the spawner */}}
{{- define "ix.v1.common.class.rbac" -}}
  {{- $rbacValues := .rbac -}}
  {{- $root := .root -}}

  {{- $saName := include "ix.v1.common.names.serviceAccountName" $root -}}
  {{- $rbacName := include "ix.v1.common.names.rbac" (dict "root" $root "rbacValues" $rbacValues) -}}

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
{{- if not $rbacValues.rules -}}
  {{- fail "<rules> cannot be empty in RBAC." -}}
{{- end -}}
{{- with $rbacValues.rules }}
rules:
  {{- range . }}
    {{- if not .apiGroups  -}}
      {{- fail "<apiGroups> cannot be empty in RBAC rules." -}}
    {{- end -}}
    {{- if not .resources -}}
      {{- fail "<resources> cannot be empty in RBAC rules." -}}
    {{- end -}}
    {{- if not .verbs -}}
      {{- fail "<verbs> cannot be empty in RBAC rules." -}}
    {{- end }}
  - apiGroups:
    {{- range .apiGroups }}
      {{- if eq . "" }}
      - ""
      {{- else }}
      - {{ tpl . $root | quote }}
      {{- end }}
    {{- end }}
    resources:
    {{- range .resources }}
      - {{ tpl . $root | quote }}
    {{- end }}
    verbs:
    {{- range .verbs }}
      - {{ tpl . $root | quote }}
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
  apiGroup: {{ include "ix.v1.common.capabilities.roleRef.apiGroup.apiVersion" $root }}
  kind: {{ $roleKind }}
  name: {{ $rbacName }}
subjects:
  - kind: ServiceAccount
    name: {{ $saName }}
    namespace: {{ $root.Release.Namespace }}
  {{- with $rbacValues.subjects -}}
    {{- range . }}
  - kind: {{ tpl (required "<kind> cannot be empty in RBAC subjects." .kind) $root | quote }}
    name: {{ tpl (required "<name> cannot be empty in RBAC subjects." .name) $root | quote }}
    apiGroup: {{ tpl (required "<apiGroup> cannot be empty in RBAC subjects." .apiGroup) $root | quote }}
    {{- end }}
  {{- end -}}
{{- end -}}
