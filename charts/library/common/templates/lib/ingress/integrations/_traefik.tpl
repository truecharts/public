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

    {{- if and (hasKey $traefik "enableFixedMiddlewares") (kindIs "bool" $traefik.enableFixedMiddlewares) -}}
      {{- $enableFixed = $traefik.enableFixedMiddlewares -}}
    {{- end -}}

    {{/* Replace global and local fixed middlewares with the allowCorsMiddlewares */}}
    {{- if $traefik.allowCors -}}
      {{- $fixedMiddlewares = $allowCorsMiddlewares -}}
    {{- end -}}

    {{- $entrypoints := $traefik.entrypoints | default (list "websecure") -}}
    {{- $middlewares := list -}}

    {{/* Add the user middlewares */}}
    {{- if $traefik.middlewares -}}
      {{- $middlewares = concat $middlewares $traefik.middlewares -}}
    {{- end -}}

    {{/* Make sure we dont have dupes */}}
    {{- if not (deepEqual (mustUniq $entrypoints) $entrypoints) -}}
      {{- fail (printf "Ingress - Combined traefik entrypoints contain duplicates [%s]" (join ", " $entrypoints)) -}}
    {{- end -}}

    {{- $formattedMiddlewares := list -}}
    {{- range $mid := $middlewares -}}

      {{ $midNamespace := include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Traefik Integration") }}
      {{/* If a namespace is given, use that */}}
      {{- if $mid.namespace -}}
        {{- $midNamespace = $mid.namespace -}}
      {{- end -}}

      {{/* Format middleware */}}
      {{- $formattedMiddlewares = mustAppend $formattedMiddlewares (printf "%s-%s@kubernetescrd" $midNamespace $mid.name) -}}
    {{- end -}}

    {{- if $formattedMiddlewares -}}
      {{/* Make sure we dont have dupes */}}
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


{{- end -}}
