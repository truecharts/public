{{/* Renders the cnpg objects required by the chart */}}
{{- define "tc.v1.common.spawner.cnpg" -}}
  {{/* Generate named cnpges as required */}}
  {{- range $name, $cnpg := $.Values.cnpg }}

    {{- $enabled := false -}}
    {{- if hasKey $cnpg "enabled" -}}
      {{- if not (kindIs "invalid" $cnpg.enabled) -}}
        {{- $enabled = $cnpg.enabled -}}
      {{- else -}}
        {{- fail (printf "cnpg - Expected the defined key [enabled] in <cnpg.%s> to not be empty" $name) -}}
      {{- end -}}
    {{- end -}}

    {{- if kindIs "string" $enabled -}}
      {{- $enabled = tpl $enabled $ -}}

      {{/* After tpl it becomes a string, not a bool */}}
      {{-  if eq $enabled "true" -}}
        {{- $enabled = true -}}
      {{- else if eq $enabled "false" -}}
        {{- $enabled = false -}}
      {{- end -}}
    {{- end -}}


      {{- $cnpgValues := $cnpg }}
      {{- $cnpgName := include "tc.v1.common.lib.chart.names.fullname" $ }}
      {{- $_ := set $cnpgValues "shortName" $name }}

      {{/* set defaults */}}
      {{- $_ := set $cnpgValues "nameOverride" ( printf "cnpg-%v" $name ) }}

      {{- $cnpgName := printf "%v-%v" $cnpgName $cnpgValues.nameOverride }}

      {{- $_ := set $cnpgValues "name" $cnpgName }}

    {{- if $enabled -}}
      {{- $_ := set $ "ObjectValues" (dict "cnpg" $cnpgValues) }}
      {{- include "tc.v1.common.class.cnpg.cluster" $ }}

      {{- $_ := set $cnpgValues.pooler "type" "rw" }}
      {{- if not $cnpgValues.acceptRO }}
      {{- include "tc.v1.common.class.cnpg.pooler" $ }}
      {{- else }}
      {{- include "tc.v1.common.class.cnpg.pooler" $ }}
      {{- $_ := set $cnpgValues.pooler "type" "ro" }}
      {{- include "tc.v1.common.class.cnpg.pooler" $ }}
      {{- end }}

    {{- end }}


    {{- $dbPass := "" }}
    {{- $dbprevious := lookup "v1" "Secret" $.Release.Namespace ( printf "%s-user" $cnpgValues.name ) }}
    {{- if or $enabled $dbprevious -}}
      {{/* Inject the required secrets */}}

      {{- if $dbprevious }}
        {{- $dbPass = ( index $dbprevious.data "password" ) | b64dec }}
      {{- else }}
        {{- $dbPass = $cnpgValues.password | default ( randAlphaNum 62 ) }}
      {{- end }}

      {{- $std := ( ( printf "postgresql://%v:%v@%v-rw:5432/%v" $cnpgValues.user $dbPass $cnpgValues.name $cnpgValues.database  ) | quote ) }}
      {{- $nossl := ( ( printf "postgresql://%v:%v@%v-rw:5432/%v?sslmode=disable" $cnpgValues.user $dbPass $cnpgValues.name $cnpgValues.database  ) | quote ) }}
      {{- $porthost := ( ( printf "%s-rw:5432" $cnpgValues.name ) | quote ) }}
      {{- $host := ( ( printf "%s-rw" $cnpgValues.name ) | quote ) }}
      {{- $jdbc := ( ( printf "jdbc:postgresql://%v-rw:5432/%v" $cnpgValues.name $cnpgValues.database  ) | quote ) }}

      {{- $userSecret := include "tc.v1.common.lib.cnpg.secret.user" (dict "values" $cnpgValues "dbPass" $dbPass ) | fromYaml }}
      {{- if $userSecret }}
        {{- $_ := set $.Values.secret ( printf "cnpg-%s-user" $cnpgValues.shortName ) $userSecret }}
      {{- end }}

      {{- $urlSecret := include "tc.v1.common.lib.cnpg.secret.urls" (dict "std" $std "nossl" $nossl "porthost" $porthost "host" $host "jdbc" $jdbc) | fromYaml }}
      {{- if $urlSecret }}
        {{- $_ := set $.Values.secret ( printf "cnpg-%s-urls" $cnpgValues.shortName ) $urlSecret }}
      {{- end }}

      {{- $_ := set $cnpgValues.creds "password" ( $dbPass | quote ) }}
      {{- $_ := set $cnpgValues.creds "std" $std }}
      {{- $_ := set $cnpgValues.creds "nossl" $nossl }}
      {{- $_ := set $cnpgValues.creds "porthost" $porthost }}
      {{- $_ := set $cnpgValues.creds "host" $host }}
      {{- $_ := set $cnpgValues.creds "jdbc" $jdbc }}

      {{- if $cnpgValues.monitoring }}
        {{- if $cnpgValues.monitoring.enablePodMonitor }}
          {{- $poolermetrics :=  include "tc.v1.common.lib.cnpg.metrics.pooler" (dict "poolerName" ( printf "%s-rw" $cnpgValues.name) ) | fromYaml }}

          {{- $_ := set $.Values.metrics ( printf "cnpg-%s-rw" $cnpgValues.shortName ) $poolermetrics }}
          {{- if $cnpgValues.acceptRO }}
            {{- $poolermetricsRO :=  include "tc.v1.common.lib.cnpg.metrics.pooler" (dict "poolerName" ( printf "%s-ro" $cnpgValues.name) ) | fromYaml }}
            {{- $_ := set $.Values.metrics ( printf "cnpg-%s-ro" $cnpgValues.shortName ) $poolermetricsRO }}
          {{- end }}
        {{- end }}
      {{- end }}

    {{- end }}
  {{- end }}
{{- end -}}
