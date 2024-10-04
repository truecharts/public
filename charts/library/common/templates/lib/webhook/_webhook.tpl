{{- define "tc.v1.common.lib.webhook" -}}
  {{- $webhook := .webhook -}}
  {{- $rootCtx := .rootCtx }}
- name: {{ tpl $webhook.name $rootCtx }}
  {{- with $webhook.failurePolicy }}
  failurePolicy: {{ tpl . $rootCtx }}
  {{- end -}}
  {{- with $webhook.matchPolicy }}
  matchPolicy: {{ tpl . $rootCtx }}
  {{- end -}}
  {{- with $webhook.reinvocationPolicy }}
  reinvocationPolicy: {{ tpl . $rootCtx }}
  {{- end -}}
  {{- with $webhook.sideEffects }}
  sideEffects: {{ tpl . $rootCtx }}
  {{- end -}}
  {{- with $webhook.timeoutSeconds }}
  timeoutSeconds: {{ . }}
  {{- end -}}
  {{- include "tc.v1.common.lib.webhook.admissionReviewVersions" (dict "rootCtx" $rootCtx "admissionReviewVersions" $webhook.admissionReviewVersions) | trim | nindent 2 -}}
  {{- include "tc.v1.common.lib.webhook.clientConfig" (dict "rootCtx" $rootCtx "clientConfig" $webhook.clientConfig) | trim | nindent 2 -}}
  {{- include "tc.v1.common.lib.webhook.rules" (dict "rootCtx" $rootCtx "rules" $webhook.rules) | trim | nindent 2 -}}
  {{- with $webhook.namespaceSelector }}
  namespaceSelector:
    {{- tpl (toYaml $webhook.namespaceSelector) $rootCtx | nindent 2 -}}
  {{- end -}}
  {{- with $webhook.objectSelector }}
  objectSelector:
    {{- tpl (toYaml $webhook.objectSelector) $rootCtx | nindent 2 -}}
  {{- end -}}
{{- end -}}
