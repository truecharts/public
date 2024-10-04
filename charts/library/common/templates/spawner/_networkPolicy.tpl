{{/*
Renders the networkPolicy objects required by the chart.
*/}}
{{- define "tc.v1.common.spawner.networkpolicy" -}}
  {{/* Generate named networkpolicy as required */}}
  {{- range $name, $networkPolicy := .Values.networkPolicy -}}
    {{- if $networkPolicy.enabled -}}
      {{- $networkPolicyValues := $networkPolicy -}}

      {{/* set the default nameOverride to the networkpolicy name */}}
      {{- if not $networkPolicyValues.nameOverride -}}
        {{- $_ := set $networkPolicyValues "nameOverride" $name -}}
      {{- end -}}

      {{- $_ := set $ "ObjectValues" (dict "networkPolicy" $networkPolicyValues) -}}
      {{- include "tc.v1.common.class.networkpolicy" $ -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
