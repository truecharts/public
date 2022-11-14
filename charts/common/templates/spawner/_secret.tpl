{{/*
Renders the Secret objects required by the chart.
*/}}
{{- define "tc.common.spawner.secret" -}}
  {{- with .Values.secretEnv }}
      {{- $secretEnvValues := dict "data" . -}}

      {{- $_ := set $ "ObjectValues" (dict "secret" $secretEnvValues) -}}
      {{- include "tc.common.class.secret" $ }}
  {{- end }}

  {{/* Generate named secrets as required */}}
  {{- range $name, $secret := .Values.secret }}
    {{- if $secret.enabled -}}
      {{- $secretValues := $secret -}}

      {{/* set the default nameOverride to the Secret name */}}
      {{- if not $secretValues.nameOverride -}}
        {{- $_ := set $secretValues "nameOverride" $name -}}
      {{ end -}}

      {{- $_ := set $ "ObjectValues" (dict "secret" $secretValues) -}}
      {{- include "tc.common.class.secret" $ }}
    {{- end }}
  {{- end }}
{{- end }}
