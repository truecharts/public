{{/* Returns DNS Policy and Config */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.dns" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.dns" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $policy := "ClusterFirst" -}}
  {{- $config := dict -}}

  {{/* Initialize from the "global" option */}}
  {{- with $rootCtx.Values.podOptions.dnsPolicy -}}
    {{- $policy = . -}}
  {{- end -}}

  {{- with $rootCtx.Values.podOptions.dnsConfig -}}
    {{- $config = . -}}
  {{- end -}}

  {{/* Override with pod's option */}}
  {{- with $objectData.podSpec.dnsPolicy -}}
    {{- $policy = . -}}
  {{- end -}}

  {{- with $objectData.podSpec.dnsConfig -}}
    {{- $config = . -}}
  {{- end -}}

  {{/* Expand policy */}}
  {{- $policy = (tpl $policy $rootCtx) -}}

  {{/* If hostNetwork is enabled, then use ClusterFirstWithHostNet */}}
  {{- $hostNet := include "tc.v1.common.lib.pod.hostNetwork" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
  {{- if or (and (kindIs "string" $hostNet) (eq $hostNet "true")) (and (kindIs "bool" $hostNet) $hostNet) -}}
    {{- $policy = "ClusterFirstWithHostNet" -}}
  {{- end -}}

  {{- $policies := (list "ClusterFirst" "ClusterFirstWithHostNet" "Default" "None") -}}
  {{- if not (mustHas $policy $policies) -}}
    {{- fail (printf "Expected [dnsPolicy] to be one of [%s], but got [%s]" (join ", " $policies) $policy) -}}
  {{- end -}}

  {{/* When policy is set to None all keys are required */}}
  {{- if eq $policy "None" -}}

    {{- range $key := (list "nameservers" "searches" "options") -}}
      {{- if not (get $config $key) -}}
        {{- fail (printf "Expected non-empty [dnsConfig.%s] with [dnsPolicy] set to [None]." $key) -}}
      {{- end -}}
    {{- end -}}

  {{- end }}
dnsPolicy: {{ $policy }}
  {{- if or $config.nameservers $config.options $config.searches }}
dnsConfig:
    {{- with $config.nameservers -}}
      {{- if gt (len .) 3 -}}
        {{- fail (printf "Expected no more than [3] [dnsConfig.nameservers], but got [%v]" (len .)) -}}
      {{- end }}
  nameservers:
      {{- range . }}
  - {{ tpl . $rootCtx }}
      {{- end -}}
    {{- end -}}

    {{- with $config.searches -}}
      {{- if gt (len .) 6 -}}
        {{- fail (printf "Expected no more than [6] [dnsConfig.searches], but got [%v]" (len .)) -}}
      {{- end }}
  searches:
      {{- range . }}
  - {{ tpl . $rootCtx }}
      {{- end -}}
    {{- end -}}

    {{- with $config.options }}
  options:
      {{- range . }}
    - name: {{ tpl .name $rootCtx }}
        {{- with .value }}
      value: {{ tpl . $rootCtx | quote }}
        {{- end -}}
      {{- end -}}
    {{- end -}}

  {{- end -}}
{{- end -}}
