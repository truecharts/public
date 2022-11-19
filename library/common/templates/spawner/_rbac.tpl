{{/* Renders the RBAC object(s) */}}
{{- define "ix.v1.common.spawner.rbac" -}}
  {{- range $name, $rbac := .Values.rbac -}}
    {{- if $rbac.enabled -}}
      {{- $rbacValues := $rbac -}}

      {{/*
      If it's not the primary RBAC, and no name override is defined, make sure
      we have a unique name passed to the RBAC class.
      Primary RBAC cannot have it's nameOverride
      */}}
      {{- if and (not $rbacValues.nameOverride) (ne $name (include "ix.v1.common.lib.util.rbac.primary" $)) -}}
        {{- $_ := set $rbacValues "nameOverride" $name -}}
      {{- end -}}

      {{/*
      Pass a RBAC object containing this single RBAC to the class,
      in order to create the object. Also pass "root" for includes to work.
      */}}
      {{- include "ix.v1.common.class.rbac" (dict "rbac" $rbacValues "root" $) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
