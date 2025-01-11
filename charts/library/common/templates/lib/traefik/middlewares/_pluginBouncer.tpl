{{- define "tc.v1.common.class.traefik.middleware.pluginBouncer" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data -}}

  {{/* This has to match with the name of the plugin given on the traefik CLI */}}
  {{- $mwName := "bouncer" -}}
  {{- if $mw.pluginName -}}
    {{- $mwName = $mw.pluginName -}}
  {{- end -}}
  {{- if not (hasKey $mw "enabled") -}}
    {{- fail "Middleware (plugin-bouncer) - Expected [enabled] to be set" -}}
  {{- end -}}
  {{- if not (kindIs "bool" $mw.enabled) -}}
    {{- fail (printf "Middleware (plugin-bouncer) - Expected [enabled] to be a boolean, but got [%s]" (kindOf $mw.enabled)) -}}
  {{- end }}
  plugin:
    {{ $mwName }}:
      enabled: {{ $mw.enabled }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "logLevel" "value" $mw.logLevel) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.int" (dict "key" "updateIntervalSeconds" "value" $mw.updateIntervalSeconds) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.int" (dict "key" "updateMaxFailure" "value" $mw.updateMaxFailure) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.int" (dict "key" "defaultDecisionSeconds" "value" $mw.defaultDecisionSeconds) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.int" (dict "key" "httpTimeoutSeconds" "value" $mw.httpTimeoutSeconds) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "crowdsecMode" "value" $mw.crowdsecMode) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "crowdsecAppsecEnabled" "value" $mw.crowdsecAppsecEnabled) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "crowdsecAppsecHost" "value" $mw.crowdsecAppsecHost) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "crowdsecAppsecFailureBlock" "value" $mw.crowdsecAppsecFailureBlock) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "crowdsecAppsecUnreachableBlock" "value" $mw.crowdsecAppsecUnreachableBlock) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "crowdsecLapiKey" "value" $mw.crowdsecLapiKey) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "crowdsecLapiHost" "value" $mw.crowdsecLapiHost) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "crowdsecLapiScheme" "value" $mw.crowdsecLapiScheme) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "crowdsecLapiTLSInsecureVerify" "value" $mw.crowdsecLapiTLSInsecureVerify) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "crowdsecCapiMachineId" "value" $mw.crowdsecCapiMachineId) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "crowdsecCapiPassword" "value" $mw.crowdsecCapiPassword) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "forwardedHeadersCustomName" "value" $mw.forwardedHeadersCustomName) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "remediationHeadersCustomName" "value" $mw.remediationHeadersCustomName) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "redisCacheEnabled" "value" $mw.redisCacheEnabled) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "redisCacheHost" "value" $mw.redisCacheHost) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "redisCachePassword" "value" $mw.redisCachePassword) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "redisCacheDatabase" "value" $mw.redisCacheDatabase) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "crowdsecLapiTLSCertificateAuthority" "value" $mw.crowdsecLapiTLSCertificateAuthority) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "crowdsecLapiTLSCertificateBouncer" "value" $mw.crowdsecLapiTLSCertificateBouncer) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "crowdsecLapiTLSCertificateBouncerKey" "value" $mw.crowdsecLapiTLSCertificateBouncerKey) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "captchaProvider" "value" $mw.captchaProvider) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "captchaSiteKey" "value" $mw.captchaSiteKey) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "captchaSecretKey" "value" $mw.captchaSecretKey) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.int" (dict "key" "captchaGracePeriodSeconds" "value" $mw.captchaGracePeriodSeconds) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "captchaHTMLFilePath" "value" $mw.captchaHTMLFilePath) | nindent 6 }}
      {{- include "tc.v1.common.class.traefik.middleware.helper.string" (dict "key" "banHTMLFilePath" "value" $mw.banHTMLFilePath) | nindent 6 }}
      {{- if $mw.crowdsecCapiScenarios }}
      crowdsecCapiScenarios:
        {{- range $mw.crowdsecCapiScenarios }}
        - {{ . | quote }}
        {{- end }}
      {{- end -}}
      {{- if $mw.forwardedHeadersTrustedIPs }}
      forwardedHeadersTrustedIPs:
        {{- range $mw.forwardedHeadersTrustedIPs }}
        - {{ . | quote }}
        {{- end }}
      {{- end -}}
      {{- if $mw.clientTrustedIPs }}
      clientTrustedIPs:
        {{- range $mw.clientTrustedIPs }}
        - {{ . | quote }}
        {{- end }}
      {{- end -}}
{{- end -}}
