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
        {{- if and $ingress.enabled $ingress.integrations  $ingress.integrations.traefik $ingress.integrations.traefik.enabled }}
          {{- range $middlewareEntry := $.Values.global.traefik.commonMiddlewares }}

            {{- if and ( eq $middlewareEntry.name $name ) ( not $middlewareEntry.namespace ) }}
              {{- $enabled = "true" -}}
            {{- end }}
          {{- end }}
          {{- range $middlewareEntry := $ingress.integrations.traefik.middlewares }}

            {{- if and ( eq $middlewareEntry.name $name ) ( not $middlewareEntry.namespace ) }}
              {{- $enabled = "true" -}}
            {{- end }}
          {{- end }}
          {{- range $middlewareEntry := $ingress.integrations.traefik.chartMiddlewares }}
            {{- if and ( eq $middlewareEntry.name $name ) ( not $middlewareEntry.namespace ) }}
              {{- $enabled = "true" -}}
            {{- end }}
          {{- end }}
        {{- end }}
      {{- end }}
    {{- end }}

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
