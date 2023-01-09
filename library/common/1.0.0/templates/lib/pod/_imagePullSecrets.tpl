{{- define "ix.v1.common.imagePullSecrets" -}}
  {{- $imagePullCredentials := .imagePullCredentials -}}
  {{- $root := .root -}}

  {{- range $idx, $imgPullCreds := $imagePullCredentials -}}
    {{- if $imgPullCreds.enabled -}}
      {{- $secretName := include "ix.v1.common.names.imagePullSecret" (dict "root" $root "imgPullCredsName" $imgPullCreds.name) }}
- name: {{ $secretName }}
    {{- end -}}
  {{- end -}}
{{- end -}}
