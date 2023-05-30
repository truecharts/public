{{- define "metallb.webhooks" -}}
{{- $labels := (include "tc.v1.common.lib.metadata.allLabels" $ | fromYaml) }}
---
apiVersion: admissionregistration.k8s.io/v1
kind: ValidatingWebhookConfiguration
metadata:
  name: metallb-webhook-configuration
  labels:
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "labels" $labels) | trim) }}
    {{- . | nindent 4 }}
  {{- end }}
webhooks:
- admissionReviewVersions:
  - v1
  clientConfig:
    service:
      name: main
      namespace: {{ .Release.Namespace }}
      path: /validate-metallb-io-v1beta1-addresspool
  failurePolicy: {{ .Values.validationFailurePolicy }}
  name: addresspoolvalidationwebhook.metallb.io
  rules:
  - apiGroups:
    - metallb.io
    apiVersions:
    - v1beta1
    operations:
    - CREATE
    - UPDATE
    resources:
    - addresspools
  sideEffects: None
- admissionReviewVersions:
  - v1
  clientConfig:
    service:
      name: main
      namespace: {{ .Release.Namespace }}
      path: /validate-metallb-io-v1beta2-bgppeer
  failurePolicy: {{ .Values.validationFailurePolicy }}
  name: bgppeervalidationwebhook.metallb.io
  rules:
  - apiGroups:
    - metallb.io
    apiVersions:
    - v1beta2
    operations:
    - CREATE
    - UPDATE
    resources:
    - bgppeers
  sideEffects: None
- admissionReviewVersions:
  - v1
  clientConfig:
    service:
      name: main
      namespace: {{ .Release.Namespace }}
      path: /validate-metallb-io-v1beta1-ipaddresspool
  failurePolicy: {{ .Values.validationFailurePolicy }}
  name: ipaddresspoolvalidationwebhook.metallb.io
  rules:
  - apiGroups:
    - metallb.io
    apiVersions:
    - v1beta1
    operations:
    - CREATE
    - UPDATE
    resources:
    - ipaddresspools
  sideEffects: None
- admissionReviewVersions:
  - v1
  clientConfig:
    service:
      name: main
      namespace: {{ .Release.Namespace }}
      path: /validate-metallb-io-v1beta1-bgpadvertisement
  failurePolicy: {{ .Values.validationFailurePolicy }}
  name: bgpadvertisementvalidationwebhook.metallb.io
  rules:
  - apiGroups:
    - metallb.io
    apiVersions:
    - v1beta1
    operations:
    - CREATE
    - UPDATE
    resources:
    - bgpadvertisements
  sideEffects: None
- admissionReviewVersions:
  - v1
  clientConfig:
    service:
      name: main
      namespace: {{ .Release.Namespace }}
      path: /validate-metallb-io-v1beta1-community
  failurePolicy: {{ .Values.validationFailurePolicy }}
  name: communityvalidationwebhook.metallb.io
  rules:
  - apiGroups:
    - metallb.io
    apiVersions:
    - v1beta1
    operations:
    - CREATE
    - UPDATE
    resources:
    - communities
  sideEffects: None
- admissionReviewVersions:
  - v1
  clientConfig:
    service:
      name: main
      namespace: {{ .Release.Namespace }}
      path: /validate-metallb-io-v1beta1-bfdprofile
  failurePolicy: {{ .Values.validationFailurePolicy }}
  name: bfdprofilevalidationwebhook.metallb.io
  rules:
  - apiGroups:
    - metallb.io
    apiVersions:
    - v1beta1
    operations:
    - CREATE
    - DELETE
    resources:
    - bfdprofiles
  sideEffects: None
- admissionReviewVersions:
  - v1
  clientConfig:
    service:
      name: main
      namespace: {{ .Release.Namespace }}
      path: /validate-metallb-io-v1beta1-l2advertisement
  failurePolicy: {{ .Values.validationFailurePolicy }}
  name: l2advertisementvalidationwebhook.metallb.io
  rules:
  - apiGroups:
    - metallb.io
    apiVersions:
    - v1beta1
    operations:
    - CREATE
    - UPDATE
    resources:
    - l2advertisements
  sideEffects: None
---
apiVersion: v1
kind: Secret
metadata:
  name: webhook-server-cert
  labels:
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "labels" $labels) | trim) }}
    {{- . | nindent 4 }}
  {{- end }}
{{- $secretObj := (lookup "v1" "Secret" .Release.Namespace "webhook-server-cert") }}
{{- if $secretObj }}
{{- $secretData := (get $secretObj "data") | default dict }}
data: {{ $secretData }}
{{- end }}
---
apiVersion: v1
kind: Secret
metadata:
  name: memberlist
  labels:
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "labels" $labels) | trim) }}
    {{- . | nindent 4 }}
  {{- end }}
{{- $secretObj2 := (lookup "v1" "Secret" .Release.Namespace "memberlist") }}
{{- if $secretObj2 }}
{{- $secretData2 := (get $secretObj "data") | default dict }}
data: {{ $secretData2 }}
{{- end }}
{{- end -}}
