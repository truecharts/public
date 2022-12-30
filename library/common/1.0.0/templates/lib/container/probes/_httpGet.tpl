{{/* Returns http for the probe */}}
{{- define "ix.v1.common.container.probes.httpGet" -}}
  {{- $probe := .probe -}}
  {{- $containerName := .containerName -}}
  {{- $root := .root -}}

  {{- if not $probe.port -}}
    {{- fail (printf "<port> must be defined for <http>/<https> probe types in probe (%s) in (%s) container." $probe.name $containerName) -}}
  {{- end -}}
  {{- if not $probe.path -}}
    {{- fail (printf "<path> must be defined for <http>/<https> probe types in probe (%s) in (%s) container." $probe.name $containerName) -}}
  {{- end }}

httpGet:
  path: {{ tpl $probe.path $root }}
  scheme: {{ $probe.type | upper }}
  port: {{ $probe.port }}
  {{- with $probe.httpHeaders }}
  httpHeaders:
    {{- range $k, $v := . }}
      {{- if or (kindIs "slice" $v) (kindIs "map" $v) -}}
        {{- fail (printf "Lists or Dicts are not allowed in httpHeaders on probe (%s)" $probe.name) -}}
      {{- end }}
    - name: {{ $k }}
      value: {{ tpl (toString $v) $root }}
    {{- end }}
  {{- end }}

  {{- include "ix.v1.common.container.probes.timeouts"  (dict "probeSpec" $probe.spec
                                                              "probeName" $probe.name
                                                              "root" $root
                                                              "containerName" $containerName) }}
{{- end -}}
