{{/*
Checks if $key exists in $checkEnvs
Takes a stringified array ($checkEnvs) and a string ($key)
*/}}
{{- define "ix.v1.common.container.envFixed.checkDuplicate" -}}
  {{- $checkEnvs := .checkEnvs -}}
  {{- $key := .key -}}
  {{- $holderKey := .holderKey -}}
  {{- $checkEnvs = $checkEnvs | fromJsonArray -}}
  {{- range $checkEnvs -}}
    {{- if eq $key .name -}}
      {{- fail (printf "Environment variable (%s) is already set to (%s). It must be removed from the <%s> key." .name .value $holderKey) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{/*
Checks if $key exists in $checkEnvs
Takes a dict ($checkEnvs) and a string ($key)
*/}}
{{- define "ix.v1.common.container.env.checkDuplicate" -}}
  {{- $checkEnvs := .checkEnvs -}} {{/* The envs to look into for the $key */}}
  {{- $key := .key -}}
  {{- range $k, $v := $checkEnvs -}}
    {{- if eq $key $k -}}
      {{- fail (printf "Environment variable (%s) is already set to (%s). It must be removed from the <envList> key." $k $v) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
