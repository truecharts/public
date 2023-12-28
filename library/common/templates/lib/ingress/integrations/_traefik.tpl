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
    {{- $allowCorsMiddlewares := list -}}
    {{- $enableFixed := false -}}
    {{- if (hasKey $rootCtx.Values.global "traefik") -}}
      {{- $fixedMiddlewares = $rootCtx.Values.global.traefik.fixedMiddlewares -}}
      {{- $enableFixed = $rootCtx.Values.global.traefik.enableFixedMiddlewares -}}
      {{- $allowCorsMiddlewares = $rootCtx.Values.global.traefik.allowCorsMiddlewares -}}
    {{- end -}}

    {{/* Override global (enable)fixedMiddlewares with local */}}
    {{- if $traefik.fixedMiddlewares -}}
      {{- $fixedMiddlewares = $traefik.fixedMiddlewares -}}
    {{- end -}}

    {{/* Replace global fixed with local fixed */}}
    {{- if and (hasKey $traefik "enableFixedMiddlewares") (kindIs "bool" $traefik.enableFixedMiddlewares) -}}
      {{- $enableFixed = $traefik.enableFixedMiddlewares -}}
    {{- end -}}

    {{/* Replace global and local fixed middlewares with the allowCorsMiddlewares */}}
    {{- if $traefik.allowCors -}}
      {{- $fixedMiddlewares = $allowCorsMiddlewares -}}
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
    {{- if not (deepEqual (mustUniq $entrypoints) $entrypoints) -}}
      {{- fail (printf "Ingress - Combined traefik entrypoints contain duplicates [%s]" (join ", " $entrypoints)) -}}
    {{- end -}}

    {{- $lookupMiddlewares := list -}}
    {{- $parsedMiddlewares := list -}}
    {{- if $middlewares -}}
      {{/* Only lookup if there are defined middlewares */}}
      {{- $lookupMiddlewares := (lookup "traefik.io/v1alpha1" "Middleware" "" "") -}}

      {{/* If there are items, re-assign the variable */}}
      {{- if and $lookupMiddlewares $lookupMiddlewares.items -}}
        {{- $lookupMiddlewares = $lookupMiddlewares.items -}}
      {{- end -}}

      {{/* Parse look-ed up middlewares */}}
      {{- range $m := $lookupMiddlewares -}}
        {{- $name := $m.metadata.name -}}
        {{- $namespace := $m.metadata.namespace -}}
        {{/* Create a smaller list with only the data we want */}}
        {{- $parsedMiddlewares = mustAppend $parsedMiddlewares (dict "name" $name "namespace" $namespace) -}}
      {{- end -}}
    {{- end -}}

    {{- $formattedMiddlewares := list -}}
    {{- range $mid := $middlewares -}}
      {{- $midNamespace := "" -}}

      {{/* If a namespace is given, use that */}}
      {{- if $mid.namespace -}}
        {{- $midNamespace = $mid.namespace -}}
      {{- end -}}

      {{/* If no namespace is given, try to find it */}}
      {{- if not $midNamespace -}}
        {{- $found := false -}}
        {{- range $p := $parsedMiddlewares -}}
          {{- if eq $p.name $mid.name -}}
            {{- if $found -}}
              {{- fail (printf "Ingress - Middleware [%s] is defined in multiple namespaces. Explicitly specify [namespace]" $mid.name) -}}
            {{- end -}}

            {{- $found = true -}}
            {{- $midNamespace = $p.namespace -}}
          {{- end -}}
        {{- end -}}

        {{- if not $found -}}
          {{/* This will also display when lookup is not supported (eg dry-run) */}}
          {{- fail (printf "Ingress - Middleware [%s] is not defined in any namespace. Middleware should be created first." $mid.name) -}}
        {{- end -}}
      {{- end -}}

      {{/* Format middleware */}}
      {{- $formattedMiddlewares = mustAppend $formattedMiddlewares (printf "%s-%s@kubernetescrd" $midNamespace $mid.name ) -}}
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

  {{- if $traefik.fixedMiddlewares -}}
    {{- if not (kindIs "slice" $traefik.fixedMiddlewares) -}}
      {{- fail (printf "Ingress - Expected [integrations.traefik.fixedMiddlewares] to be a [slice], but got [%s]" (kindOf $traefik.fixedMiddlewares)) -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
