{{/* Returns http for the probe */}}
{{- define "ix.v1.common.container.probes.httpGet" -}}
  {{- $probe := .probe -}}
  {{- $root := .root -}}

  {{- if not $probe.path -}}
    {{- fail (printf "<path> must be defined for HTTP/HTTPS probe types in probe (%s)" $probe.name) -}}
  {{- end }}

httpGet:
  path: {{ tpl $probe.path $root }}
  scheme: {{ $probe.type }}
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

  {{- include "ix.v1.common.container.probes.timeouts" (dict "probeSpec" $probe.spec "probeName" $probe.name) }}
{{- end -}}
