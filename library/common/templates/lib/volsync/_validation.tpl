{{- define "tc.v1.common.lib.volsync.validation" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- if not $objectData.name -}}
    {{- fail "VolSync - Expected non-empty [name]" -}}
  {{- end -}}

  {{- if not $objectData.type -}}
    {{- fail "VolSync - Expected non-empty [type]" -}}
  {{- end -}}

  {{- $validTypes := list "restic" -}}
  {{- if not (mustHas $objectData.type $validTypes) -}}
    {{- fail (printf "VolSync - Expected [type] to be one of [%s], but got [%s]" (join ", " $validTypes) $objectData.type) -}}
  {{- end -}}

  {{- if not $objectData.credentials -}}
    {{- fail "VolSync - Expected non-empty [credentials]" -}}
  {{- end -}}

  {{- if not (kindIs "string" $objectData.credentials) -}}
    {{- fail (printf "VolSync - Expected [credentials] to be a string, but got [%s]" (kindOf $objectData.credentials)) -}}
  {{- end -}}

  {{- if not (get $rootCtx.Values.credentials $objectData.credentials) -}}
    {{- fail (printf "VolSync - Expected credentials [%s] to be defined in [credentials.%s]" $objectData.credentials $objectData.credentials) -}}
  {{- end -}}

  {{- $credentials := get $rootCtx.Values.credentials $objectData.credentials -}}
  {{- $reqFields := list "url" "bucket" "encrKey" "accessKey" "secretKey" -}}
  {{- range $key := $reqFields -}}
    {{- if not (get $credentials $key) -}}
      {{- fail (printf "VolSync - Expected non-empty [%s] in [credentials.%s]" $key $objectData.credentials) -}}
    {{- end -}}
  {{- end -}}

  {{- $copyMethods := list "Clone" "Direct" "Snapshot" -}}
  {{- if $objectData.copyMethod -}}
    {{- if not (mustHas $objectData.copyMethod $copyMethods) -}}
      {{- fail (printf "VolSync - Expected [copyMethod] to be one of [%s], but got [%s]" (join ", " $copyMethods) $objectData.copyMethod) -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
