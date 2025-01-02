{{- define "tc.v1.common.class.traefik.middleware.pluginRealIP" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}

  {{/* This has to match with the name of the plugin given on the traefik CLI */}}
  {{- $mwName := "traefik-real-ip" -}}
  {{- if $mw.pluginName -}}
    {{- $mwName = $mw.pluginName -}}
  {{- end -}}

  {{- if not $mw.excludednets -}}
    {{- fail "Middleware (real-ip) - Expected [excludednets] to be set" -}}
  {{- end }}
  plugin:
    {{ $mwName }}:
      excludednets:
        {{- range $mw.excludednets }}
        - {{ . | quote }}
        {{- end }}
{{- end -}}
