{{- define "tc.v1.common.check.capabilities" -}}
  {{- $helmVersion := .Capabilities.HelmVersion.Version -}}
  {{- $helmVerCond := ">3.9.4" -}}

  {{- if .Chart.Annotations -}}
    {{- $min := index .Chart.Annotations "truecharts.org/min_helm_version" -}}
    {{- if $min -}}
      {{/* Apply a relaxed version check */}}
      {{- $helmVerCond = printf ">=%s" $min -}}
    {{- end -}}
  {{- end -}}

  {{- if not (semverCompare $helmVerCond $helmVersion) -}}
    {{- fail (printf "Expected helm version [%s], but found [%s]. Upgrade helm cli tool." $helmVerCond $helmVersion) -}}
  {{- end -}}
{{- end -}}
