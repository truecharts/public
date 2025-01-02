{{/* Traefik Middleware Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.traefik.middleware" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData:
  name: The name of the middleware.
  labels: The labels of the middleware.
  annotations: The annotations of the middleware.
  data: The data of the middleware.
  namespace: The namespace of the middleware. (Optional)
*/}}

{{- define "tc.v1.common.class.traefik.middleware" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $typeClassMap := (include "tc.v1.common.lib.traefik.middlewares.map" $) | fromJson -}}

  {{- if not (hasKey $typeClassMap $objectData.type) -}}
    {{- fail (printf "Traefik - Middleware [%s] is not supported. Supported middlewares are [%s]" $objectData.type (keys $typeClassMap | join ", ")) -}}
  {{- end }}
---
apiVersion: traefik.io/v1alpha1
kind: Middleware
metadata:
  name: {{ $objectData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Middleware") }}
  {{- $labels := (mustMerge ($objectData.labels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($objectData.annotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  {{- /*
    Nothing goes after the include, each middleware can also render other manifests.
    For the same reason indentation must be handled by each middleware.
  */ -}}
  {{- include (get $typeClassMap $objectData.type) (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
{{- end -}}
