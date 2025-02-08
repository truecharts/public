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

  {{- range $name, $middleware := $.Values.ingressMiddlewares.traefik -}}

    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $middleware
                    "name" $name "caller" "Middleware"
                    "key" "middlewares")) -}}

    {{- if ne $enabled "true" -}}
      {{- range $ingressName, $ingress := $.Values.ingress }}
        {{- $enabledIng := (include "tc.v1.common.lib.util.enabled" (dict
            "rootCtx" $ "objectData" $ingress
            "name" $ingressName "caller" "Middleware"
            "key" "middlewares")) -}}

        {{/* Skip disabled ingresses or ingresses without traefik integration */}}
        {{- if ne $enabledIng "true" -}}{{- continue -}}{{- end -}}
        {{- if not $ingress.integrations -}}{{- continue -}}{{- end -}}
        {{- if not $ingress.integrations.traefik -}}{{- continue -}}{{- end -}}

        {{- $enabledTraefikIntegration := (include "tc.v1.common.lib.util.enabled" (dict
            "rootCtx" $ "objectData" $ingress.integrations.traefik
            "name" $ingressName "caller" "Middleware"
            "key" "middlewares")) -}}

        {{- if ne $enabledTraefikIntegration "true" }}{{- continue -}}{{- end -}}

        {{/*
          If current middleware is also listed in global traefik common middlewares,
          forcefully enable it.
          This is so, if a user tries to use one of our pre-shipped global middlewares,
          wont have to manually enable it.
        */}}
        {{- range $middlewareEntry := $.Values.global.traefik.commonMiddlewares -}}
          {{- if and (eq $middlewareEntry.name $name) (not $middlewareEntry.namespace) -}}
            {{- $enabled = "true" -}}
          {{- end -}}
        {{- end -}}

        {{/*
          If current middleware is also listed in the traefik integration user middlewares,
          forcefully enable it. ?? Why not error here and let user know that he has to enable it.
        */}}
        {{- range $middlewareEntry := $ingress.integrations.traefik.middlewares -}}
          {{- if and (eq $middlewareEntry.name $name) (not $middlewareEntry.namespace) -}}
            {{- $enabled = "true" -}}
          {{- end }}
        {{- end }}


        {{/*
          If current middleware is also listed in the traefik integration chart middlewares,
          forcefully enable it.
          This is so if we define a custom middleware for a specific chart, and user wants to use it,
          ie user does not remove the middleware. The user wont have to manually enable it.
        */}}
        {{- range $middlewareEntry := $ingress.integrations.traefik.chartMiddlewares -}}
          {{- if and (eq $middlewareEntry.name $name) (not $middlewareEntry.namespace) -}}
            {{- $enabled = "true" -}}
          {{- end -}}
        {{- end -}}

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
