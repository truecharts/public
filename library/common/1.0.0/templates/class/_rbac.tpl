{{/* Template for RBAC object ((Cluster)Role, (Cluster)RoleBinding), can only be called by the spawner */}}
{{/* An rbac object, an SA object and "root" is passed from the spawner */}}
{{- define "ix.v1.common.spawner.rbac" -}}
  {{- $rbacValues := .rbac -}}
  {{- $saValues := .serviceAccount -}}
  {{- $root := .root -}}

  {{- $saName := include "ix.v1.common.names.fullname" $root -}}
  {{- $rbacName := include "ix.v1.common.names.fullname" $root -}}

  {{- if and (hasKey $rbacValues "nameOverride") $rbacValues.nameOverride -}}
    {{- $rbacName = (printf "%v:%v" $rbacName $rbacValues.nameOverride) -}}
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
  namespace: {{ .Release.Namespace }}
  {{- end }}
  # TODO: annotations, labels
{{- with $rbacValues.rules -}}
rules:
  # TODO: rules
{{- end }}

---
apiVersion: {{ $roleBindingAPI }}
kind: {{ $roleBindingKind }}
metadata:
  name: {{ $rbacName }}
  {{- if not $clusterWide }}
  namespace: {{ .Release.Namespace }}
  {{- end }}
  # TODO: annotations, labels
roleRef:
  apiGroup: {{ $roleAPI }}
  kind: {{ $roleKind }}
  name: {{ $rbacName }}
subjects:
  - kind: ServiceAccount
    name: {{ $saName }}
    namespace: {{ .Release.Namespace }}
# TODO: subjects


{{- end -}}
