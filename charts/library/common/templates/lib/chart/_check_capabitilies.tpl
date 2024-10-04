{{- define "tc.v1.common.check.capabilities" -}}
  {{- $helmVersion := semver .Capabilities.HelmVersion.Version -}}
  {{- $helmMinVer := semver "3.9.4" -}}

  {{- if .Chart.Annotations -}}
    {{- $min := index .Chart.Annotations "truecharts.org/min_helm_version" -}}
    {{- if $min -}}
      {{/* Apply a relaxed version check */}}
      {{- $helmMinVer = semver $min -}}
    {{- end -}}
  {{- end -}}

  {{- if eq -1 ($helmMinVer | $helmVersion.Compare) -}}
    {{- fail (printf "Expected minimum helm version [%s], but found [%s]. Upgrade helm cli tool." $helmMinVer $helmVersion) -}}
  {{- end -}}
{{- end -}}
