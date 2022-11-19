{{/* Renders a ServiceAccount object */}}
{{- define "ix.v1.common.spawner.serviceAccount" -}}
  {{- range $name, $serviceAccount := .Values.serviceAccount -}}
    {{- if $serviceAccount.enabled -}}
      {{- $saValues := $serviceAccount -}}

      {{/*
      If it's not the primary SA, and no name override is defined, make sure
      we have a unique name passed to the serviceAccount class.
      Primary SA cannot have it's nameOverride
      */}}
      {{- if and (not $saValues.nameOverride) (ne $name (include "ix.v1.common.lib.util.serviceAccount.primary" $)) -}}
        {{- $_ := set $saValues "nameOverride" $name -}}
      {{- end -}}

      {{/*
      Pass a serviceAccount object containing this single SA to the class,
      in order to create the object. Also pass "root" for includes to work.
      */}}
      {{- include "ix.v1.common.class.serviceAccount" (dict "serviceAccount" $saValues "root" $) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
