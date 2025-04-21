{{- define "tc.v1.common.lib.ingress.integration.nginx" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $nginx := $objectData.integrations.nginx -}}

  {{- if $nginx.enabled -}}
    {{- include "tc.v1.common.lib.ingress.integration.nginx.validate" (dict "objectData" $objectData) -}}
    {{- if $nginx.ipWhitelist -}}
      {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/whitelist-source-range" $nginx.ipWhitelist -}}
    {{- end -}}
    {{- if $nginx.themepark -}}
      {{- if $nginx.themePark.enabled -}}
        {{- $nginxConfig := "
proxy_set_header Accept-Encoding \"\";
sub_filter
'</head>'
'<link rel=\"stylesheet\" type=\"text/css\" href=\"{{ $nginx.themePark.css }}\">
</head>';
sub_filter_once on;
" -}}
        {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/configuration-snippet" (tpl $nginxConfig .) -}}
      {{- end -}}
    {{- end -}}

    {{- if $nginx.auth -}}
      {{- if eq $nginx.auth.type "authentik" -}}
        {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-method" "GET" -}}
          {{ if $nginx.auth.responseHeaders -}}
            {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-response-headers" $nginx.auth.responseHeaders -}}
          {{- else -}}
            {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-response-headers" "Set-Cookie,X-authentik-username,X-authentik-groups,X-authentik-entitlements,X-authentik-email,X-authentik-name,X-authentik-uid" -}}
          {{- end -}}
        {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-snippet" "proxy_set_header X-Forwarded-Host $http_host;" -}}
        {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/backend-protocol" "HTTPS" -}}
        {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/force-ssl-redirect" "true" -}}
        {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-method" "true" -}}
        {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-url" (printf "http://%s/outpost.goauthentik.io/auth/nginx" $nginx.auth.internalHost) -}}
        {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-signin" (printf "https://%s/outpost.goauthentik.io/start?rd=$scheme://$http_host$escaped_request_uri" $nginx.auth.externalHost) -}}
      {{- end -}}
      {{- if eq $nginx.auth.type "authelia" -}}
        {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-method" "GET" -}}
          {{ if $nginx.auth.responseHeaders -}}
            {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-response-headers" $nginx.auth.responseHeaders -}}
          {{- else -}}
            {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-response-headers" "Remote-User,Remote-Name,Remote-Groups,Remote-Email" -}}
          {{- end -}}
        {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-url" (printf "http://%s/api/verify" $nginx.auth.internalHost) -}}
        {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-signin" (printf "https://%s?rm=$request_method" $nginx.auth.externalHost) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.ingress.integration.nginx.validate" -}}
  {{- $objectData := .objectData -}}

  {{- $nginx := $objectData.integrations.nginx -}}
  {{- $theme := $nginx.themePark -}}

  {{- if and $theme $theme.enabled (not (kindIs "string" $theme.css)) -}}
    {{- fail (printf "Ingress - Expected [integrations.nginx.themepark.css] to be a [string], but got [%s]" (kindOf $theme.css)) -}}
  {{- end -}}
{{- end -}}
