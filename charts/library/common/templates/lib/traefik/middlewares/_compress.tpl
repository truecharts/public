{{- define "tc.v1.common.class.traefik.middleware.compress" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data }}
  compress: {}
{{- end -}}
