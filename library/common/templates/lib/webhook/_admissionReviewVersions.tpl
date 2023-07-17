{{- define "tc.v1.common.lib.webhook.admissionReviewVersions" -}}
  {{- $admissionReviewVersions := .admissionReviewVersions -}}
  {{- $rootCtx := .rootCtx }}
admissionReviewVersions:
  {{- range $admissionReviewVersions }}
  - {{ tpl . $rootCtx }}
  {{- end -}}
{{- end -}}
