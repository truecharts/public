{{/* Main entrypoint for the library */}}
{{- define "tc.v1.common.loader.all" -}}

  {{- include "tc.v1.common.loader.init" . -}}

  {{- include "tc.v1.common.loader.apply" . -}}

{{- end -}}
