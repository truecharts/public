{{- define "tc.v1.common.lib.ingress.integration.traefik" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $traefik := $objectData.integrations.traefik -}}

  {{- $enabled := true -}}
  {{- if and $traefik (hasKey $traefik "enabled") (kindIs "bool" $traefik.enabled) -}}
    {{- $enabled = $traefik.enabled -}}
  {{- end -}}

  {{- if $enabled -}}
    {{- include "tc.v1.common.lib.ingress.integration.traefik.validate" (dict "objectData" $objectData) -}}

    {{- $fixedMiddlewares := list -}}
    {{- $enableFixed := false -}}
    {{- if (hasKey $rootCtx.Values.global "traefik") -}}
      {{- $fixedMiddlewares = $rootCtx.Values.global.traefik.fixedMiddlewares -}}
      {{- $enableFixed = $rootCtx.Values.global.traefik.enableFixedMiddlewares -}}
    {{- end -}}

    {{/* Override global (enable)fixedMiddlewares with local */}}
    {{- if $traefik.fixedMiddlewares -}}
      {{- $fixedMiddlewares = $traefik.fixedMiddlewares -}}
    {{- end -}}

    {{/* Replace global fixed with local fixed */}}
    {{- if and (hasKey $traefik "enableFixedMiddlewares") (kindIs "bool" $traefik.enableFixedMiddlewares) -}}
      {{- $enableFixed = $traefik.enableFixedMiddlewares -}}
    {{- end -}}

    {{/* Replace global and local fixed middlewares with the opencors-chain */}}
    {{- if $traefik.allowCors -}}
      {{- $fixedMiddlewares = list "tc-opencors-chain" -}}
    {{- end -}}

    {{- $entrypoints := $traefik.entrypoints | default (list "websecure") -}}
    {{- $middlewares := list -}}

    {{/* Add the fixedMiddlewares */}}
    {{- if and $enableFixed $fixedMiddlewares -}}
      {{- $middlewares = concat $middlewares $fixedMiddlewares -}}
    {{- end -}}

    {{/* Add the user middlewares */}}
    {{- if $traefik.middlewares -}}
      {{- $middlewares = concat $middlewares $traefik.middlewares -}}
    {{- end -}}

    {{/* Make sure we dont have dupes */}}
    {{- if $middlewares -}}
      {{- if not (deepEqual (mustUniq $middlewares) $middlewares) -}}
        {{- fail (printf "Ingress - Combined traefik middlewares contain duplicates [%s]" (join ", " $middlewares)) -}}
      {{- end -}}
    {{- end -}}

    {{- if not (deepEqual (mustUniq $entrypoints) $entrypoints) -}}
      {{- fail (printf "Ingress - Combined traefik entrypoints contain duplicates [%s]" (join ", " $entrypoints)) -}}
    {{- end -}}

    {{- $midNamespace := "tc-system" -}}
    {{/* If our hook has set operator.traefik.namespace, use that */}}
    {{- if (hasKey $rootCtx.Values.operator "traefik") -}}
      {{- if $rootCtx.Values.operator.traefik.namespace -}}
        {{- $midNamespace = $rootCtx.Values.operator.traefik.namespace -}}
      {{- end -}}
    {{- end -}}

    {{- if $traefik.ingressClassName -}}
      {{- $midNamespace = tpl $traefik.ingressClassName $rootCtx -}}

      {{/* On SCALE prepend with ix- */}}
      {{- if $rootCtx.Values.global.ixChartContext -}}
        {{- $midNamespace = (printf "ix-%s" $midNamespace) -}}
      {{- end -}}
    {{- end -}}

    {{/* Format middlewares */}}
    {{- $formMiddlewares := list -}}
    {{- range $mid := $middlewares -}}
      {{- $formMiddlewares = mustAppend $formMiddlewares (printf "%s-%s@kubernetescrd" $mid $midNamespace) -}}
    {{- end -}}

    {{- $_ := set $objectData.annotations "traefik.ingress.kubernetes.io/router.entrypoints" (join "," $entrypoints) -}}
    {{- if $formMiddlewares -}}
      {{- $_ := set $objectData.annotations "traefik.ingress.kubernetes.io/router.middlewares" (join "," $formMiddlewares) -}}
    {{- end -}}

  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.ingress.integration.traefik.validate" -}}
  {{- $objectData := .objectData -}}

  {{- $traefik := $objectData.integrations.traefik -}}

  {{- if $traefik.entrypoints -}}
    {{- if not (kindIs "slice" $traefik.entrypoints) -}}
      {{- fail (printf "Ingress - Expected [integrations.traefik.entrypoints] to be a [slice], but got [%s]" (kindOf $traefik.entrypoints)) -}}
    {{- end -}}
  {{- end -}}

  {{- if $traefik.middlewares -}}
    {{- if not (kindIs "slice" $traefik.middlewares) -}}
      {{- fail (printf "Ingress - Expected [integrations.traefik.middlewares] to be a [slice], but got [%s]" (kindOf $traefik.middlewares)) -}}
    {{- end -}}
  {{- end -}}

  {{- if $traefik.fixedMiddlewares -}}
    {{- if not (kindIs "slice" $traefik.fixedMiddlewares) -}}
      {{- fail (printf "Ingress - Expected [integrations.traefik.fixedMiddlewares] to be a [slice], but got [%s]" (kindOf $traefik.fixedMiddlewares)) -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
