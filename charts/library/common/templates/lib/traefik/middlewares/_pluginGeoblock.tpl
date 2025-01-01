{{- define "tc.v1.common.class.traefik.middleware.pluginGeoblock" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}

  {{/* This has to match with the name of the plugin given on the traefik CLI */}}
  {{- $mwName := "GeoBlock" -}}
  {{- if $mw.pluginName -}}
    {{- $mwName = $mw.pluginName -}}
  {{- end -}}
  {{- if not $mw.api -}}
    {{- fail "Middleware (plugin-geoblock) - Expected [api] to be set" -}}
  {{- end -}}
  {{- if not $mw.countries -}}
    {{- fail "Middleware (plugin-geoblock) - Expected [countries] to be set" -}}
  {{- end }}
  plugin:
    {{ $mwName }}:
      api: {{ $mw.api }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "allowLocalRequests" "value" $mw.allowLocalRequests) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "logLocalRequests" "value" $mw.logLocalRequests) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "logAllowedRequests" "value" $mw.logAllowedRequests) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "logApiRequests" "value" $mw.logApiRequests) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.int" (dict "key" "apiTimeoutMs" "value" $mw.apiTimeoutMs) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.int" (dict "key" "cacheSize" "value" $mw.cacheSize) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "forceMonthlyUpdate" "value" $mw.forceMonthlyUpdate) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "allowUnknownCountries" "value" $mw.allowUnknownCountries) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "unknownCountryApiResponse" "value" $mw.unknownCountryApiResponse) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "blackListMode" "value" $mw.blackListMode) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "silentStartUp" "value" $mw.silentStartUp) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "addCountryHeader" "value" $mw.addCountryHeader) | nindent 6 }}
      countries:
        {{- range $mw.countries }}
        - {{ . | quote }}
        {{- end }}
{{- end -}}
