{{- define "tc.v1.common.lib.traefik.middlewares.map" -}}
  {{- $typeClassMap := dict
    "add-prefix"                      "tc.v1.common.class.traefik.middleware.addPrefix"
    "basic-auth"                      "tc.v1.common.class.traefik.middleware.basicAuth"
    "buffering"                       "tc.v1.common.class.traefik.middleware.buffering"
    "chain"                           "tc.v1.common.class.traefik.middleware.chain"
    "compress"                        "tc.v1.common.class.traefik.middleware.compress"
    "content-type"                    "tc.v1.common.class.traefik.middleware.contentType"
    "forward-auth"                    "tc.v1.common.class.traefik.middleware.forwardAuth"
    "headers"                         "tc.v1.common.class.traefik.middleware.headers"
    "ip-allow-list"                   "tc.v1.common.class.traefik.middleware.ipAllowList"
    "rate-limit"                      "tc.v1.common.class.traefik.middleware.rateLimit"
    "redirect-regex"                  "tc.v1.common.class.traefik.middleware.redirectRegex"
    "redirect-scheme"                 "tc.v1.common.class.traefik.middleware.redirectScheme"
    "replace-path"                    "tc.v1.common.class.traefik.middleware.replacePath"
    "replace-path-regex"              "tc.v1.common.class.traefik.middleware.replacePathRegex"
    "retry"                           "tc.v1.common.class.traefik.middleware.retry"
    "strip-prefix"                    "tc.v1.common.class.traefik.middleware.stripPrefix"
    "strip-prefix-regex"              "tc.v1.common.class.traefik.middleware.stripPrefixRegex"

    "plugin-bouncer"                  "tc.v1.common.class.traefik.middleware.pluginBouncer"
    "plugin-geoblock"                 "tc.v1.common.class.traefik.middleware.pluginGeoblock"
    "plugin-mod-security"             "tc.v1.common.class.traefik.middleware.pluginModSecurity"
    "plugin-real-ip"                  "tc.v1.common.class.traefik.middleware.pluginRealIP"
    "plugin-rewrite-response-headers" "tc.v1.common.class.traefik.middleware.pluginRewriteResponseHeaders"
    "plugin-theme-park"               "tc.v1.common.class.traefik.middleware.pluginThemePark"
  -}}

  {{- $typeClassMap | toJson -}}
{{- end -}}

{{/* Only render if its not <nil> and has a value of 0 or greater */}}
{{- define "tc.v1.common.class.traefik.middleware.helper.int" -}}
  {{- $key := .key -}}
  {{- $value := .value -}}

  {{- if and (not (kindIs "invalid" $value)) (ge ($value | int) 0) -}}
    {{- $key }}: {{ $value }}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.class.traefik.middleware.helper.bool" -}}
  {{- $key := .key -}}
  {{- $value := .value | toString -}}

  {{- if or (eq $value "true") (eq $value "false") -}}
    {{- $key }}: {{ $value }}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.class.traefik.middleware.helper.string" -}}
  {{- $key := .key -}}
  {{- $value := .value | toString -}}

  {{- if and $value (ne $value "<nil>") -}}
    {{- $key }}: {{ $value | quote }}
  {{- end -}}
{{- end -}}
