{{- define "promop.webhooks.mutating" -}}
{{- if .Values.prometheusOperator.admissionWebhooks.enabled }}
{{- $promopLabels := .Values.prometheusOperator.admissionWebhooks.labels -}}
{{- $promopAnnotations := .Values.prometheusOperator.admissionWebhooks.annotations -}}
{{- $labels := (mustMerge ($promopLabels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $ | fromYaml)) }}
{{- $annotations := (mustMerge ($promopAnnotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $ | fromYaml)) }}
---
apiVersion: admissionregistration.k8s.io/v1
kind: MutatingWebhookConfiguration
metadata:
  name:  {{ include "tc.v1.common.lib.chart.names.fullname" $ }}-admission
  labels:
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "labels" $labels) | trim) }}
    app: {{ include "tc.v1.common.lib.chart.names.fullname" $ }}-admission
    {{- . | nindent 4 }}
  {{- end }}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
webhooks:
  - name: prometheusrulemutate.monitoring.coreos.com
    {{- if eq .Values.prometheusOperator.admissionWebhooks.failurePolicy "IgnoreOnInstallOnly" }}
    failurePolicy: {{ .Release.IsInstall | ternary "Ignore" "Fail" }}
    {{- else if .Values.prometheusOperator.admissionWebhooks.failurePolicy  }}
    failurePolicy: {{ .Values.prometheusOperator.admissionWebhooks.failurePolicy }}
    {{- else if .Values.prometheusOperator.admissionWebhooks.patch.enabled }}
    failurePolicy: Ignore
    {{- else }}
    failurePolicy: Fail
    {{- end }}
    rules:
      - apiGroups:
          - monitoring.coreos.com
        apiVersions:
          - "*"
        resources:
          - prometheusrules
        operations:
          - CREATE
          - UPDATE
    clientConfig:
      service:
        namespace: {{ .Release.Namespace }}
        name: {{ include "tc.v1.common.lib.chart.names.fullname" $ }}
        path: /admission-prometheusrules/mutate
      {{- if and .Values.prometheusOperator.admissionWebhooks.caBundle (not .Values.prometheusOperator.admissionWebhooks.patch.enabled) (not .Values.prometheusOperator.admissionWebhooks.certManager.enabled) }}
      caBundle: {{ .Values.prometheusOperator.admissionWebhooks.caBundle }}
      {{- end }}
    timeoutSeconds: {{ .Values.prometheusOperator.admissionWebhooks.timeoutSeconds }}
    admissionReviewVersions: ["v1", "v1beta1"]
    sideEffects: None
    {{- if or .Values.prometheusOperator.denyNamespaces .Values.prometheusOperator.namespaces }}
    namespaceSelector:
      matchExpressions:
      {{- if .Values.prometheusOperator.denyNamespaces }}
      - key: kubernetes.io/metadata.name
        operator: NotIn
        values:
        {{- range $namespace := mustUniq .Values.prometheusOperator.denyNamespaces }}
        - {{ $namespace }}
        {{- end }}
      {{- else if and .Values.prometheusOperator.namespaces .Values.prometheusOperator.namespaces.additional }}
      - key: kubernetes.io/metadata.name
        operator: In
        values:
        {{- if and .Values.prometheusOperator.namespaces.releaseNamespace (default .Values.prometheusOperator.namespaces.releaseNamespace true) }}
        {{- $namespace := .Release.Namespace }}
        - {{ $namespace }}
        {{- end }}
        {{- range $namespace := mustUniq .Values.prometheusOperator.namespaces.additional }}
        - {{ $namespace }}
        {{- end }}
      {{- end }}
    {{- end }}
{{- end }}
{{- end -}}
