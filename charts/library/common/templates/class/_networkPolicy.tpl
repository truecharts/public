{{/*
Blueprint for the NetworkPolicy object
*/}}
{{- define "tc.v1.common.class.networkpolicy" -}}
  {{- $fullName := include "tc.v1.common.lib.chart.names.fullname" . -}}
  {{- $networkPolicyName := $fullName -}}
  {{- $values := .Values.networkPolicy -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.networkPolicy -}}
      {{- $values = . -}}
    {{- end -}}
  {{- end -}}
  {{- $networkpolicyLabels := $values.labels -}}
  {{- $networkpolicyAnnotations := $values.annotations -}}

  {{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
    {{- $networkPolicyName = printf "%v-%v" $networkPolicyName $values.nameOverride -}}
  {{- end }}
---
kind: NetworkPolicy
apiVersion: {{ include "tc.v1.common.capabilities.networkpolicy.apiVersion" $ }}
metadata:
  name: {{ $networkPolicyName }}
  namespace: {{ $.Values.namespace | default $.Values.global.namespace | default $.Release.Namespace }}
  {{- $labels := (mustMerge ($networkpolicyLabels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $ | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($networkpolicyAnnotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $ | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  podSelector:
  {{- if $values.podSelector }}
  {{- tpl (toYaml $values.podSelector) $ | nindent 4 }}
  {{- else if $values.targetSelector }}
    {{- $objectData := dict "targetSelector" $values.targetSelector }}
    {{- $selectedPod := fromYaml ( include "tc.v1.common.lib.helpers.getSelectedPodValues" (dict "rootCtx" $ "objectData" $objectData)) }}
    {{- $selectedPodName := $selectedPod.shortName }}
    matchLabels:
      {{- include "tc.v1.common.lib.metadata.selectorLabels" (dict "rootCtx" $ "objectType" "pod" "objectName" $selectedPodName) | indent 8 }}
  {{- else }}
    matchLabels:
      {{- include "tc.v1.common.lib.metadata.selectorLabels" (dict "rootCtx" $ "objectType" "" "objectName" "") | indent 8 }}
  {{- end }}

  {{- if $values.policyType }}
  {{- if eq $values.policyType "ingress" }}
  policyTypes: ["Ingress"]
  {{- else if eq $values.policyType "egress" }}
  policyTypes: ["Egress"]

  {{- else if eq $values.policyType "ingress-egress" }}
  policyTypes: ["Ingress", "Egress"]
  {{- end -}}
  {{- end -}}

  {{- if $values.egress }}
  egress:
  {{- range $values.egress }}
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

  {{- if $values.ingress }}
  ingress:
  {{- range $values.ingress }}
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
