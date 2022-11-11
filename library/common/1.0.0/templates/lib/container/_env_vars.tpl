{{/* Environment Variables included by the container */}}
{{- define "ix.v1.common.container.envVars" -}}
{{- with .Values.env -}}
  {{- range $k, $v := . -}}
    {{- $name := $k -}}
    {{- $value := $v -}}
    {{- if kindIs "int" $name -}}
      {{- fail "Environment Variables as a list is not supported. Use key-value format." -}}
    {{- end -}}
- name: {{ $name | quote }}
    {{- if not (kindIs "map" $value) }}
      {{- if or (kindIs "string" $value) }} {{/* Single values are parsed as string (eg. int, bool) */}}
        {{- $value = tpl $value $ }} {{/* Expand Value */}}
      {{- end }}
  value: {{ quote $value }}
    {{- else if kindIs "map" $value }} {{/* If value is a dict... */}}
  valueFrom:
      {{- if hasKey $value "configMapKeyRef" }} {{/* And contains configMapRef... */}}
    configMapKeyRef:
        {{- $_ := set $value "name" $value.configMapKeyRef.name -}} {{/* Extract name and key */}}
        {{- $_ := set $value "key" $value.configMapKeyRef.key -}}
      {{- else if hasKey $value "secretKeyRef" }} {{/* And contains secretpRef... */}}
    secretKeyRef:
        {{- $_ := set $value "name" $value.secretKeyRef.name -}} {{/* Extract name and key */}}
        {{- $_ := set $value "key" $value.secretKeyRef.key -}}
        {{- if (hasKey $value.secretKeyRef "optional") }}
          {{- if (kindIs "bool" $value.secretKeyRef.optional) }}
      optional: {{ $value.secretKeyRef.optional }}
          {{- else }}
            {{- fail (printf "<optional> in secretKeyRef must be a boolean on Environment Variable (%s)" $name) -}}
          {{- end }}
        {{- end }}
      {{- else }}
        {{- fail "Not a valid valueFrom reference. Valid options are (configMapKeyRef and secretKeyRef)" -}}
      {{- end }}
      name: {{ tpl (required (printf "<name> for the keyRef is not defined in (%s)" $name) $value.name) $ }} {{/* Expand name and key */}}
      key: {{ tpl (required (printf "<key> for the keyRef is not defined in (%s)" $name) $value.key) $ }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end -}}
