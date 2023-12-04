{{- define "tc.v1.common.lib.cnpg.db.credentials.secrets" -}}
  {{- $objectData := .objectData -}}
  {{- $cnpg := .cnpg -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $dbPass := $objectData.password -}}

  {{- $creds := (dict
    "std" (printf "postgresql://%v:%v@%v-rw:5432/%v" $objectData.user $dbPass $objectData.name $objectData.database)
    "nossl" (printf "postgresql://%v:%v@%v-rw:5432/%v?sslmode=disable" $objectData.user $dbPass $objectData.name $objectData.database)
    "porthost" (printf "%s-rw:5432" $objectData.name)
    "host" (printf "%s-rw" $objectData.name)
    "jdbc" (printf "jdbc:postgresql://%v-rw:5432/%v" $objectData.name $objectData.database)
  ) -}}

  {{- $credsRO := dict -}}
  {{- if $objectData.pooler.createRO -}}
    {{- $credsRO = (dict
      "std" (printf "postgresql://%v:%v@%v-ro:5432/%v" $objectData.user $dbPass $objectData.name $objectData.database)
      "nossl" (printf "postgresql://%v:%v@%v-ro:5432/%v?sslmode=disable" $objectData.user $dbPass $objectData.name $objectData.database)
      "porthost" (printf "%s-ro:5432" $objectData.name)
      "host" (printf "%s-ro" $objectData.name)
      "jdbc" (printf "jdbc:postgresql://%v-ro:5432/%v" $objectData.name $objectData.database)
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
  {{- $_ := set $cnpg.creds "porthost" $creds.porthost -}}
  {{- $_ := set $cnpg.creds "host" $creds.host -}}
  {{- $_ := set $cnpg.creds "jdbc" $creds.jdbc -}}

  {{- if $objectData.pooler.createRO -}}
    {{- $_ := set $cnpg.creds "stdRO" $credsRO.std -}}
    {{- $_ := set $cnpg.creds "nosslRO" $credsRO.nossl -}}
    {{- $_ := set $cnpg.creds "porthostRO" $credsRO.porthost -}}
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
  porthost: {{ $creds.porthost }}
  host: {{ $creds.host }}
  jdbc: {{ $creds.jdbc }}
  {{- if $credsRO }}
  stdRO: {{ $credsRO.std }}
  nosslRO: {{ $credsRO.nossl }}
  porthostRO: {{ $credsRO.porthost }}
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
