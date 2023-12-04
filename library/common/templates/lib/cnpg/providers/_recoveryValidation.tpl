{{- define "tc.v1.common.lib.cnpg.provider.recoveryValidation" -}}
  {{- $objectData := .objectData -}}
  {{- $provider := $objectData.recovery.provider -}}

  {{- include "tc.v1.common.lib.cnpg.provider.validation" (dict
        "objectData" $objectData
        "key" "recovery" "caller" "CNPG Recovery"
        "provider" $provider) -}}

  {{- if not (get $objectData.recovery $provider) -}}
    {{- fail (printf "CNPG Recovery - Expected [recovery.%s] to be defined when [recovery.provider] is set to [%s]" $provider $provider) -}}
  {{- end -}}

{{- end -}}
