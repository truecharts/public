{{- define "tc.v1.common.lib.ingress.integration.nginx.ipWhitelist" -}}
  {{- $objectData := .objectData -}}
  {{- $whiteList := .whiteList -}}

  {{- if $whiteList -}}
    {{- $_ := set $objectData.annotations "nginx.ingress.kubernetes.io/whitelist-source-range" (join "," $whiteList) -}}
  {{- end -}}
{{- end -}}
