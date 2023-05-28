{{- define "tc.v1.common.lib.util.operator.verify" -}}
  {{- if .Values.operator.verify.enabled -}}
    {{- if (lookup "v1" "Namespace" "tc-system" "") -}}
      {{- range .Values.operator.verify.additionalOperators -}}
        {{- if not (lookup "v1" "ConfigMap" "tc-system" .) -}}
          {{- fail (printf "Operator [%s] needs to be installed" . ) -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
