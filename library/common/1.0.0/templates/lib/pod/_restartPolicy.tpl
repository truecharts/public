{{- define "ix.v1.common.restartPolicy" -}}
  {{- $root := .root -}}
  {{- $restartPolicy := .restartPolicy -}}
  {{- $isJob := .isJob | default false -}}
  {{- $policy := $root.Values.global.defaults.restartPolicy -}}

  {{- if $isJob -}}
    {{- $policy = $root.Values.global.defaults.jobRestartPolicy -}}
  {{- end -}}

  {{- with $restartPolicy -}}
    {{- $policy = . -}}
  {{- end -}}

  {{- if not (mustHas $policy (list "Always" "Never" "OnFailure")) -}}
    {{- fail (printf "Invalid <restartPolicy> (%s). Valid options are Always, Never, OnFailure" $policy) -}}
  {{- end -}}

  {{- if and (not $isJob) (mustHas $root.Values.controller.type (list "Deployment" "ReplicaSet" "DaemonSet" "StatefulSet")) -}}
    {{- if and (ne $policy "Always") -}}
      {{- fail (printf "Invalid <restartPolicy (%s). Valid option for Deployment, StatefulSet, DaemonSet and ReplicaSet is Always" $policy) -}}
    {{- end -}}
  {{- end -}}

  {{- $policy -}}
{{- end -}}
