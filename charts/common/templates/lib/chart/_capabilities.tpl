{{/* Allow KubeVersion to be overridden. */}}
{{- define "tc.common.capabilities.ingress.kubeVersion" -}}
  {{- default .Capabilities.KubeVersion.Version .Values.kubeVersionOverride -}}
{{- end -}}

{{/* Return the appropriate apiVersion for Ingress objects */}}
{{- define "tc.common.capabilities.ingress.apiVersion" -}}
  {{- print "networking.k8s.io/v1" -}}
  {{- if semverCompare "<1.19" (include "tc.common.capabilities.ingress.kubeVersion" .) -}}
    {{- print "beta1" -}}
  {{- end -}}
{{- end -}}

{{/* Check Ingress stability */}}
{{- define "tc.common.capabilities.ingress.isStable" -}}
  {{- if eq (include "tc.common.capabilities.ingress.apiVersion" .) "networking.k8s.io/v1" -}}
    {{- true -}}
  {{- end -}}
{{- end -}}
