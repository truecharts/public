{{- define "tc.v1.common.lib.webhook.rules" -}}
  {{- $rules := .rules -}}
  {{- $rootCtx := .rootCtx }}
rules:
  {{- range $rule := $rules }}
  - apiVersions:
    {{- range $rule.apiVersions }}
      - {{ tpl . $rootCtx | quote }}
    {{- end }}
    apiGroups:
    {{- range $rule.apiGroups }}
      - {{ tpl . $rootCtx | quote }}
    {{- end }}
    operations:
    {{- range $rule.operations }}
      - {{ tpl . $rootCtx | quote }}
    {{- end }}
    resources:
    {{- range $rule.resources }}
      - {{ tpl . $rootCtx | quote }}
    {{- end -}}
    {{- with $rule.scope }}
    scope: {{ tpl . $rootCtx | quote }}
    {{- end -}}
  {{- end -}}
{{- end -}}
