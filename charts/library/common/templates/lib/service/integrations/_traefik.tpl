{{- define "tc.v1.common.lib.service.integration.traefik" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $traefik := $objectData.integrations.traefik -}}

  {{- if $traefik.enabled -}}
    {{- $_ := set $objectData.annotations "traefik.ingress.kubernetes.io/service.serversscheme" "https" -}}
  {{- end -}}

  {{- end -}}
{{- end -}}
