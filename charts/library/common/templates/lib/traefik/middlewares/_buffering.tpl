{{- define "tc.v1.common.class.traefik.middleware.buffering" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data }}
  buffering:
    {{- include "tc.v1.common.class.traefik.middleware.buffering.helper" (dict "key" "maxRequestBodyBytes" "value" $mw.maxRequestBodyBytes) | nindent 4 }}
    {{- include "tc.v1.common.class.traefik.middleware.buffering.helper" (dict "key" "memRequestBodyBytes" "value" $mw.memRequestBodyBytes) | nindent 4 }}
    {{- include "tc.v1.common.class.traefik.middleware.buffering.helper" (dict "key" "maxResponseBodyBytes" "value" $mw.maxResponseBodyBytes) | nindent 4 }}
    {{- include "tc.v1.common.class.traefik.middleware.buffering.helper" (dict "key" "memResponseBodyBytes" "value" $mw.memResponseBodyBytes) | nindent 4 }}
    {{- if $mw.retryExpression }}
    retryExpression: {{ $mw.retryExpression | quote }}
    {{- end -}}
{{- end -}}

{{/* Only render if its not <nil> and has a value of 0 or greater */}}
{{- define "tc.v1.common.class.traefik.middleware.buffering.helper" -}}
  {{- $key := .key -}}
  {{- $value := .value -}}

  {{- if and (not (kindIs "invalid" $value)) (ge ($value | int) 0) -}}
    {{- $key }}: {{ $value }}
  {{- end -}}
{{- end -}}
