{{/*
This template serves as a blueprint for networkPolicy objects that are created
using the common library.
*/}}
{{- define "tc.v1.common.class.networkpolicy" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
---
kind: NetworkPolicy
apiVersion: {{ include "tc.v1.common.capabilities.networkpolicy.apiVersion" $ }}
metadata:
  name: {{ $objectData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "networkpolicy") }}
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
  {{- if $objectData.podSelector }}
  podSelector:
  {{- tpl (toYaml $objectData.podSelector) $ | nindent 4 }}
  {{/* Target all pods in namespace */}}
  {{- else if $objectData.targetAllPods }}
  podSelector: {}
  {{/* target a specific pod in this chart */}}
  {{/*
    This is not a list, because the match labels are a "AND" criterium, not an "OR"
    sp adding labels for multiple pods needs them to be deduped etc, whcih would require us to write a custom selector thing to handle that.
   */}}
  {{- else if $objectData.targetSelector }}
  podSelector:
    matchLabels:
      {{- include "tc.v1.common.lib.metadata.selectorLabels" (dict "rootCtx" $ "objectType" "pod" "objectName" $objectData.targetSelector ) | indent 8 }}
  {{/* Default: Target everything in this chart */}}
  {{- else }}
  podSelector:
    matchLabels:
      {{- include "tc.v1.common.lib.metadata.selectorLabels" (dict "rootCtx" $ "objectType" "" "objectName" "") | indent 8 }}
  {{- end }}

  {{- if $objectData.policyType }}
   policyTypes: {{ $objectData.policyType }}
  {{- else if $objectData.ingress }}
  policyTypes: ["Ingress"]
  {{- else if $objectData.egress }}
  policyTypes: ["Egress"]
  {{- else if and $objectData.ingress $objectData.egress }}
  policyTypes: ["Ingress", "Egress"]
  {{- end -}}
  {{- end -}}

  {{- if $objectData.egress }}
  egress:
  {{- range $objectData.egress }}
  - to:
    {{- range .to -}}
    {{- $nss := false -}}
    {{- $ipb := false -}}
      {{- if .ipBlock -}}
      {{- if .ipBlock.cidr -}}
      {{- $ipb = true }}
    - ipBlock:
        cidr: {{ .ipBlock.cidr }}
      {{- if .ipBlock.except }}
        except:
        {{- range .ipBlock.except }}
        - {{ . }}
        {{- end -}}
      {{- end -}}
      {{- end -}}
      {{- end -}}

      {{- if and ( .namespaceSelector ) ( not $ipb ) -}}
      {{- if or ( .namespaceSelector.matchLabels ) ( .namespaceSelector.matchExpressions ) -}}
      {{- $nss = true }}
    - namespaceSelector:
        {{- if .namespaceSelector.matchLabels }}
         matchLabels:
          {{- .namespaceSelector.matchLabels | toYaml | nindent 12 }}
        {{- end -}}
        {{- if .namespaceSelector.matchExpressions }}
         matchExpressions:
          {{- .namespaceSelector.matchExpressions | toYaml | nindent 12 }}
        {{- end -}}
      {{- end -}}
      {{- end -}}

      {{- if and ( .podSelector ) ( not $ipb ) -}}
      {{- if or ( .podSelector.matchLabels ) ( .podSelector.matchExpressions ) -}}
      {{- if $nss }}
      podSelector:
      {{- else }}
    - podSelector:
      {{- end -}}
        {{- if .podSelector.matchLabels }}
         matchLabels:
          {{- .podSelector.matchLabels | toYaml | nindent 12 }}
        {{- end -}}
        {{- if .podSelector.matchExpressions }}
         matchExpressions:
          {{- .podSelector.matchExpressions | toYaml | nindent 12 }}
        {{- end -}}
      {{- end -}}
      {{- end -}}
    {{- end -}}

  {{- with .ports }}
    ports:
    {{- . | toYaml | nindent 6 }}
  {{- end -}}
  {{- end -}}
  {{- end -}}

  {{- if $objectData.ingress }}
  ingress:
  {{- range $objectData.ingress }}
  - from:
    {{- range .from -}}
    {{- $nss := false -}}
    {{- $ipb := false -}}
      {{- if .ipBlock -}}
      {{- if .ipBlock.cidr -}}
      {{- $ipb = true }}
    - ipBlock:
        cidr: {{ .ipBlock.cidr }}
      {{- if .ipBlock.except }}
        except:
        {{- range .ipBlock.except }}
        - {{ . }}
        {{- end -}}
      {{- end -}}
      {{- end -}}
      {{- end -}}

      {{- if and ( .namespaceSelector ) ( not $ipb ) -}}
      {{- if or ( .namespaceSelector.matchLabels ) ( .namespaceSelector.matchExpressions ) -}}
      {{- $nss = true }}
    - namespaceSelector:
        {{- if .namespaceSelector.matchLabels }}
         matchLabels:
          {{- .namespaceSelector.matchLabels | toYaml | nindent 12 }}
        {{- end -}}
        {{- if .namespaceSelector.matchExpressions }}
         matchExpressions:
          {{- .namespaceSelector.matchExpressions | toYaml | nindent 12 }}
        {{- end -}}
      {{- end -}}
      {{- end -}}

      {{- if and ( .podSelector ) ( not $ipb ) -}}
      {{- if or ( .podSelector.matchLabels ) ( .podSelector.matchExpressions ) -}}
      {{- if $nss }}
      podSelector:
      {{- else }}
    - podSelector:
      {{- end }}
        {{- if .podSelector.matchLabels }}
         matchLabels:
          {{- .podSelector.matchLabels | toYaml | nindent 12 }}
        {{- end -}}
        {{- if .podSelector.matchExpressions }}
         matchExpressions:
          {{- .podSelector.matchExpressions | toYaml | nindent 12 }}
        {{- end -}}
      {{- end -}}
      {{- end -}}
    {{- end -}}

  {{- with .ports }}
    ports:
    {{- . | toYaml | nindent 6 }}
  {{- end -}}
  {{- end -}}
  {{- end -}}
{{- end -}}
