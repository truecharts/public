{{- define "ix.v1.common.class.imagePullSecret" -}}
  {{- $imgPullCreds := .imgPullCreds -}}
  {{- $root := .root -}}

  {{- if not $imgPullCreds.name -}}
    {{- fail "<name> is required for Image Pull Secrets Credentials" -}}
  {{- end -}}

  {{- $secretName := include "ix.v1.common.imagePullSecrets.name" (dict "root" $ "name" $imgPullCreds.name) -}}

  {{- $registrySecret := dict -}}
    {{- with $imgPullCreds.contents -}}

      {{- if not .username -}}
        {{- fail (printf "<username> is not defined in Image Pull Secrets Credential (%s)" $imgPullCreds.name) -}}
      {{- end -}}
      {{- if not .password -}}
        {{- fail (printf "<password> is not defined in Image Pull Secrets Credential (%s)" $imgPullCreds.name) -}}
      {{- end -}}
      {{- if not .registry -}}
        {{- fail (printf "<registry> is not defined in Image Pull Secrets Credential (%s)" $imgPullCreds.name) -}}
      {{- end -}}
      {{- if not .email -}}
        {{- fail (printf "<email> is not defined in Image Pull Secrets Credential (%s)" $imgPullCreds.name) -}}
      {{- end -}}

      {{/* Auth is b64encoded and then the whole secret is b64encoded */}}
      {{- $auth := printf "%s:%s" .username .password | b64enc -}}
      {{- $registry := (dict "username" .username "password" .password "email" .email "auth" $auth) -}}

      {{- $_ := set $registrySecret "auths" dict -}}
      {{- $_ := set $registrySecret.auths (printf "%s" .registry) $registry }}
---
apiVersion: {{ include "ix.v1.common.capabilities.secret.apiVersion" $root }}
kind: Secret
metadata:
  name: {{ $secretName }}
  {{/*TODO: label / anno */}}
type: {{ include "ix.v1.common.capabilities.secret.imagePullSecret.type" $root }}
data:
  .dockerconfigjson: {{ $registrySecret | toJson | b64enc }}
  {{- end -}}
{{- end -}}
