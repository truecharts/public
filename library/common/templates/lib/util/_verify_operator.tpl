{{- define "tc.v1.common.lib.util.operator.verifyAll" -}}
  {{- if .Values.operator.verify.enabled -}}
    {{/* Go over all operators that need to be verified */}}
    {{- range $opName := .Values.operator.verify.additionalOperators -}}
      {{- $opExists := include "tc.v1.common.lib.util.operator.verify" (dict "rootCtx" $ "opName" $opName) -}}

      {{/* If the operator was not found */}}
      {{- if and (eq $opExists "false") ($.Values.operator.verify.failOnError) -}}
        {{- fail (printf "Operator [%s] have to be installed first" $opName) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.util.operator.verify" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $opName := .opName -}}
  {{- $opExists := false -}}
  {{- $operatorData := dict -}}

  {{/* Go over all configmaps */}}
  {{- range $index, $cm := (lookup "v1" "ConfigMap" "" "").items -}}
    {{- if $cm.data -}}
      {{/* If "tc-operator-name" does not exist will return "" */}}
      {{- $name := (get $cm.data "tc-operator-name") -}}
      {{- $version := (get $cm.data "tc-operator-version") -}}

      {{/* If fetched name matches the "$opName"... */}}
      {{- if eq $name $opName -}}
        {{- if $opExists -}}
          {{- fail (printf "Found duplicate configmaps for operator [%s]" $opName) -}}
        {{- end -}}
        {{/* Mark operator as found*/}}
        {{- $opExists = true -}}
        {{- $operatorData = dict "name" $name "namespace" $cm.metadata.namespace "version" $version -}}
        
      {{- end -}}
    {{- end -}}
  {{- end -}}
  
  {{/* Return the data stringified */}}
  {{- if $opExists -}}
  {{- $operatorData | toJson }}
  {{- else -}}
""
  {{- end -}}
{{- end -}}
