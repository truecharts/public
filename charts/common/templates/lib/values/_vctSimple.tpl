{{/* Allow some extra "fake" VolumeClaimTemplate options for SCALE GUI simplification */}}
{{- define "tc.common.lib.values.volumeClaimTemplates.simple" -}}
  {{- range .Values.volumeClaimTemplates }}
  {{- if .type }}
  {{- if eq .type "simplePVC" }}
  {{- $_ := set . "type" "pvc" }}
  {{- end }}
  {{- end }}
  {{- end }}
{{- end -}}
