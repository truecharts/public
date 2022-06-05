{{/*
Blueprint for the NetworkPolicy object that can be included in the addon.
*/}}
{{- define "tc.common.class.networkpolicy" -}}
  {{- $fullName := include "tc.common.names.fullname" . -}}
  {{- $networkPolicyName := $fullName -}}
  {{- $values := .Values.networkPolicy -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.networkPolicy -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}

  {{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
    {{- $networkPolicyName = printf "%v-%v" $networkPolicyName $values.nameOverride -}}
  {{- end }}
---
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  name: {{ $networkPolicyName }}
  {{- with (merge ($values.labels | default dict) (include "tc.common.labels" $ | fromYaml)) }}
  labels: {{- toYaml . | nindent 4 }}
  {{- end }}
  {{- with (merge ($values.annotations | default dict) (include "tc.common.annotations" $ | fromYaml)) }}
  annotations:
    {{- tpl ( toYaml . ) $ | nindent 4 }}
  {{- end }}
spec:
  podSelector:
  {{- if $values.podSelector }}
  {{- with $values.podSelector }}
    {{- . | toYaml | nindent 4 }}
  {{- end -}}
  {{- else }}
    matchLabels:
    {{- include "tc.common.labels.selectorLabels" . | nindent 6 }}
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
    {{- range .to }}
    {{- $nss := false }}
    {{- $ipb := false }}
      {{- if .ipBlock }}
      {{- if .ipBlock.cidr }}
      {{- $ipb = true }}
    - ipBlock:
        cidr: {{ .ipBlock.cidr }}
      {{- if .ipBlock.except }}
        except:
        {{- range .ipBlock.except }}
        - {{ . }}
        {{- end }}
      {{- end -}}
      {{- end -}}
      {{- end -}}

      {{- if and ( .namespaceSelector ) ( not $ipb ) }}
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

      {{- if and ( .podSelector ) ( not $ipb ) }}
      {{- if or ( .podSelector.matchLabels ) ( .podSelector.matchExpressions ) }}
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

  {{- if $values.ingress }}
  ingress:
  {{- range $values.ingress }}
  - from:
    {{- range .from }}
    {{- $nss := false }}
    {{- $ipb := false }}
      {{- if .ipBlock }}
      {{- if .ipBlock.cidr }}
      {{- $ipb = true }}
    - ipBlock:
        cidr: {{ .ipBlock.cidr }}
      {{- if .ipBlock.except }}
        except:
        {{- range .ipBlock.except }}
        - {{ . }}
        {{- end }}
      {{- end -}}
      {{- end -}}
      {{- end -}}

      {{- if and ( .namespaceSelector ) ( not $ipb ) }}
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

      {{- if and ( .podSelector ) ( not $ipb ) }}
      {{- if or ( .podSelector.matchLabels ) ( .podSelector.matchExpressions ) }}
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
