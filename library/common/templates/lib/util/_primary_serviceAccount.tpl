{{/* Returns the primary service object */}}
{{- define "ix.v1.common.lib.util.serviceAccount.primary" -}}
  {{- $enabledServiceAccounts := dict -}}
  {{- range $name, $serviceAccount := .Values.serviceAccount -}}
    {{- if $serviceAccount.enabled -}}
      {{- $_ := set $enabledServiceAccounts $name $serviceAccount -}}
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
    {{- if eq (len $enabledServiceAccounts) 1 -}}
      {{- $result = keys $enabledServiceAccounts | mustFirst -}}
    {{- else -}}
      {{- if $enabledServiceAccounts -}}
        {{- fail "At least one Service Account must be set as primary" -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- $result -}}
{{- end -}}
