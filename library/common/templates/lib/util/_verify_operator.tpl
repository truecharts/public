{{- define "tc.v1.common.lib.util.operator.verifyAll" -}}
  {{- if .Values.operator.verify.enabled -}}
    {{/* Go over all operators that need to be verified */}}
    {{- range $opName := .Values.operator.verify.additionalOperators -}}
      {{- $opExists := include "tc.v1.common.lib.util.operator.verify" (dict "rootCtx" $ "opName" $opName) -}}

      {{/* If the operator was not found */}}
      {{- if eq $opExists "false" -}}
        {{- fail (printf "Operator [%s] have to be installed first" $opName) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.util.operator.verify" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $opName := .opName -}}
  {{- $opExists := false -}}

  {{/* Go over all configmaps */}}
  {{- range $index, $cm := (lookup "v1" "ConfigMap" "" "").items -}}
    {{/* If "tc-operator-name" does not exist will return "" */}}
    {{- $name := (get $cm.data "tc-operator-name") -}}

    {{/* If fetched name matches the "$opName"... */}}
    {{- if eq $name $opName -}}
      {{/* Mark operator as found*/}}
      {{- $opExists = true -}}
    {{- end -}}
  {{- end -}}

  {{/* Return the status stringified */}}
  {{- $opExists | toString -}}
{{- end -}}
