{{- define "tc.v1.common.lib.util.operator.register" -}}
  {{- if .Values.operator.register -}}

    {{/* If it is an install operator check the operator does not exist */}}
    {{/* We do not want to fail on upgrades, as the operator will always be present */}}
    {{- if $.Release.IsInstall -}}
      {{- $opExists := include "tc.v1.common.lib.util.operator.verify" (dict "rootCtx" $ "opName" $.Chart.Name) -}}
      {{/* If the operator exists, fail to continue */}}
      {{- if eq $opExists "true" -}}
        {{- fail (printf "Operator [%v] is already installed. Can only be installed once" $.Chart.Name) -}}
      {{- end -}}
    {{- end -}}

    {{/* Create/Update the ConfigMap */}}
    {{- $objectData := (dict  "enabled" true
                              "data"  (dict "tc-operator-name"    $.Chart.Name
                                            "tc-operator-version" $.Chart.Version)) -}}
    {{/* data.tc-operator-name      - The name the operator */}}
    {{/* data.tc-operator-version   - The version of the installed operator */}}

    {{/* Create a configmap with the above data */}}
    {{/* Name will be expanded to "release-name-chart-name-tc-data" */}}
    {{- $_ := set $.Values.configmap "tc-data" $objectData -}}
  {{- end -}}
{{- end -}}
