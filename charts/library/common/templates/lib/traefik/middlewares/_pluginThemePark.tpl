{{- define "tc.v1.common.class.traefik.middleware.pluginThemePark" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}

  {{/* This has to match with the name of the plugin given on the traefik CLI */}}
  {{- $mwName := "traefik-themepark" -}}
  {{- if $mw.pluginName -}}
    {{- $mwName = $mw.pluginName -}}
  {{- end -}}

  {{- if not $mw.app -}}
    {{- fail "Middleware (themepark) - Expected [app] to be set" -}}
  {{- end -}}
  {{- if not $mw.theme -}}
    {{- fail "Middleware (themepark) - Expected [theme] to be set" -}}
  {{- end }}
  plugin:
    {{ $mwName }}:
      app: {{ $mw.app }}
      theme: {{ $mw.theme }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "baseUrl" "value" $mw.baseUrl) | nindent 6 }}
      {{- if $mw.addons }}
      addons:
        {{- range $mw.addons }}
        - {{ . | quote }}
        {{- end }}
      {{- end -}}
{{- end -}}
