{{/*
Renders the serviceAccount objects required by the chart.
*/}}
{{- define "tc.common.spawner.serviceaccount" -}}
  {{/* Generate named serviceAccount as required */}}
  {{- range $name, $serviceAccount := .Values.serviceAccount }}
    {{- if $serviceAccount.enabled -}}
      {{- $saValues := $serviceAccount -}}

      {{/* set the default nameOverride to the serviceAccount name */}}
      {{- if and (not $saValues.nameOverride) (ne $name (include "tc.common.lib.util.serviceaccount.primary" $)) -}}
        {{- $_ := set $saValues "nameOverride" $name -}}
      {{ end -}}

      {{- $_ := set $ "ObjectValues" (dict "serviceAccount" $saValues) -}}
      {{- include "tc.common.class.serviceAccount" $ }}
    {{- end }}
  {{- end }}
{{- end }}
