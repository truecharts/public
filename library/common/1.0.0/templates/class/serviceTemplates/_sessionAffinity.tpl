{{- define "ix.v1.common.class.serivce.sessionAffinity" -}}
  {{- $svc := .svc -}}
  {{- $root := .root -}}

  {{- if not (has $svc.sessionAffinity (list "ClientIP" "None")) -}}
    {{- fail (printf "Invalid option (%s) for <sessionAffinity>. Valid options are ClientIP and None" $svc.sessionAffinity) -}}
  {{- end }}
sessionAffinity: {{ $svc.sessionAffinity }}
  {{- if eq $svc.sessionAffinity "ClientIP" -}}
    {{- with $svc.sessionAffinityConfig -}}
      {{- with .clientIP -}}
        {{- if hasKey . "timeoutSeconds" -}}
          {{- $timeout := tpl (toString .timeoutSeconds) $root -}}
          {{- if or (lt (int $timeout) 0) (gt (int $timeout) 86400) -}}
            {{- fail (printf "Invalid value (%s) for <sessionAffinityConfig.ClientIP.timeoutSeconds>. Valid values must be with 0 and 86400" $timeout) -}}
          {{- end }}
sessionAffinityConfig:
  clientIP:
    timeoutSeconds: {{ $timeout }}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
