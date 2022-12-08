{{- define "ix.v1.common.restartPolicy" -}}
  {{- $policy := .Values.global.defaults.defaultRestartPolicy -}}

  {{- with .Values.restartPolicy -}}
    {{- if not (mustHas . (list "Always" "Never" "OnFailure")) -}}
      {{- fail (printf "Invalid <restartPolicy> (%s). Valid options are Always, Never, OnFailure" .) -}}
    {{- end -}}
    {{- $policy = . -}}
  {{- end -}}
  {{- $policy -}}
{{- end -}}
