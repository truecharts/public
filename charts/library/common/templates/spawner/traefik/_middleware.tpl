{{/* Traefik Middleware Spawner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.configmap" $ -}}
*/}}

{{- define "tc.v1.common.spawner.traefik.middleware" -}}
  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $ -}}
  {{- if not .Values.ingressMiddlewares -}}
    {{- $_ := set $.Values "ingressMiddlewares" dict -}}
  {{- end -}}
  {{- if not .Values.ingressMiddlewares.traefik -}}
    {{- $_ := set $.Values.ingressMiddlewares "traefik" dict -}}
  {{- end -}}

  {{- $filteredMiddlewares := dict -}}
  {{- $hasIngressEnabled := false -}}
  {{/* Go over all ingresses and get their defined middlewares */}}
  {{- range $ingName, $ing := $.Values.ingress -}}
    {{- $enabledIng := (include "tc.v1.common.lib.util.enabled" (dict
      "rootCtx" $ "objectData" $ing
      "name" $ingName "caller" "Ingress"
      "key" "ingress")) -}}

    {{/* Skip disabled ingresses or ingresses without traefik integration */}}
    {{- if ne $enabledIng "true" -}}{{- continue -}}{{- end -}}
    {{- if not $ing.integrations -}}
      {{- $_ := set $ing "integrations" dict -}}
    {{- end -}}
    {{- if not $ing.integrations.traefik -}}
      {{- $_ := set $ing.integrations "traefik" dict -}}
    {{- end -}}
    {{- $traefik := $ing.integrations.traefik -}}
    {{- $enabledTraefikIntegration := "false" -}}
    {{- if and (hasKey $traefik "enabled") (kindIs "bool" $traefik.enabled) -}}
      {{- $enabledTraefikIntegration = $traefik.enabled | toString -}}
    {{- end -}}
    {{- if ne $enabledTraefikIntegration "true" }}{{- continue -}}{{- end -}}

    {{- $hasIngressEnabled = true -}}

    {{/* User middlewares */}}
    {{- if and $traefik.middlewares (not (kindIs "slice" $traefik.middlewares)) -}}{{- continue -}}{{- end -}}
    {{- range $mw := $traefik.middlewares -}}
      {{- if $mw.namespace -}}{{- continue -}}{{- end -}}
      {{- $_ := set $filteredMiddlewares $mw.name "user-mw" -}}
    {{- end -}}

    {{/* Chart middlewares */}}
    {{- if and $traefik.chartMiddlewares (not (kindIs "slice" $traefik.chartMiddlewares)) -}}{{- continue -}}{{- end -}}
    {{- range $mw := $traefik.chartMiddlewares -}}
      {{- if $mw.namespace -}}{{- continue -}}{{- end -}}
      {{- $_ := set $filteredMiddlewares $mw.name "chart-mw" -}}
    {{- end -}}

  {{- end -}}

  {{- if $hasIngressEnabled -}}
    {{/* Global Middlewares */}}
    {{- range $mw := $.Values.global.traefik.commonMiddlewares -}}
      {{- if $mw.namespace -}}{{- continue -}}{{- end -}}
        {{- $_ := set $filteredMiddlewares $mw.name "global-mw" -}}
    {{- end -}}
  {{- end -}}

  {{- range $name, $middleware := $.Values.ingressMiddlewares.traefik -}}

    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
        "rootCtx" $ "objectData" $middleware
        "name" $name "caller" "Middleware"
        "key" "middlewares"))
    -}}

    {{- if ne $enabled "true" -}}
      {{- $indexedMid := get $filteredMiddlewares $name -}}
      {{- if not $indexedMid -}}{{- continue -}}{{- end -}}

      {{/*
        If current middleware manifest is in the middlewares listed under one of the above sections
        Forcefully enable it/render it.
      */}}
      {{- $enabled = "true" -}}

      {{- if eq $indexedMid "user-mw" -}}
        {{- include "add.warning" (dict "rootCtx" $ "warn" (printf
          "WARNING: Because middleware [%s] was used in an ingress under traefik integration, it was forcefully enabled."
        )) -}}
      {{- end -}}
    {{- end -}}

    {{- if eq $enabled "true" -}}
      {{/* Create a copy of the middleware */}}
      {{- $objectData := (mustDeepCopy $middleware) -}}

      {{- $objectName := $name -}}

      {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
                "rootCtx" $ "objectData" $objectData
                "name" $name "caller" "Middleware"
                "key" "middlewares")) -}}

      {{- if eq $expandName "true" -}}
        {{- $objectName = (printf "%s-%s" $fullname $name) -}}
      {{- end -}}

      {{/* Perform validations */}} {{/* Middleware have a max name length of 253 */}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectName "length" 253) -}}
      {{- include "tc.v1.common.lib.traefik.middleware.validation" (dict "objectData" $objectData) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Middleware") -}}

      {{/* Set the name of the middleware */}}
      {{- $_ := set $objectData "name" $objectName -}}
      {{- $_ := set $objectData "shortName" $name -}}

      {{/* Call class to create the object */}}
      {{- include "tc.v1.common.class.traefik.middleware" (dict "rootCtx" $ "objectData" $objectData) -}}

    {{- end -}}

  {{- end -}}

{{- end -}}
