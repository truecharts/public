{{- define "ix.v1.common.class.serivce.ipFamily" -}}
  {{- $svcValues := .svc -}}
  {{- $root := .root -}}

  {{- with $svcValues.ipFamilyPolicy -}}
    {{- if not (mustHas . (list "SingleStack" "PreferDualStack" "RequireDualStack")) -}}
      {{- fail (printf "Invalid option (%s) for <ipFamilyPolicy>. Valid options are SingleStack, PreferDualStack, RequireDualStack" .) -}}
    {{- end }}
ipFamilyPolicy: {{ . }}
  {{- end -}}
  {{- with $svcValues.ipFamilies }}
ipFamilies:
    {{- range . }}
      {{- $ipFam := tpl . $root -}}
      {{- if not (mustHas $ipFam (list "IPv4" "IPv6")) -}}
        {{- fail (printf "Invalid option (%s) for <ipFamilies[]>. Valid options are IPv4 and IPv6" $ipFam) -}}
      {{- end }}
  - {{ $ipFam }}
    {{- end -}}
  {{- end -}}
{{- end -}}
