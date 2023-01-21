{{/* Renders the PVC objects */}}
{{- define "ix.v1.common.spawner.pvc" -}}
  {{- $defaultType := .Values.global.defaults.persistenceType -}}
  {{- range $name, $pvc := .Values.persistence -}}
    {{- if and $pvc.enabled (eq (default $defaultType $pvc.type) "pvc") (not ($pvc.existingClaim)) -}}
      {{- $pvcValues := $pvc -}}

      {{/* Default to $name if there is not a nameOverride given */}}
      {{- if not $pvcValues.nameOverride -}}
        {{- $_ := set $pvcValues "nameOverride" $name -}}
      {{- end -}}

      {{- include "ix.v1.common.class.pvc" (dict "pvc" $pvcValues "root" $) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
