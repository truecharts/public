{{- define "ix.v1.common.imagePullSecrets" -}}
  {{- range $idx, $imgPullCreds := .Values.imagePullCredentials -}}
    {{- if $imgPullCreds.enabled -}}
      {{- $secretName := include "ix.v1.common.imagePullSecrets.name" (dict "root" $ "name" $imgPullCreds.name) }}
- name: {{ $secretName }}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "ix.v1.common.imagePullSecrets.name" -}}
  {{- $name := .name -}}
  {{- $root := .root -}}

  {{- $credsName := $name | lower -}}
  {{- $secretName := printf "%v-%v" (include "ix.v1.common.names.fullname" $root) $credsName | trunc 63 -}}
  {{- $secretName -}}
{{- end -}}
