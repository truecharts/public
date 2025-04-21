{{- define "tc.v1.common.lib.ingress.integration.nginx.themePark" -}}
  {{- $objectData := .objectData -}}
  {{- $theme := .themePark -}}
  {{- if and $theme $theme.enabled (not (kindIs "string" $theme.css)) -}}
    {{- fail (printf "Ingress - Expected [integrations.nginx.themepark.css] to be a [string], but got [%s]" (kindOf $theme.css)) -}}
  {{- end -}}

  {{- $snippet := (list
    "proxy_set_header Accept-Encoding \"\";"
    "sub_filter"
    "'</head>'"
    (printf "'<link rel=\"stylesheet\" type=\"text/css\" href=\"%s\">" $theme.css)
    "</head>';"
    "sub_filter_once on;"
  ) -}}

  {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/configuration-snippet" (join "\n" $snippet) -}}
{{- end -}}
