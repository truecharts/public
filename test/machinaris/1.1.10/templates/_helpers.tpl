{{/*
Init container for coin deployments
*/}}
{{- define "initContainers" -}}
{{- $values := . -}}
{{- $machinarisApiUrl := (printf "http://%v:%v/" $values.nodeIP $values.apiPort) -}}
initContainers:
  - name: init-{{ $values.coinName }}
    image: curlimages/curl:7.80.0
    command: ['sh', '-c', 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' {{ $machinarisApiUrl }})" != "200" ]]; do echo "Machinaris is offline. Retrying in 2 seconds.." && sleep 2; done']
{{- end -}}


{{/*
Evironment variables (support for overrides)
*/}}
{{- define "allEnvironmentVariables" -}}
{{- $finalEnvironmentVariables := .defaultEnv -}}
{{- range $env := .environmentVariables -}}
  {{- $_ := set $finalEnvironmentVariables $env.name $env.value -}}
{{- end -}}
env:
{{- range $envVariableName := keys $finalEnvironmentVariables }}
  - name: {{ $envVariableName | quote }}
    value: {{ (get $finalEnvironmentVariables $envVariableName) | quote }}
{{- end -}}
{{- end -}}


{{/*
Resource limits
*/}}
{{- define "resourceLimits" -}}
{{- if .Values.enableResourceLimits -}}
resources:
  limits:
    cpu: {{ .Values.cpuLimit }}
    memory: {{ .Values.memLimit }}
{{- end -}}
{{- end -}}
