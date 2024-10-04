{{- define "tc.v1.common.lib.cnpg.cluster.bootstrap.standalone" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $initdb := dict -}}
  {{- $postInitSQL := list -}}
  {{- $postInitTemplateSQL := list -}}
  {{- $postInitApplicationSQL := list -}}
  {{- $dataChecksums := true -}}
  {{- if not (hasKey $objectData.cluster "initdb") -}}
    {{- $_ := set $objectData.cluster "initdb" dict -}}
  {{- end -}}

  {{- if (kindIs "bool" $objectData.cluster.initdb.dataChecksums) -}}
    {{- $dataChecksums = $objectData.cluster.initdb.dataChecksums -}}
  {{- end -}}

  {{/* PostInitApplicationSQL */}}
  {{- if eq $objectData.type "timescaledb" -}}
    {{- $postInitApplicationSQL = concat $postInitApplicationSQL (list
      "CREATE EXTENSION IF NOT EXISTS timescaledb;") -}}
  {{- end -}}
  {{- if eq $objectData.type "postgis" -}}
    {{- $postInitApplicationSQL = concat $postInitApplicationSQL (list
      "CREATE EXTENSION IF NOT EXISTS postgis;"
      "CREATE EXTENSION IF NOT EXISTS postgis_topology;"
      "CREATE EXTENSION IF NOT EXISTS fuzzystrmatch;"
      "CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder;") -}}
  {{- end }}

  {{- if eq $objectData.type "vectors" -}}
    {{- $postInitApplicationSQL = concat $postInitApplicationSQL (list
      "CREATE EXTENSION IF NOT EXISTS vectors;") -}}
  {{- end -}}

  {{- if $objectData.cluster.initdb -}}
    {{- $postInitApplicationSQL = concat $postInitApplicationSQL ( $objectData.cluster.initdb.postInitApplicationSQL | default list ) -}}
    {{- $postInitSQL = concat $postInitSQL ( $objectData.cluster.initdb.postInitSQL | default list ) -}}
    {{- $postInitTemplateSQL = concat $postInitTemplateSQL ( $objectData.cluster.initdb.postInitTemplateSQL | default list ) -}}
  {{- end -}}

initdb:
  secret:
    name: {{ printf "%s-user" $objectData.clusterName }}
  database: {{ $objectData.database }}
  owner: {{ $objectData.user }}
  dataChecksums: {{ $dataChecksums }}
  {{- with $objectData.cluster.initdb.encoding }}
  encoding: {{ . }}
  {{- end -}}
  {{- with $objectData.cluster.initdb.localeCollate }}
  localeCollate: {{ . }}
  {{- end -}}
  {{- with $objectData.cluster.initdb.localeCtype }}
  localeCtype: {{ . }}
  {{- end -}}
  {{- with $objectData.cluster.initdb.walSegmentSize }}
  walSegmentSize: {{ . }}
  {{- end -}}
  {{- if $postInitApplicationSQL }}
  postInitApplicationSQL:
    {{- range $v := $postInitApplicationSQL }}
    - {{ tpl $v $rootCtx | quote }}
    {{- end -}}
  {{- end -}}
  {{- if $postInitSQL }}
  postInitSQL:
    {{- range $v := $postInitSQL }}
    - {{ tpl $v $rootCtx | quote }}
    {{- end -}}
  {{- end -}}
  {{- if $postInitTemplateSQL }}
  postInitTemplateSQL:
    {{- range $v := $postInitTemplateSQL }}
    - {{ tpl $v $rootCtx | quote }}
    {{- end -}}
  {{- end -}}
{{- end -}}
