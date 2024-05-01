{{- define "tc.v1.common.lib.credentials.validation" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $caller := .caller -}}
  {{- $credName := .credName -}}

  {{- $credentials := get $rootCtx.Values.credentials $credName -}}

  {{- if not $credentials -}}
    {{- fail (printf "%s - Expected credentials [%s] to be defined in [credentials.%s]" $caller $credName $credName) -}}
  {{- end -}}

  {{- $validCredTypes := list "s3" -}}
  {{- if $credentials.type -}} {{/* Remove this if check if more types are supported in future */}}
    {{- if not (mustHas $credentials.type $validCredTypes) -}}
      {{- fail (printf "%s - Expected [type] in [credentials.%s] to be one of [%s], but got [%s]" $caller $credName (join ", " $validCredTypes) $credentials.type) -}}
    {{- end -}}
  {{- end -}}

  {{- $reqFields := list "url" "bucket" "encrKey" "accessKey" "secretKey" -}}
  {{- range $key := $reqFields -}}
    {{- if not (get $credentials $key) -}}
      {{- fail (printf "VolSync - Expected non-empty [%s] in [credentials.%s]" $key $credName) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
