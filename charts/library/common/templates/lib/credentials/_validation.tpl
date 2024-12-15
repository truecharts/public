{{- define "tc.v1.common.lib.credentials.validation" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $caller := .caller -}}
  {{- $credName := .credName -}}

  {{- $credentials := get $rootCtx.Values.credentials $credName -}}

  {{- if not $credentials -}}
    {{- fail (printf "%s - Expected credentials [%s] to be defined in [credentials] which currently contains [%s] keys" $caller $credName (keys $rootCtx.Values.credentials | join ", ")) -}}
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

  {{- $url := get $credentials "url" -}}
  {{- if and (not (hasPrefix "http://" $url)) (not (hasPrefix "https://" $url)) -}}
    {{- fail (printf "%s - Expected [url] in [credentials.%s] to start with [http://] or [https://]. It was observed that sometimes can cause issues if it does not. Got [%s]" $caller $credName $url) -}}
  {{- end -}}

{{- end -}}
