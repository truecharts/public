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

  {{- include "tc.v1.common.lib.credentials.validation" (dict "rootCtx" $rootCtx "caller" "VolSync" "credName" $objectData.credentials) -}}

  {{- $copyMethods := list "Clone" "Direct" "Snapshot" -}}
  {{- if $objectData.copyMethod -}}
    {{- if not (mustHas $objectData.copyMethod $copyMethods) -}}
      {{- fail (printf "VolSync - Expected [copyMethod] to be one of [%s], but got [%s]" (join ", " $copyMethods) $objectData.copyMethod) -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
