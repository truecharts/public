{{/* Returns the primary service object */}}
{{- define "ix.v1.common.lib.util.serviceAccount.primary" -}}
  {{- $enabledServiceAccounts := dict -}}
  {{- range $name, $serviceAccount := .Values.serviceAccount -}}
    {{- if $serviceAccount.enabled -}}
      {{- $_ := set $enabledServiceAccounts $name . -}}
    {{- end -}}
  {{- end -}}

  {{- $result := "" -}}
  {{- range $name, $serviceAccount := $enabledServiceAccounts -}}
    {{- if (hasKey $serviceAccount "primary") -}}
      {{- if $serviceAccount.primary -}}
        {{- if $result -}}
          {{- fail "More than one serviceAccounts are set as primary. This is not supported." -}}
        {{- end -}}
        {{- $result = $name -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- $result = keys $enabledServiceAccounts | first -}}
  {{- end -}}

  {{- $result -}}
{{- end -}}
