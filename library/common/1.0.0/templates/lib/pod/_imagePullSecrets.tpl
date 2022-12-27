{{- define "ix.v1.common.imagePullSecrets" -}}
  {{- range $idx, $imgPullCreds := .Values.imagePullCredentials -}}
    {{- if $imgPullCreds.enabled -}}
      {{- $secretName := include "ix.v1.common.names.imagePullSecret" (dict "root" $ "imgPullCredsName" $imgPullCreds.name) }}
- name: {{ $secretName }}
    {{- end -}}
  {{- end -}}
{{- end -}}
