{{- define "tc.v1.common.lib.velero.provider.secret" -}}
  {{- $rootCtx := .rootCtx }}
  {{- $objectData := .objectData -}}
  {{- $prefix := .prefix -}}

  {{- $creds := "" -}}
  {{/* Make sure provider is a string */}}
  {{- $provider := $objectData.provider | toString -}}

  {{/* Use config.provider when creating secret for VSL */}}
  {{- if and (eq $prefix "vsl") $objectData.config -}}
    {{- $provider = $objectData.config.provider | toString -}}
  {{- end -}}

  {{- if and (eq $provider "aws") $objectData.credential.aws -}}
    {{- $creds = (include "tc.v1.common.lib.velero.provider.aws.secret" (dict "creds" $objectData.credential.aws) | fromYaml).data -}}
    {{- if ne $prefix "vsl" -}} {{/* If its not VSL, update the provider with a prefix */}}
      {{- $_ := set $objectData "provider" "velero.io/aws" -}}
    {{- end -}}
  {{- else if and (eq $provider "s3") $objectData.credential.s3 -}}
    {{- $creds = (include "tc.v1.common.lib.velero.provider.aws.secret" (dict "creds" $objectData.credential.s3) | fromYaml).data -}}
    {{- if eq $prefix "vsl" -}} {{/* Convert s3 to aws for vsl under config.provider */}}
      {{- $_ := set $objectData.config "provider" "aws" -}}
    {{- else -}} {{/* If its not VSL, update the provider with a prefix */}}
      {{- $_ := set $objectData "provider" "velero.io/aws" -}}
    {{- end -}}
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
