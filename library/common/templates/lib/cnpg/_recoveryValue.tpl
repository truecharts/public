{{- define "tc.v1.common.lib.cnpg.configmap.recoverystring" -}}
  {{- $recoveryString := .recoveryString -}}
  {{- $recoveryKey := .recoveryKey -}}
enabled: true
data:
  {{ $recoveryKey }}: {{ $recoveryString }}
{{- end -}}
