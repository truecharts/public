{{- define "tc.v1.common.lib.ingress.integration.nginx.ipWhitelist" -}}
  {{- $objectData := .objectData -}}
  {{- $whiteList := .whiteList -}}

  {{- if not (kindIs "slice" $whiteList) -}}
    {{- fail (printf "Ingress - Expected [integrations.nginx.ipWhitelist] to be a [slice], but got [%s]" (kindOf $whiteList)) -}}
  {{- end -}}

  {{- if $whiteList -}}
    {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/whitelist-source-range" (join "," $whiteList) -}}
  {{- end -}}
{{- end -}}
