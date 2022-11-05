{{/* load all list to dict injectors */}}
{{- define "tc.common.loader.lists" -}}

  {{ include "tc.common.lib.values.controller.label.list" . }}
  {{ include "tc.common.lib.values.controller.annotations.list" . }}

  {{ include "tc.common.lib.values.pod.label.list" . }}
  {{ include "tc.common.lib.values.pod.annotations.list" . }}

  {{ include "tc.common.lib.values.persistence.list" . }}
  {{ include "tc.common.lib.values.persistence.label.list" . }}
  {{ include "tc.common.lib.values.persistence.annotations.list" . }}

  {{ include "tc.common.lib.values.service.list" . }}
  {{ include "tc.common.lib.values.ports.list" . }}

  {{ include "tc.common.lib.values.ingress.list" . }}
  {{ include "tc.common.lib.values.ingress.label.list" . }}
  {{ include "tc.common.lib.values.ingress.annotations.list" . }}

{{- end -}}
