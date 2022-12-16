{{- define "ix.v1.common.spawner.imagePullSecret" -}}
  {{- range $idx, $imgPullCreds := .Values.imagePullCredentials -}}
    {{- if $imgPullCreds.enabled -}}
      {{- include "ix.v1.common.class.imagePullSecret" (dict "root" $ "imgPullCreds" $imgPullCreds ) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
