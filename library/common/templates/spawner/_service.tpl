{{/* Renders the service object(s) */}}
{{- define "ix.v1.common.spawner.service" -}}
  {{- $services := .Values.service -}}

  {{- range $name, $svc := $services -}}
    {{- if $svc.enabled -}}
      {{- $svcValues := $svc -}}

      {{/*
      If it's not the primary service, and no name override is defined, make sure
      we have a unique name passed to the service class.
      Primary service cannot have it's nameOverride
      */}}
      {{- if and (not $svcValues.nameOverride) (ne $name (include "ix.v1.common.lib.util.service.primary" (dict "services" $services))) -}}
        {{- $_ := set $svcValues "nameOverride" $name -}}
      {{- end -}}

      {{/*
      Pass a service object containing this single service to the class,
      in order to create the object. Also pass "root" for includes to work.
      */}}
      {{- include "ix.v1.common.class.service" (dict "svc" $svcValues "root" $) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
