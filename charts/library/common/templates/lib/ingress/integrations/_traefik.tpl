{{- define "tc.v1.common.lib.ingress.integration.traefik" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $rootCtx -}}
  {{- $ingMiddlewares := $rootCtx.Values.ingressMiddlewares -}}
  {{- if $ingMiddlewares -}}
    {{- $ingMiddlewares = $ingMiddlewares.traefik | default dict -}}
  {{- end -}}

  {{- $traefik := $objectData.integrations.traefik -}}
  {{- $enabled := "false" -}}
  {{- if and (hasKey $traefik "enabled") (kindIs "bool" $traefik.enabled) -}}
    {{- $enabled = $traefik.enabled | toString -}}
  {{- end -}}

  {{- if eq $enabled "true" -}}
    {{- include "tc.v1.common.lib.ingress.integration.traefik.validate" (dict "objectData" $objectData) -}}
    {{- $namespace := include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Traefik Integration") -}}

    {{- $entrypoints := $traefik.entrypoints | default (list "websecure") -}}
    {{- $middlewares := list -}}

    {{/* Add the user, common and chart middlewares */}}
    {{- if $rootCtx.Values.global.traefik.commonMiddlewares -}}
      {{- $middlewares = concat $middlewares $rootCtx.Values.global.traefik.commonMiddlewares -}}
    {{- end -}}

    {{- if $traefik.chartMiddlewares -}}
      {{- $middlewares = concat $middlewares $traefik.chartMiddlewares -}}
    {{- end -}}

    {{- if $traefik.middlewares -}}
      {{- $middlewares = concat $middlewares $traefik.middlewares -}}
    {{- end -}}

    {{/* Make sure we dont have dupes */}}
    {{- if not (deepEqual (mustUniq $entrypoints) $entrypoints) -}}
      {{- fail (printf "Ingress - Combined traefik entrypoints contain duplicates [%s]" (join ", " $entrypoints)) -}}
    {{- end -}}

    {{- $formattedMiddlewares := list -}}
    {{- range $mid := $middlewares -}}
      {{- $midNamespace := include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $mid "caller" "Traefik Integration") -}}

      {{- $midName := $mid.name -}}
      {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
                "rootCtx" $rootCtx "objectData" $mid
                "name" $mid.name "caller" "Traefik Integration"
                "key" "middlewares")) -}}

      {{/*
        Note: if the middleware defined in ingressMiddlewares.traefik has expandObjectName: false,
        it has to also be set to false here
      */}}
      {{- if eq $expandName "true" -}}
        {{- if eq $namespace $midNamespace -}}
          {{- if not (hasKey $ingMiddlewares $mid.name) -}}
            {{- fail (printf "Ingress - Traefik Middleware [%s] is not defined under [ingressMiddlewares.traefik]" $mid.name) -}}
          {{- end -}}
        {{- end -}}

        {{- $midName = (printf "%s-%s" $fullname $mid.name) -}}
      {{- end -}}

      {{/* Format middleware */}}
      {{- $formattedMiddlewares = mustAppend $formattedMiddlewares (printf "%s-%s@kubernetescrd" $midNamespace $midName) -}}
    {{- end -}}

    {{- if $formattedMiddlewares -}}
      {{/* Make sure we do not have dupes */}}
      {{- if not (deepEqual (mustUniq $formattedMiddlewares) $formattedMiddlewares) -}}
        {{- fail (printf "Ingress - Combined traefik middlewares contain duplicates [%s]" (join ", " $formattedMiddlewares)) -}}
      {{- end -}}
    {{- end -}}

    {{- $_ := set $objectData.annotations "traefik.ingress.kubernetes.io/router.entrypoints" (join "," $entrypoints) -}}
    {{- if $formattedMiddlewares -}}
      {{- $_ := set $objectData.annotations "traefik.ingress.kubernetes.io/router.middlewares" (join "," $formattedMiddlewares) -}}
    {{- end -}}

    {{- if or $traefik.forceTLS (mustHas "websecure" $entrypoints) -}}
      {{- $_ := set $objectData.annotations "traefik.ingress.kubernetes.io/router.tls" "true" -}}
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

  {{- if $traefik.chartMiddlewares -}}
    {{- if not (kindIs "slice" $traefik.chartMiddlewares) -}}
      {{- fail (printf "Ingress - Expected [integrations.traefik.chartMiddlewares] to be a [slice], but got [%s]" (kindOf $traefik.chartMiddlewares)) -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
