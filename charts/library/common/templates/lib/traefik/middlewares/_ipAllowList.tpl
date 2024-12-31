{{- define "tc.v1.common.class.traefik.middleware.ipAllowList" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}

  {{- if $mw.sourceRange -}}
    {{- if not (kindIs "slice" $mw.sourceRange) -}}
      {{- fail (printf "Middleware (ip-allow-list) - Expected [sourceRange] to be a list, but got [%s]" (kindOf $mw.sourceRange)) -}}
    {{- end -}}
  {{- end -}}

  {{- if $mw.ipStrategy -}}
    {{- if $mw.ipStrategy.excludedIPs -}}
      {{- if not (kindIs "slice" $mw.ipStrategy.excludedIPs) -}}
        {{- fail (printf "Middleware (ip-allow-list) - Expected [ipStrategy.excludedIPs] to be a list, but got [%s]" (kindOf $mw.ipStrategy.excludedIPs)) -}}
      {{- end -}}
    {{- end -}}
  {{- end }}
ipAllowList:
  {{- if $mw.sourceRange }}
  sourceRange:
    {{- range $mw.sourceRange }}
    - {{ . | quote }}
    {{- end }}
  {{- end -}}

  {{- if $mw.ipStrategy }}
  ipStrategy:
    {{- if hasKey $mw.ipStrategy "depth" }}
    depth: {{ $mw.ipStrategy.depth }}
    {{- end -}}
    {{- if $mw.ipStrategy.excludedIPs }}
    excludedIPs:
      {{- range $mw.ipStrategy.excludedIPs }}
      - {{ . | quote }}
      {{- end }}
    {{- end -}}
  {{- end -}}
{{- end -}}
