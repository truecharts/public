{{- define "ix.v1.common.spawner.imagePullSecret" -}}
  {{- $root := . -}}
  {{- range $idx, $imgPullCreds := .Values.imagePullCredentials -}}
    {{- if $imgPullCreds.enabled -}}

      {{- if not $imgPullCreds.name -}}
        {{- fail "<name> is required for Image Pull Secrets Credentials" -}}
      {{- end -}}

      {{- if not (mustRegexMatch "^[a-zA-Z0-9-]*$" $imgPullCreds.name) -}}
        {{- fail (printf "<name> (%s) can only container this alphanumerical characters (- a-z A-Z 0-9)" $imgPullCreds.name) -}}
      {{- end -}}

      {{- $secretName := include "ix.v1.common.imagePullSecrets.name" (dict "root" $root "name" $imgPullCreds.name) -}}
      {{- $registrySecret := dict -}}

      {{- if not $imgPullCreds.content -}}
        {{- fail (printf "<content> is not defined in Image Pull Secrets Credential (%s)" $imgPullCreds.name) -}}
      {{- end -}}

      {{- with $imgPullCreds.content -}}
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
        {{- $_ := set $registrySecret.auths (printf "%s" .registry) $registry -}}

        {{- include "ix.v1.common.class.secret" (dict "root" $root "secretName" $secretName "data" $registrySecret "contentType" "pullSecret") -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
