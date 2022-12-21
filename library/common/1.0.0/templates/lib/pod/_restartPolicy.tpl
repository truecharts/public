{{- define "ix.v1.common.restartPolicy" -}}
  {{- $policy := .Values.global.defaults.restartPolicy -}}

  {{- if (hasKey .Values "restartPolicy") -}}
    {{- with .Values.restartPolicy -}}
      {{- if not (mustHas . (list "Always" "Never" "OnFailure")) -}}
        {{- fail (printf "Invalid <restartPolicy> (%s). Valid options are Always, Never, OnFailure" .) -}}
      {{- end -}}
      {{- $policy = . -}}
    {{- end -}}
  {{- end -}}
  {{- if (mustHas .Values.controller.type (list "Deployment" "ReplicaSet" "DaemonSet" "StatefulSet")) -}}
    {{- if ne $policy "Always" -}}
      {{- fail (printf "Invalid <restartPolicy (%s). Valid option for Deployment, StatefulSet, DaemonSet and ReplicaSet is Always" $policy) -}}
    {{- end -}}
  {{- end -}}
  {{- $policy -}}
{{- end -}}
