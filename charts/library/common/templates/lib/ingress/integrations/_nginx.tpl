{{- define "tc.v1.common.lib.ingress.integration.nginx" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $nginx := $objectData.integrations.nginx -}}

  {{- if $nginx.enabled -}}

    {{/* ipWhiteList */}}
    {{- if $nginx.ipWhitelist -}}
      {{- include "tc.v1.common.lib.ingress.integration.nginx.ipWhitelist" (dict "objectData" $objectData "whiteList" $nginx.ipWhitelist) -}}
    {{- end -}}

    {{/* themePark */}}
    {{- if and $nginx.themePark $nginx.themePark.enabled -}}
      {{- include "tc.v1.common.lib.ingress.integration.nginx.themePark" (dict "objectData" $objectData "themePark" $nginx.themePark) -}}
    {{- end -}}

    {{/* Auth */}}
    {{- $validAuthTypes := (list "authentik" "authelia") -}}
    {{- if and $nginx.auth $nginx.auth.type -}}
      {{- if eq $nginx.auth.type "authentik" -}}
        {{- include "tc.v1.common.lib.ingress.integration.nginx.auth.authentik" (dict "objectData" $objectData "auth" $nginx.auth) -}}
      {{- else if eq $nginx.auth.type "authelia" -}}
        {{- include "tc.v1.common.lib.ingress.integration.nginx.auth.authelia" (dict "objectData" $objectData "auth" $nginx.auth) -}}
      {{- else -}}
        {{- fail (printf "Ingress - Expected [integrations.nginx.auth.type] to be one of [%s], but got [%s]" (join ", " $validAuthTypes) $nginx.auth.type) -}}
      {{- end -}}
    {{- end -}}

  {{- end -}}
{{- end -}}
