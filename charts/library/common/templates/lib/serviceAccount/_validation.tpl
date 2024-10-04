{{/* Service Account Primary Validation */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.serviceAccount.primaryValidation" $ -}}
*/}}

{{- define "tc.v1.common.lib.serviceAccount.primaryValidation" -}}

  {{/* Initialize values */}}
  {{- $hasPrimary := false -}}
  {{- $hasEnabled := false -}}

  {{- range $name, $serviceAccount := .Values.serviceAccount -}}

    {{/* If service account is enabled */}}
    {{- if $serviceAccount.enabled -}}
      {{- $hasEnabled = true -}}

      {{/* And service account is primary */}}
      {{- if and (hasKey $serviceAccount "primary") ($serviceAccount.primary) -}}

        {{/* Fail if there is already a primary service account */}}
        {{- if $hasPrimary -}}
          {{- fail "Service Account - Only one service account can be primary" -}}
        {{- end -}}

        {{- $hasPrimary = true -}}

      {{- end -}}

    {{- end -}}
  {{- end -}}

  {{/* Require at least one primary service account, if any enabled */}}
  {{- if and $hasEnabled (not $hasPrimary) -}}
    {{- fail "Service Account - At least one enabled service account must be primary" -}}
  {{- end -}}

{{- end -}}
