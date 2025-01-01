{{- define "tc.v1.common.lib.traefik.middlewares.map" -}}
  {{- $typeClassMap := dict
    "add-prefix"          "tc.v1.common.class.traefik.middleware.addPrefix"
    "basic-auth"          "tc.v1.common.class.traefik.middleware.basicAuth"
    "buffering"           "tc.v1.common.class.traefik.middleware.buffering"
    "chain"               "tc.v1.common.class.traefik.middleware.chain"
    "compress"            "tc.v1.common.class.traefik.middleware.compress"
    "content-type"        "tc.v1.common.class.traefik.middleware.contentType"
    "forward-auth"        "tc.v1.common.class.traefik.middleware.forwardAuth"
    "headers"             "tc.v1.common.class.traefik.middleware.headers"
    "ip-allow-list"       "tc.v1.common.class.traefik.middleware.ipAllowList"
    "rate-limit"          "tc.v1.common.class.traefik.middleware.rateLimit"
    "redirect-regex"      "tc.v1.common.class.traefik.middleware.redirectRegex"
    "redirect-scheme"     "tc.v1.common.class.traefik.middleware.redirectScheme"
    "replace-path"        "tc.v1.common.class.traefik.middleware.replacePath"
    "replace-path-regex"  "tc.v1.common.class.traefik.middleware.replacePathRegex"
    "retry"               "tc.v1.common.class.traefik.middleware.retry"
    "strip-prefix"        "tc.v1.common.class.traefik.middleware.stripPrefix"
    "strip-prefix-regex"  "tc.v1.common.class.traefik.middleware.stripPrefixRegex"

    "plugin-theme-park"   "tc.v1.common.class.traefik.middleware.pluginThemePark"
    "plugin-real-ip"      "tc.v1.common.class.traefik.middleware.pluginRealIP"
    "plugin-mod-security" "tc.v1.common.class.traefik.middleware.pluginModSecurity"
  -}}

  {{- $typeClassMap | toJson -}}
{{- end -}}
