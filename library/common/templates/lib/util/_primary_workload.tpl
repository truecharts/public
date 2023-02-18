{{/* Returns the primary Workload object */}}
{{- define "tc.v1.common.lib.util.workload.primary" -}}
  {{- $Workloads := .workload -}}

  {{- $enabledWorkloads := dict -}}
  {{- range $name, $Workload := $Workloads -}}
    {{- if $Workload.enabled -}}
      {{- $_ := set $enabledWorkloads $name $Workload -}}
    {{- end -}}
  {{- end -}}

  {{- $result := "" -}}
  {{- range $name, $Workload := $enabledWorkloads -}}
    {{- if (hasKey $Workload "primary") -}}
      {{- if $Workload.primary -}}
        {{- if $result -}}
          {{- fail "More than one Workloads are set as primary. This is not supported." -}}
        {{- end -}}
        {{- $result = $name -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if not $result -}}
    {{- if eq (len $enabledWorkloads) 1 -}}
      {{- $result = keys $enabledWorkloads | mustFirst -}}
    {{- else -}}
      {{- if $enabledWorkloads -}}
        {{- fail "At least one Workload must be set as primary" -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- $result -}}
{{- end -}}
