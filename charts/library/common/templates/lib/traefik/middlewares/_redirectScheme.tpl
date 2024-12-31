{{- define "tc.v1.common.class.traefik.middleware.redirectScheme" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}
  {{- if not $mw.scheme -}}
    {{- fail "Middleware (redirect-scheme) - Expected [scheme] to be set" -}}
  {{- end -}}

  {{- if hasKey $mw "permanent" -}}
    {{- if not (kindIs "bool" $mw.permanent) -}}
      {{- fail (printf "Middleware (redirect-scheme) - Expected [permanent] to be a boolean, but got [%s]" (kindOf $mw.permanent)) -}}
    {{- end -}}
  {{- end }}
redirectScheme:
  scheme: {{ $mw.scheme }}
  {{- if hasKey $mw "permanent" }}
  permanent: {{ $mw.permanent }}
  {{- end -}}
{{- end -}}
