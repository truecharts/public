{{- define "tc.v1.common.class.traefik.middleware.buffering" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data }}
  buffering:
    {{- include "tc.v1.common.class.traefik.middleware.helper.int" (dict "key" "maxRequestBodyBytes" "value" $mw.maxRequestBodyBytes) | nindent 4 }}
    {{- include "tc.v1.common.class.traefik.middleware.helper.int" (dict "key" "memRequestBodyBytes" "value" $mw.memRequestBodyBytes) | nindent 4 }}
    {{- include "tc.v1.common.class.traefik.middleware.helper.int" (dict "key" "maxResponseBodyBytes" "value" $mw.maxResponseBodyBytes) | nindent 4 }}
    {{- include "tc.v1.common.class.traefik.middleware.helper.int" (dict "key" "memResponseBodyBytes" "value" $mw.memResponseBodyBytes) | nindent 4 }}
    {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "retryExpression" "value" $mw.retryExpression) | nindent 4 }}
{{- end -}}
