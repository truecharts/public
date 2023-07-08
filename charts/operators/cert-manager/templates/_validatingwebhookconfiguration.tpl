{{- define "cert-manager.webhooks.validating" -}}
{{- if .Values.webhook.validating.create }}
{{- $cert-managerLabels := .Values.webhook.validating.labels -}}
{{- $cert-managerAnnotations := .Values.webhook.validating.annotations -}}
{{- $labels := (mustMerge ($cert-managerLabels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $ | fromYaml)) }}
{{- $annotations := (mustMerge ($cert-managerAnnotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $ | fromYaml)) }}
---
apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  name: cert-manager-validating-webhook-configuration
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end }}
  annotations:
    cert-manager.io/inject-ca-from-secret: {{ printf "%s/%s-ca" (include "cert-manager.namespace" .) (include "webhook.fullname" .) | quote}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "annotations" $annotations) | trim) }}
    {{- . | nindent 4 }}
  {{- end }}
webhooks:
  - name: webhook.cert-manager.io
    namespaceSelector:
      matchExpressions:
      - key: "cert-manager.io/disable-validation"
        operator: "NotIn"
        values:
        - "true"
    rules:
      - apiGroups:
          - "cert-manager.io"
          - "acme.cert-manager.io"
        apiVersions:
          - "v1"
        operations:
          - CREATE
          - UPDATE
        resources:
          - "*/*"
    admissionReviewVersions: ["v1"]
    # This webhook only accepts v1 cert-manager resources.
    # Equivalent matchPolicy ensures that non-v1 resource requests are sent to
    # this webhook (after the resources have been converted to v1).
    matchPolicy: Equivalent
    timeoutSeconds: {{ .Values.webhook.timeoutSeconds }}
    failurePolicy: Fail
    sideEffects: None
    clientConfig:
      {{- if .Values.webhook.url.host }}
      url: https://{{ .Values.webhook.url.host }}/validate
      {{- else }}
      service:
        name: {{ template "webhook.fullname" . }}
        namespace: {{ include "cert-manager.namespace" . }}
        path: /validate
{{- end }}
{{- end -}}
