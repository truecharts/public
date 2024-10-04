{{/* RBAC Primary Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.rbac.primaryValidation" $ -}}
*/}}

{{- define "tc.v1.common.lib.rbac.primaryValidation" -}}

  {{/* Initialize values */}}
  {{- $hasPrimary := false -}}
  {{- $hasEnabled := false -}}

  {{- range $name, $rbac := .Values.rbac -}}

    {{/* If rbac is enabled */}}
    {{- if $rbac.enabled -}}
      {{- $hasEnabled = true -}}

      {{/* And rbac is primary */}}
      {{- if and (hasKey $rbac "primary") ($rbac.primary) -}}

        {{/* Fail if there is already a primary rbac */}}
        {{- if $hasPrimary -}}
          {{- fail "RBAC - Only one rbac can be primary" -}}
        {{- end -}}

        {{- $hasPrimary = true -}}

      {{- end -}}

    {{- end -}}
  {{- end -}}

  {{/* Require at least one primary rbac, if any enabled */}}
  {{- if and $hasEnabled (not $hasPrimary) -}}
    {{- fail "RBAC - At least one enabled rbac must be primary" -}}
  {{- end -}}

{{- end -}}
