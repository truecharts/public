{{/*
Renders the configMap objects required by the chart.
*/}}
{{- define "tc.common.spawner.rbac" -}}
  {{/* Generate named rbac as required */}}
  {{- range $name, $rbac := .Values.rbac }}
    {{- if $rbac.enabled -}}
      {{- $rbacValues := $rbac -}}

      {{/* set the default nameOverride to the rbac name */}}
      {{- if and (not $rbacValues.nameOverride) (ne $name (include "tc.common.lib.util.rbac.primary" $)) -}}
        {{- $_ := set $rbacValues "nameOverride" $name -}}
      {{ end -}}

      {{- $_ := set $ "ObjectValues" (dict "rbac" $rbacValues) -}}
      {{- include "tc.common.class.rbac" $ }}
    {{- end }}
  {{- end }}
{{- end }}
