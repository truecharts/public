{{/*
Renders the Secret objects required by the chart.
*/}}
{{- define "tc.common.spawner.secret" -}}
  {{- if .Values.secretEnv }}
      {{- $secretValues := .Values.secretEnv -}}

      {{- $_ := set $ "ObjectValues" (dict "secret" $secretValues) -}}
      {{- include "tc.common.class.secret" $ }}
  {{- end }}

  {{- /* Generate named secrets as required */ -}}
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
