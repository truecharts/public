{{- define "tc.v1.common.class.traefik.middleware.contentType" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data }}
  contentType: {}
{{- end -}}
