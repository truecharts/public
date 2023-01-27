{{- define "tc.v1.common.loader.apply" -}}
  {{- include "tc.v1.common.spawner.ingress" . | nindent 0 -}}

  {{- include "tc.v1.common.spawner.hpa" . | nindent 0 -}}

  {{- include "tc.v1.common.spawner.networkpolicy" . | nindent 0 -}}

  {{- include "tc.v1.common.spawner.metrics" . | nindent 0 -}}

  {{- include "tc.v1.common.spawner.certificate" . | nindent 0 -}}

{{- end -}}
