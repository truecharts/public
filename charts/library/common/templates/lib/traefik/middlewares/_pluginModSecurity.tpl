{{- define "tc.v1.common.class.traefik.middleware.pluginModSecurity" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}

  {{/* This has to match with the name of the plugin given on the traefik CLI */}}
  {{- $mwName := "traefik-modsecurity-plugin" -}}
  {{- if $mw.pluginName -}}
    {{- $mwName = $mw.pluginName -}}
  {{- end -}}

  {{- if not $mw.modSecurityUrl -}}
    {{- fail "Middleware (modsecurity) - Expected [modSecurityUrl] to be set" -}}
  {{- end }}
  plugin:
    {{ $mwName }}:
      modSecurityUrl: {{ $mw.modSecurityUrl }}
      {{- if $mw.timeoutMillis }}
      timeoutMillis: {{ $mw.timeoutMillis }}
      {{- end -}}
      {{- if $mw.maxBodySize }}
      maxBodySize: {{ $mw.maxBodySize }}
      {{- end -}}
{{- end -}}
