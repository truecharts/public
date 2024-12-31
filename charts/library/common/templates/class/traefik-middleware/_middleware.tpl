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

  {{- $typeClass := dict
    "add-prefix"          "tc.v1.common.class.traefik.middleware.addPrefix"
    "basic-auth"          "tc.v1.common.class.traefik.middleware.basicAuth"
    "buffering"           "tc.v1.common.class.traefik.middleware.buffering"
    "chain"               "tc.v1.common.class.traefik.middleware.chain"
    "compress"            "tc.v1.common.class.traefik.middleware.compress"
    "content-type"        "tc.v1.common.class.traefik.middleware.contentType"
    "forward-auth"        "tc.v1.common.class.traefik.middleware.forwardAuth"
    "ip-allow-list"       "tc.v1.common.class.traefik.middleware.ipAllowList"
    "rate-limit"          "tc.v1.common.class.traefik.middleware.rateLimit"
    "redirect-regex"      "tc.v1.common.class.traefik.middleware.redirectRegex"
    "redirect-scheme"     "tc.v1.common.class.traefik.middleware.redirectScheme"
    "replace-path"        "tc.v1.common.class.traefik.middleware.replacePath"
    "replace-path-regex"  "tc.v1.common.class.traefik.middleware.replacePathRegex"
    "retry"               "tc.v1.common.class.traefik.middleware.retry"
    "strip-prefix"        "tc.v1.common.class.traefik.middleware.stripPrefix"
    "strip-prefix-regex"  "tc.v1.common.class.traefik.middleware.stripPrefixRegex"
  -}}

  {{- if not (hasKey $typeClass $objectData.type) -}}
    {{- fail (printf "Traefik - Middleware [%s] is not supported. Supported middlewares are [%s]" $objectData.type (keys $typeClass | join ", ")) -}}
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
  {{- include (get $typeClass $objectData.type) (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
{{- end -}}
