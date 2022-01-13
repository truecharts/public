{{/*
Blueprint for the NetworkPolicy object that can be included in the addon.
*/}}
{{- define "common.networkpolicy" -}}
{{- if .Values.networkPolicy.enabled }}
---
kind: NetworkPolicy
apiVersion: networking.k8s.io/v1
metadata:
  labels:
    {{- include "common.labels" . | nindent 4 }}
  name: {{ include "common.names.fullname" . }}
spec:
  podSelector:
  {{- if .Values.networkPolicy.podSelector }}
  {{- with .Values.networkPolicy.podSelector }}
    {{- . | toYaml | nindent 4 }}
  {{- end -}}
  {{- else }}
    matchLabels:
    {{- include "common.labels.selectorLabels" . | nindent 6 }}
  {{- end }}

  {{- if .Values.networkPolicy.policyType }}
  {{- if eq .Values.networkPolicy.policyType "ingress" }}
  policyTypes: ["Ingress"]
  {{- else if eq .Values.networkPolicy.policyType "egress" }}
  policyTypes: ["Egress"]

  {{- else if eq .Values.networkPolicy.policyType "ingress-egress" }}
  policyTypes: ["Ingress", "Egress"]
  {{- end -}}
  {{- end -}}

  {{- if .Values.networkPolicy.egress }}
  egress:
  {{- range .Values.networkPolicy.egress }}
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

  {{- if .Values.networkPolicy.ingress }}
  ingress:
  {{- range .Values.networkPolicy.ingress }}
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
{{- end -}}
