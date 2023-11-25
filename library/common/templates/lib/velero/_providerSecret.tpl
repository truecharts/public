{{- define "tc.v1.common.lib.velero.provider.secret" -}}
  {{- $rootCtx := .rootCtx }}
  {{- $objectData := .objectData -}}
  {{- $prefix := .prefix -}}

  {{- $creds := "" -}}

  {{/* Make sure provider is a string */}}
  {{- $provider := $objectData.provider | toString -}}

  {{- if and (eq $provider "aws") $objectData.credential.aws -}}
    {{- $creds = (include "tc.v1.common.lib.velero.provider.aws.secret" (dict "creds" $objectData.credential.aws) | fromYaml).data -}}
    {{- $_ := set $objectData "provider" "velero.io/aws" -}}
  {{- else if and (eq $provider "s3") $objectData.credential.s3 -}}
    {{- $creds = (include "tc.v1.common.lib.velero.provider.aws.secret" (dict "creds" $objectData.credential.s3) | fromYaml).data -}}
    {{- $_ := set $objectData "provider" "velero.io/aws" -}}
  {{- end -}}

  {{/* If we matched a provider, create the secret */}}
  {{- if $creds -}}
    {{- $secretData := (dict
          "name" (printf "%s-%s" $prefix $objectData.name)
          "labels" $objectData.labels
          "annotations" $objectData.annotations
          "data" (dict "cloud" $creds)
      ) -}}

    {{/* Create the secret */}}
    {{- include "tc.v1.common.class.secret" (dict "rootCtx" $rootCtx "objectData" $secretData) -}}

    {{/* Update the credential object with the name and key */}}
    {{- $_ := set $objectData.credential "name" (printf "%s-%s" $prefix $objectData.name) -}}
    {{- $_ := set $objectData.credential "key" "cloud" -}}

  {{- end -}}

{{- end -}}
