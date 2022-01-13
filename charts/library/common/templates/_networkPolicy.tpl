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
      {{- if .ipBlock }}
      {{- if .ipBlock.cidr }}
    - ipBlock:
        cidr: {{ .ipBlock.cidr }}
      {{- if .ipBlock.except }}
        except:
        {{ range .ipBlock.except }}
        - {{ . }}
        {{- end }}
      {{- end -}}
      {{- end -}}
      {{- end -}}

      {{- if .namespaceSelector }}
      {{- if or ( .namespaceSelector.matchLabels ) ( .namespaceSelector.matchExpressions ) }}
      namespaceSelector:
        {{- .namespaceSelector | toYaml | nindent 8 }}
      {{- end -}}
      {{- end -}}

      {{- if .podSelector }}
      {{- if or ( .podSelector.matchLabels ) ( .podSelector.matchExpressions ) }}
      podSelector:
        {{- .podSelector | toYaml | nindent 8 }}
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
    {{- range .to }}
      {{- if .ipBlock }}
      {{- if .ipBlock.cidr }}
    - ipBlock:
        cidr: {{ .ipBlock.cidr }}
      {{- if .ipBlock.except }}
        except:
        {{ range .ipBlock.except }}
        - {{ . }}
        {{- end }}
      {{- end -}}
      {{- end -}}
      {{- end -}}

      {{- if .namespaceSelector }}
      {{- if or ( .namespaceSelector.matchLabels ) ( .namespaceSelector.matchExpressions ) }}
      namespaceSelector:
        {{- .namespaceSelector | toYaml | nindent 8 }}
      {{- end -}}
      {{- end -}}

      {{- if .podSelector }}
      {{- if or ( .podSelector.matchLabels ) ( .podSelector.matchExpressions ) }}
      podSelector:
        {{- .podSelector | toYaml | nindent 8 }}
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
