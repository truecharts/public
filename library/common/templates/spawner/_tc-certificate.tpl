{{/* Renders the certificate objects required by the chart */}}
{{- define "tc.v1.common.spawner.certificate" -}}
  {{/* Generate named certs as required */}}
  {{- range $name, $cert := .Values.cert -}}
    {{- if $cert.enabled -}}
      {{- $certValues := $cert -}}
      {{- $certName := include "tc.v1.common.lib.chart.names.fullname" $ -}}

      {{/* set defaults */}}
      {{- if and (not $certValues.nameOverride) (ne $name (include "tc.v1.common.lib.util.cert.primary" $)) -}}
        {{- $_ := set $certValues "nameOverride" $name -}}
      {{- end -}}

      {{- if $certValues.nameOverride -}}
        {{- $certName = printf "%v-%v" $certName $certValues.nameOverride -}}
      {{- end -}}

      {{- include "tc.v1.common.class.certificate" (dict "root" $ "name" $certName "certificateIssuer" $cert.certificateIssuer "hosts" $cert.hosts ) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
