{{- define "tc.v1.common.lib.ingress.integration.nginx.auth.authentik" -}}
  {{- $objectData := .objectData -}}
  {{- $auth := .auth -}}

  {{- if and $auth.respondHeaders (not (kindIs "slice" $auth.responseHeaders)) -}}
    {{- fail (printf "Ingress - Expected [integrations.nginx.auth.responseHeaders] to be a [slice], but got [%s]" (kindOf $auth.responseHeaders)) -}}
  {{- end -}}

  {{- $respHeaders := ($auth.responseHeaders | default (list
    "Set-Cookie"
    "X-authentik-username"
    "X-authentik-groups"
    "X-authentik-entitlements"
    "X-authentik-email"
    "X-authentik-name"
    "X-authentik-uid"
  )) -}}

  {{- if or (not $auth.internalHost) (not $auth.externalHost) -}}
    {{- fail "Ingress - Expected [integrations.nginx.auth.internalHost] and [integrations.nginx.auth.externalHost] to be set" -}}
  {{- end -}}

  {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-method" "GET" -}}
  {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-response-headers" (join "," $respHeaders) -}}
  {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-snippet" "proxy_set_header X-Forwarded-Host $http_host;" -}}
  {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/backend-protocol" "HTTPS" -}}
  {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/force-ssl-redirect" "true" -}}
  {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-url" (printf "http://%s/outpost.goauthentik.io/auth/nginx" $auth.internalHost) -}}
  {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-signin" (printf "https://%s/outpost.goauthentik.io/start?rd=$scheme://$http_host$escaped_request_uri" $auth.externalHost) -}}
{{- end -}}

{{- define "tc.v1.common.lib.ingress.integration.nginx.auth.authelia" -}}
  {{- $objectData := .objectData -}}
  {{- $auth := .auth -}}

  {{- if and $auth.respondHeaders (not (kindIs "slice" $auth.responseHeaders)) -}}
    {{- fail (printf "Ingress - Expected [integrations.nginx.auth.responseHeaders] to be a [slice], but got [%s]" (kindOf $auth.responseHeaders)) -}}
  {{- end -}}

  {{- $respHeaders := ($auth.responseHeaders | default (list
    "Remote-User"
    "Remote-Name"
    "Remote-Groups"
    "Remote-Email"
  )) -}}

  {{- if or (not $auth.internalHost) (not $auth.externalHost) -}}
    {{- fail "Ingress - Expected [integrations.nginx.auth.internalHost] and [integrations.nginx.auth.externalHost] to be set" -}}
  {{- end -}}

  {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-method" "GET" -}}
  {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-url" (printf "http://%s/api/verify" $auth.internalHost) -}}
  {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-response-headers" (join "," $respHeaders) -}}
  {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/auth-signin" (printf "https://%s?rm=$request_method" $auth.externalHost) -}}
{{- end -}}
