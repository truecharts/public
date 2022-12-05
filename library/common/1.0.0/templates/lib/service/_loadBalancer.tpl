{{- define "ix.v1.common.class.serivce.loadBalancer" -}}
  {{- $svcType := .svcType -}}
  {{- $svcValues := .svc -}}
  {{- $root := .root -}}

  {{- if eq $svcType "LoadBalancer" -}}
type: LoadBalancer
    {{- with $svcValues.loadBalancerIP }}
loadBalancerIP: {{ . }}
    {{- end -}}
    {{- with $svcValues.loadBalancerSourceRanges }}
loadBalancerSourceRanges:
      {{- range . }}
      - {{ tpl . $root }}
     {{- end }}
    {{- end -}}
  {{- end -}}
{{- end -}}
