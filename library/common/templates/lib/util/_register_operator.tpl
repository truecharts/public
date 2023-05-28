{{- define "tc.v1.common.lib.util.operator.register" -}}
  {{- if .Values.operator.register -}}
    {{- if (lookup "v1" "Namespace" "tc-system" "") -}}
      {{- with (lookup "v1" "ConfigMap" "tc-system" $.Chart.Name) -}}
        {{- fail (printf "You cannot install the [%s] operator twice..." $.Chart.Name) -}}
      {{- end -}}
    {{- end -}}

    {{- $objectData := (dict  "name"      $.Chart.Name
                              "namespace" "tc-system"
                              "data"      (dict "namespace" $.Release.Namespace
                                                "version"   $.Chart.Version)) -}}
    {{/* data.namespace   - The namespace the operator is installed in */}}
    {{/* data.version     - The version of the installed operator */}}
    {{- include "tc.v1.common.class.configmap" (dict "rootCtx" $ "objectData" $objectData) -}}
  {{- end -}}
{{- end -}}
