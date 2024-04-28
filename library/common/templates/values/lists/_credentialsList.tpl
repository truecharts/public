{{- define "tc.v1.common.values.credentialsList" -}}
  {{- $rootCtx := . -}}

  {{- range $idx, $credsValues := $rootCtx.Values.credentialsList -}}

      {{- $name := (printf "vs-list-%s" (toString $idx)) -}}

      {{- with $credsValues.name -}}
        {{- $name = . -}}
      {{- end -}}

      {{- if not (hasKey $rootCtx.Values "credentials") -}}
        {{- $_ := set $rootCtx.Values "credentials" dict -}}
      {{- end -}}

      {{- $_ := set $rootCtx.Values.credentials $name $credsValues -}}
  {{- end -}}
{{- end -}}
