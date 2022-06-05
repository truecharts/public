{{/* Allow some extra "fake" persistence options for SCALE GUI simplification */}}
{{- define "tc.common.lib.values.persistence.simple" -}}
  {{- range .Values.persistence }}
  {{- if .type }}
  {{- if eq .type "simplePVC" }}
  {{- $_ := set . "type" "pvc" }}
  {{- end }}
  {{- if eq .type "simpleHP" }}
  {{- $_ := set . "type" "hostPath" }}
  {{- if .setPermissionsSimple }}
  {{- $_ := set . "setPermissions" .setPermissionsSimple }}
  {{- end }}
  {{- if .hostPathSimple }}
  {{- $_ := set . "hostPath" .hostPathSimple }}
  {{- end }}
  {{- end }}
  {{- end }}
  {{- end }}
{{- end -}}
