{{/* Returns if there are any auto-permissions enabled */}}
{{- define "tc.v1.common.lib.util.autoperms.detect" -}}
{{- $autoperms := false -}}
{{- range $name, $mount := .Values.persistence -}}
  {{- if and $mount.enabled $mount.setPermissions -}}
      {{- if $mount.readOnly -}}
        {{- fail (printf "You cannot automatically set Permissions with readOnly enabled") -}}
      {{- end -}}
    {{- $autoperms = true -}}
  {{- end -}}
{{- end }}
{{- $autoperms -}}
{{- end -}}
