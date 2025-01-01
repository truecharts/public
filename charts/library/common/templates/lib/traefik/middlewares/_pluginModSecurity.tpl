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
      {{- include "tc.v1.common.class.traefik.middleware.helper.int" (dict "key" "timeoutMillis" "value" $mw.timeoutMillis) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.int" (dict "key" "maxBodySize" "value" $mw.maxBodySize) | nindent 6 }}
{{- end -}}
