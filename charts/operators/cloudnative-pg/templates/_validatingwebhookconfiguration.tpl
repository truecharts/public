{{- define "cnpg.webhooks.validating" -}}
{{- if .Values.webhook.validating.create }}
{{- $cnpgLabels := .Values.webhook.validating.labels -}}
{{- $cnpgAnnotations := .Values.webhook.validating.annotations -}}
{{- $labels := (mustMerge ($cnpgLabels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $ | fromYaml)) }}
{{- $annotations := (mustMerge ($cnpgAnnotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $ | fromYaml)) }}
---
apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  name: cnpg-validating-webhook-configuration
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end }}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
webhooks:
- admissionReviewVersions:
  - v1
  clientConfig:
    service:
      name: cnpg-webhook-service
      namespace: {{ .Release.Namespace }}
      path: /validate-postgresql-cnpg-io-v1-backup
      port: 9443
  failurePolicy: {{ .Values.webhook.validating.failurePolicy }}
  name: vbackup.kb.io
  rules:
  - apiGroups:
    - postgresql.cnpg.io
    apiVersions:
    - v1
    operations:
    - CREATE
    - UPDATE
    resources:
    - backups
  sideEffects: None
- admissionReviewVersions:
  - v1
  clientConfig:
    service:
      name: cnpg-webhook-service
      namespace: {{ .Release.Namespace }}
      path: /validate-postgresql-cnpg-io-v1-cluster
      port: 443
  failurePolicy: {{ .Values.webhook.validating.failurePolicy }}
  name: vcluster.kb.io
  rules:
  - apiGroups:
    - postgresql.cnpg.io
    apiVersions:
    - v1
    operations:
    - CREATE
    - UPDATE
    resources:
    - clusters
  sideEffects: None
- admissionReviewVersions:
  - v1
  clientConfig:
    service:
      name: cnpg-webhook-service
      namespace: {{ .Release.Namespace }}
      path: /validate-postgresql-cnpg-io-v1-scheduledbackup
      port: 443
  failurePolicy: {{ .Values.webhook.validating.failurePolicy }}
  name: vscheduledbackup.kb.io
  rules:
  - apiGroups:
    - postgresql.cnpg.io
    apiVersions:
    - v1
    operations:
    - CREATE
    - UPDATE
    resources:
    - scheduledbackups
  sideEffects: None
- admissionReviewVersions:
    - v1
  clientConfig:
    service:
      name: cnpg-webhook-service
      namespace: {{ .Release.Namespace }}
      path: /validate-postgresql-cnpg-io-v1-pooler
      port: 443
  failurePolicy: {{ .Values.webhook.validating.failurePolicy }}
  name: vpooler.kb.io
  rules:
    - apiGroups:
        - postgresql.cnpg.io
      apiVersions:
        - v1
      operations:
        - CREATE
        - UPDATE
      resources:
        - poolers
  sideEffects: None
{{- end }}
{{- end -}}
