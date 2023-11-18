{{- define "tc.v1.common.values.imagePullSecretList" -}}
  {{- $rootCtx := . -}}

  {{- range $idx, $imagePullSecretValues := $rootCtx.Values.imagePullSecretList -}}

      {{- $name := (printf "pullsecret-list-%s" (toString $idx)) -}}

      {{- with $imagePullSecretValues.name -}}
        {{- $name = . -}}
      {{- end -}}

      {{- if not (hasKey $rootCtx.Values "imagePullSecret") -}}
        {{- $_ := set $rootCtx.Values "imagePullSecret" dict -}}
      {{- end -}}

      {{- $_ := set $rootCtx.Values.imagePullSecret $name $imagePullSecretValues -}}
  {{- end -}}
{{- end -}}
