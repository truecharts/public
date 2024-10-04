{{- define "tc.v1.common.lib.webhook.clientConfig" -}}
  {{- $clientConfig := .clientConfig -}}
  {{- $rootCtx := .rootCtx }}
clientConfig:
  {{- if $clientConfig.caBundle }}
  caBundle: {{ tpl $clientConfig.caBundle $rootCtx | quote }}
  {{- end -}}
  {{- if $clientConfig.url }}
  url: {{ tpl $clientConfig.url $rootCtx | quote }}
  {{- end -}}
  {{- if $clientConfig.service }}
  service:
    name: {{ tpl $clientConfig.service.name $rootCtx }}
    namespace: {{ tpl $clientConfig.service.namespace $rootCtx }}
    {{- with $clientConfig.service.path }}
    path: {{ tpl . $rootCtx | quote }}
    {{- end -}}
    {{- with $clientConfig.service.port }}
    port: {{ tpl . $rootCtx }}
    {{- end -}}
  {{- end -}}
{{- end -}}
