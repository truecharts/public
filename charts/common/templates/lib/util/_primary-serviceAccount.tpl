{{/*
Return the primary serviceAccount object
*/}}
{{- define "tc.common.lib.util.serviceaccount.primary" -}}
  {{- $enabledServiceaccounts := dict -}}
  {{- range $name, $serviceAccount := .Values.serviceAccount -}}
    {{- if $serviceAccount.enabled -}}
      {{- $_ := set $enabledServiceaccounts $name . -}}
    {{- end -}}
  {{- end -}}

  {{- $result := "" -}}
  {{- range $name, $serviceAccount := $enabledServiceaccounts -}}
    {{- if and (hasKey $serviceAccount "primary") $serviceAccount.primary -}}
      {{- $result = $name -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- $result = keys $enabledServiceaccounts | first -}}
  {{- end -}}
  {{- $result -}}
{{- end -}}
