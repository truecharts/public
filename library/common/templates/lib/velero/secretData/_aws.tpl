{{- define "tc.v1.common.lib.velero.provider.aws.secret" -}}
  {{- $creds := .creds -}}

  {{- $reqKeys := list "id" "key" -}}
  {{- range $k := $reqKeys -}}
    {{- if not (get $creds $k) -}}
      {{- fail (printf "Velero Provider Secret - Expected non-empty [credential.aws|s3.%s] for [aws|s3] provider" $k) -}}
    {{- end -}}
  {{- end }}
data: |
  [default]
  aws_access_key_id={{ $creds.id }}
  aws_secret_access_key={{ $creds.key }}
{{- end -}}
