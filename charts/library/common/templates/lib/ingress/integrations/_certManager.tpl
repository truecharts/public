{{- define "tc.v1.common.lib.ingress.integration.certManager" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $certManager := $objectData.integrations.certManager -}}

  {{- if $certManager.enabled -}}
    {{- include "tc.v1.common.lib.ingress.integration.certManager.validate" (dict "objectData" $objectData) -}}

    {{- $_ := set $objectData.annotations "cert-manager.io/cluster-issuer" $certManager.certificateIssuer -}}
    {{- $_ := set $objectData.annotations "cert-manager.io/private-key-rotation-policy" "Always" -}}

  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.ingress.integration.certManager.validate" -}}
  {{- $objectData := .objectData -}}

  {{- $certManager := $objectData.integrations.certManager -}}

  {{- if not $certManager.certificateIssuer -}}
    {{- fail "Ingress - Expected a non-empty [integrations.certManager.certificateIssuer]" -}}
  {{- end -}}

  {{- if not (kindIs "string" $certManager.certificateIssuer) -}}
    {{- fail (printf "Ingress - Expected [integrations.certManager.certificateIssuer] to be a [string], but got [%s]" (kindOf $certManager.certificateIssuer)) -}}
  {{- end -}}

{{- end -}}
