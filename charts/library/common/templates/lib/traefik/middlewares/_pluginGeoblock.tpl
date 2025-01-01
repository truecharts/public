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
      {{- if hasKey $mw "allowLocalRequests" }}
      allowLocalRequests: {{ $mw.allowLocalRequests }}
      {{- end -}}
      {{- if hasKey $mw "logLocalRequests" }}
      logLocalRequests: {{ $mw.logLocalRequests }}
      {{- end -}}
      {{- if hasKey $mw "logAllowedRequests" }}
      logAllowedRequests: {{ $mw.logAllowedRequests }}
      {{- end -}}
      {{- if hasKey $mw "logApiRequests" }}
      logApiRequests: {{ $mw.logApiRequests }}
      {{- end -}}
      {{- if $mw.apiTimeoutMs }}
      apiTimeoutMs: {{ $mw.apiTimeoutMs }}
      {{- end -}}
      {{- if $mw.cacheSize }}
      cacheSize: {{ $mw.cacheSize }}
      {{- end -}}
      {{- if hasKey $mw "forceMonthlyUpdate" }}
      forceMonthlyUpdate: {{ $mw.forceMonthlyUpdate }}
      {{- end -}}
      {{- if hasKey $mw "allowUnknownCountries" }}
      allowUnknownCountries: {{ $mw.allowUnknownCountries }}
      {{- end -}}
      {{- if $mw.unknownCountryApiResponse }}
      unknownCountryApiResponse: {{ $mw.unknownCountryApiResponse }}
      {{- end -}}
      {{- if hasKey $mw "blackListMode" }}
      blackListMode: {{ $mw.blackListMode }}
      {{- end -}}
      {{- if hasKey $mw "silentStartUp" }}
      silentStartup: {{ $mw.silentStartUp }}
      {{- end -}}
      {{- if hasKey $mw "addCountryHeader" }}
      addCountryHeader: {{ $mw.addCountryHeader }}
      {{- end }}
      countries:
        {{- range $mw.countries }}
        - {{ . | quote }}
        {{- end }}
{{- end -}}
