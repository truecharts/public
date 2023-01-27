{{/* Renders the cnpg objects required by the chart */}}
{{- define "tc.v1.common.spawner.cnpg" -}}
  {{/* Generate named cnpges as required */}}
  {{- range $name, $cnpg := .Values.cnpg -}}
    {{- if $cnpg.enabled -}}
      {{- $cnpgValues := $cnpg -}}
      {{- $cnpgName := include "ix.v1.common.names.fullname" $ -}}

      {{/* set defaults */}}
      {{- if and (not $cnpgValues.nameOverride) (ne $name (include "tc.v1.common.lib.util.cnpg.primary" $)) -}}
        {{- $_ := set $cnpgValues "nameOverride" $name -}}
      {{- end -}}

      {{- if $cnpgValues.nameOverride -}}
        {{- $cnpgName = printf "%v-%v" $cnpgName $cnpgValues.nameOverride -}}
      {{- end -}}

      {{- $cnpgPoolerName := printf "cnpg-pooler-%v" $cnpgName -}}
      {{- $cnpgName = printf "cnpg-%v" $cnpgName -}}

      {{- $_ := set $cnpgValues "name" $cnpgName -}}

      {{- $_ := set $ "ObjectValues" (dict "cnpg" $cnpgValues) -}}
      {{- $_ := set $cnpgValues "poolerName" $cnpgPoolerName -}}
      {{- include "tc.v1.common.class.cnpg.cluster" $ -}}

      {{- $_ := set $cnpgValues.pooler "type" "rw" -}}
      {{- if not $cnpgValues.acceptRO }}
      {{- include "tc.v1.common.class.cnpg.pooler" $ -}}
      {{- else }}
      {{- include "tc.v1.common.class.cnpg.pooler" $ -}}
      {{- $_ := set $cnpgValues.pooler "type" "ro" -}}
      {{- include "tc.v1.common.class.cnpg.pooler" $ -}}
      {{- end }}
    {{- end -}}
  {{- end -}}
{{- end -}}
