{{- define "tc.v1.common.lib.chart.notes" -}}

  {{- include "tc.v1.common.lib.chart.header" . -}}

  {{- include "tc.v1.common.lib.chart.custom" . -}}

  {{- include "tc.v1.common.lib.chart.footer" . -}}

  {{- include "tc.v1.common.lib.chart.warnings" . -}}

{{- end -}}

{{- define "tc.v1.common.lib.chart.header" -}}
  {{- tpl $.Values.notes.header $ | nindent 0 }}
{{- end -}}

{{- define "tc.v1.common.lib.chart.custom" -}}
  {{- tpl $.Values.notes.custom $ | nindent 0 }}
{{- end -}}

{{- define "tc.v1.common.lib.chart.footer" -}}
  {{- tpl $.Values.notes.footer $ | nindent 0 }}
{{- end -}}

{{- define "tc.v1.common.lib.chart.warnings" -}}
  {{- range $w := $.Values.notes.warnings }}
    {{- tpl $w $ | nindent 0 }}
  {{- end }}
{{- end -}}

{{- define "add.warning" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $warn := .warn -}}

  {{- $newWarns := $rootCtx.Values.notes.warnings -}}
  {{- $newWarns = mustAppend $newWarns $warn -}}
  {{- $_ := set $rootCtx.Values.notes "warnings" $newWarns -}}
{{- end -}}
