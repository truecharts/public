{{/*
A custom dict is expected with envs and root.
It's designed to work for mainContainer AND initContainers.
Calling this from an initContainer, wouldn't work, as it would have a different "root" context,
and "tpl" on "$" would cause erors.
That's why the custom dict is expected.
*/}}
{{/* Environment Variables included by the container */}}
{{- define "ix.v1.common.container.envVars" -}}
{{- $envs := .envs -}}
{{- $envList := .envList -}}
{{- $root := .root -}}
{{- if $root.Values.injectFixedEnvs -}}
  {{- include "ix.v1.common.container.fixedEnvs" $root | trim -}}
{{- end -}} {{/* Finish fixedEnv */}}
{{- with $envs -}}
{{- range $k, $v := . -}}
  {{- $name := $k -}}
  {{- $value := $v -}}
  {{- if kindIs "int" $name -}}
    {{- fail "Environment Variables as a list is not supported. Use key-value format." -}}
  {{- end }}
- name: {{ $name | quote }}
    {{- if not (kindIs "map" $value) -}}
      {{- if kindIs "string" $value -}} {{/* Single values are parsed as string (eg. int, bool) */}}
        {{- $value = tpl $value $root -}} {{/* Expand Value */}}
      {{- end }}
  value: {{ quote $value }}
    {{- else if kindIs "map" $value -}} {{/* If value is a dict... */}}
      {{- if hasKey $value "valueFrom" -}}
        {{- fail "Please remove <valueFrom> and use directly configMapKeyRef or secretKeyRef" -}}
      {{- end }}
  valueFrom:
      {{- if hasKey $value "configMapKeyRef" }} {{/* And contains configMapRef... */}}
    configMapKeyRef:
        {{- $_ := set $value "name" $value.configMapKeyRef.name -}} {{/* Extract name and key */}}
        {{- $_ := set $value "key" $value.configMapKeyRef.key -}}
        {{- if hasKey $value.configMapKeyRef "optional" -}}
          {{- fail "<optional> is not supported in configMapRefKey" -}}
        {{- end -}}
      {{- else if hasKey $value "secretKeyRef" }} {{/* And contains secretpRef... */}}
    secretKeyRef:
        {{- $_ := set $value "name" $value.secretKeyRef.name -}} {{/* Extract name and key */}}
        {{- $_ := set $value "key" $value.secretKeyRef.key -}}
        {{- if (hasKey $value.secretKeyRef "optional") -}}
          {{- if (kindIs "bool" $value.secretKeyRef.optional) }}
      optional: {{ $value.secretKeyRef.optional }}
          {{- else -}}
            {{- fail (printf "<optional> in secretKeyRef must be a boolean on Environment Variable (%s)" $name) -}}
          {{- end -}}
        {{- end -}}
      {{- else -}}
        {{- fail "Not a valid valueFrom reference. Valid options are (configMapKeyRef and secretKeyRef)" -}}
      {{- end }}
      name: {{ tpl (required (printf "<name> for the keyRef is not defined in (%s)" $name) $value.name) $root }} {{/* Expand name and key */}}
      key: {{ tpl (required (printf "<key> for the keyRef is not defined in (%s)" $name) $value.key) $root }}
    {{- end -}}
  {{- end -}}
{{- end -}} {{/* Finish env */}}
{{- with $envList -}}
{{- range $envList -}}
  {{- if and .name .value -}}
    {{- if has (kindOf .name) (list "map" "slice") -}}
      {{- fail "Name in envList cannot be a map or slice" -}}
    {{- end -}}
    {{- if has (kindOf .value) (list "map" "slice") -}}
      {{- fail "Value in envList cannot be a map or slice" -}}
    {{- end }}
- name: {{ tpl .name $root }}
  value: {{ tpl .value $root | quote }}
  {{- else -}}
    {{- fail "Please specify both name and value for environment variable" -}}
  {{- end -}}
{{- end -}}
{{- end -}} {{/* Finish envList */}}
{{- end -}}
