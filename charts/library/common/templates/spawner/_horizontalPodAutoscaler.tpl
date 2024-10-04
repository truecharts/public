{{/*
Renders the configMap objects required by the chart.
*/}}
{{- define "tc.v1.common.spawner.hpa" -}}
  {{/* Generate named configMaps as required */}}
  {{- range $name, $hpa := .Values.horizontalPodAutoscaler -}}
    {{- if $hpa.enabled -}}
      {{- $hpaValues := $hpa -}}

      {{/* set the default nameOverride to the hpa name */}}
      {{- if not $hpaValues.nameOverride -}}
        {{- $_ := set $hpaValues "nameOverride" $name -}}
      {{- end -}}

      {{- $_ := set $ "ObjectValues" (dict "hpa" $hpaValues) -}}
      {{- include "tc.v1.common.class.hpa" $ -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
