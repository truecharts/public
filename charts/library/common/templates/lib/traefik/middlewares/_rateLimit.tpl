{{- define "tc.v1.common.class.traefik.middleware.rateLimit" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data }}
rateLimit:
  average: {{ $mw.average | default 600 }}
  burst: {{ $mw.burst | default 400 }}
{{- end -}}
