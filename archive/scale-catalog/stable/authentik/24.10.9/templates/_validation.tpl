{{- define "authentik.validation" -}}
  {{- range $outpost, $values := .Values.authentik.outposts -}}
    {{- if (kindIs "dict" $values) -}}
      {{- if and $values.enabled (not $values.token) -}}
        {{- fail (printf "Authentik - Outpost [%v] is enabled, but [token] was not provided" ($outpost | upper)) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if .Values.authentik.geoip.enabled -}}
    {{- if not .Values.authentik.geoip.accountID -}}
      {{- fail "Authentik - GeoIP is enabled but [accountID] was not provided" -}}
    {{- end -}}

    {{- if not .Values.authentik.geoip.licenseKey -}}
      {{- fail "Authentik - GeoIP is enabled but [licenseKey] was not provided" -}}
    {{- end -}}

    {{- if contains " " .Values.authentik.geoip.editionID -}}
      {{- fail "Authentik - GeoIP is enabled but [editionID] cannot contain spaces" -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
