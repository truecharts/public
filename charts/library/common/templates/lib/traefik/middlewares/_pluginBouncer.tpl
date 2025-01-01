{{- define "tc.v1.common.class.traefik.middleware.pluginBouncer" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}

  {{/* This has to match with the name of the plugin given on the traefik CLI */}}
  {{- $mwName := "bouncer" -}}
  {{- if $mw.pluginName -}}
    {{- $mwName = $mw.pluginName -}}
  {{- end }}
  plugin:
    {{ $mwName }}:
{{- end -}}
