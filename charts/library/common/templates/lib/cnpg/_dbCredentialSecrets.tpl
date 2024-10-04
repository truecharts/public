{{- define "tc.v1.common.lib.cnpg.db.credentials.secrets" -}}
  {{- $objectData := .objectData -}}
  {{- $cnpg := .cnpg -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $dbPass := $objectData.password -}}
  {{- $auth := printf "%s:%s" $objectData.user $dbPass -}}

  {{/* Double "%" to escape the interpolation and use the template on another printf */}}
  {{- $stdTmpl := printf "postgresql://%s@%s-%%s:5432/%s" $auth $objectData.name $objectData.database -}}
  {{- $nosslTmpl := printf "postgresql://%s@%s-%%s:5432/%s?sslmode=disable" $auth $objectData.name $objectData.database -}}
  {{- $portHostTmpl := printf "%s-%%s:5432" $objectData.name -}}
  {{- $hostTmpl := printf "%s-%%s" $objectData.name -}}
  {{- $jdbcTmpl := printf "jdbc:postgresql://%s-%%s:5432/%s" $objectData.name $objectData.database -}}

  {{- $rwString := "rw" -}}
  {{- $roString := "ro" -}}
  {{- $poolEnabled := false -}}
  {{- if and $objectData.pooler $objectData.pooler.enabled -}}
    {{- $poolEnabled = true -}}
    {{- $rwString = "pooler-rw" -}}
    {{- $roString = "pooler-ro" -}}
  {{- end -}}

  {{- $creds := (dict
    "std" (printf $stdTmpl $rwString)
    "nossl" (printf $nosslTmpl $rwString)
    "portHost" (printf $portHostTmpl $rwString)
    "host" (printf $hostTmpl $rwString)
    "jdbc" (printf $jdbcTmpl $rwString)
  ) -}}

  {{- $credsRO := dict -}}
  {{- if and $poolEnabled $objectData.pooler.createRO -}}
    {{- $credsRO = (dict
      "std" (printf $stdTmpl $roString)
      "nossl" (printf $nosslTmpl $roString)
      "portHost" (printf $portHostTmpl $roString)
      "host" (printf $hostTmpl $roString)
      "jdbc" (printf $jdbcTmpl $roString)
    ) -}}
  {{- end -}}

  {{- with (include "tc.v1.common.lib.cnpg.secret.user" (dict "user" $objectData.user "pass" $dbPass) | fromYaml) -}}
    {{- $_ := set $rootCtx.Values.secret (printf "cnpg-%s-user" $objectData.shortName) . -}}
  {{- end -}}

  {{- with (include "tc.v1.common.lib.cnpg.secret.urls" (dict "creds" $creds "credsRO" $credsRO) | fromYaml) -}}
    {{- $_ := set $rootCtx.Values.secret (printf "cnpg-%s-urls" $objectData.shortName) . -}}
  {{- end -}}

  {{/* We need to mutate the actual (cnpg) values here not the copy */}}
  {{- if not (hasKey $cnpg "creds") -}}
    {{- $_ := set $cnpg "creds" dict -}}
  {{- end -}}

  {{- $_ := set $cnpg.creds "password" $dbPass -}}

  {{- $_ := set $cnpg.creds "std" $creds.std -}}
  {{- $_ := set $cnpg.creds "nossl" $creds.nossl -}}
  {{- $_ := set $cnpg.creds "porthost" $creds.portHost -}}
  {{- $_ := set $cnpg.creds "host" $creds.host -}}
  {{- $_ := set $cnpg.creds "jdbc" $creds.jdbc -}}

  {{- if and $poolEnabled $objectData.pooler.createRO -}}
    {{- $_ := set $cnpg.creds "stdRO" $credsRO.std -}}
    {{- $_ := set $cnpg.creds "nosslRO" $credsRO.nossl -}}
    {{- $_ := set $cnpg.creds "porthostRO" $credsRO.portHost -}}
    {{- $_ := set $cnpg.creds "hostRO" $credsRO.host -}}
    {{- $_ := set $cnpg.creds "jdbcRO" $credsRO.jdbc -}}
  {{- end -}}

{{- end -}}

{{- define "tc.v1.common.lib.cnpg.secret.urls" -}}
  {{- $creds := .creds -}}
  {{- $credsRO := .credsRO }}
enabled: true
data:
  std: {{ $creds.std }}
  nossl: {{ $creds.nossl }}
  porthost: {{ $creds.portHost }}
  host: {{ $creds.host }}
  jdbc: {{ $creds.jdbc }}
  {{- if $credsRO }}
  stdRO: {{ $credsRO.std }}
  nosslRO: {{ $credsRO.nossl }}
  porthostRO: {{ $credsRO.portHost }}
  hostRO: {{ $credsRO.host }}
  jdbcRO: {{ $credsRO.jdbc }}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.cnpg.secret.user" -}}
  {{- $user := .user -}}
  {{- $pass := .pass }}
enabled: true
type: kubernetes.io/basic-auth
data:
  username: {{ $user }}
  password: {{ $pass }}
{{- end -}}
