{{- define "tc.v1.common.lib.util.operator.verifyAll" -}}
  {{- if .Values.operator.verify.enabled -}}
    {{/* Go over all operators that need to be verified */}}
    {{- $operatorList := .Values.operator.verify.additionalOperators -}}

    {{- $cnpg := false -}}
    {{- range $opName := .Values.cnpg -}}
      {{- if .enabled -}}
        {{- $cnpg := true -}}
      {{- end -}}
    {{- end -}}
    {{- if $cnpg -}}
      {{- $operatorList = mustAppend $operatorList "cloudnative-pg" -}}
    {{- end -}}

    {{- $ingress := false -}}
    {{- range $opName := .Values.ingress -}}
      {{- if .enabled -}}
        {{- $ingress := true -}}
      {{- end -}}
    {{- end -}}
    {{- if $ingress -}}
      {{- $operatorList = mustAppend $operatorList "traefik" -}}
    {{- end -}}

    {{- $metrics := false -}}
    {{- range $opName := .Values.metrics -}}
      {{- if .enabled -}}
        {{- $metrics := true -}}
      {{- end -}}
    {{- end -}}
    {{- if $metrics -}}
      {{- $operatorList = mustAppend $operatorList "prometheus-operator" -}}
    {{- end -}}

    {{- range $opName := $operatorList -}}
      {{- $fetchedOpData := include "tc.v1.common.lib.util.operator.verify" (dict "rootCtx" $ "opName" $opName) -}}

      {{/* If the operator was not found */}}
      {{- if eq $fetchedOpData "false" -}}
        {{/* Fail only if explicitly asked */}}
        {{- if $.Values.operator.verify.failOnError -}}
          {{- fail (printf "Operator [%s] have to be installed first" $opName) -}}
        {{- end -}}
      {{/* If $fetchedOpData is not false, we should have JSON data */}}
      {{- else -}}
        {{- $opData := ($fetchedOpData | fromJson) -}}
        {{- $_ := set $.Values.operator $opName $opData -}}

        {{/* Prepare the data for the cache ConfigMap */}}
        {{- $cacheDataWrite := (dict "enabled" true "data" $opData) -}}
        {{/* Create/Update the Configmap - ConfigMap name will be expanded to "$fullname-operator-$opName" */}}
        {{- $_ := set $.Values.configmap (printf "operator-%s" $opName) $cacheDataWrite -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.util.operator.verify" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $opName := .opName -}}

  {{- $opExists := false -}}
  {{- $opData := dict -}}
  {{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $rootCtx) -}}
  {{- $cache := (lookup "v1" "ConfigMap" $rootCtx.Release.Namespace (printf "%v-operator-%v" $fullname $opName)) | default dict -}}

  {{- if $cache.data -}}
    {{/* Fetch data that the operator itself stored in the tc-data configmap */}}
    {{- $viaCache := (lookup "v1" "ConfigMap" $cache.data.namespace (printf "%v-tc-data" $fullname)) | default dict -}}
    {{- if $viaCache -}}
      {{- if not $viaCache.data -}}
        {{- fail (printf "Operator - Expected [tc-data] ConfigMap to have non-empty [data] for operator [%v]" $opName) -}}
      {{- end -}}

      {{- $name := (get $viaCache.data "tc-operator-name") -}}
      {{- $version := (get $viaCache.data "tc-operator-version") -}}

      {{/* If fetched name does not matches the "$opName"... */}}
      {{- if ne $name $opName -}}
        {{- fail (printf "Operator - ConfigMap [tc-data] does not contain the operator [%v] name. Something went wrong." $opName) -}}
      {{- end -}}

      {{/* If matches continue and mark operator as found */}}
      {{- $opExists = true -}}
      {{/* Prepare the data */}}
      {{- $opData = (dict "name" $name
                          "namespace" $viaCache.metadata.namespace
                          "version" $version) -}}
    {{- end -}}
  {{- end -}}

  {{/* Go over all configmaps */}}
  {{- if not $opExists -}}
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
          {{- $opData = (dict "name" $name
                              "namespace" $cm.metadata.namespace
                              "version" $version) -}}

        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if $opExists -}} {{/* If operator was found, return its data as JSON */}}
    {{- $opData | toJson -}}
  {{- else -}} {{/* If operator was not found, return stringified false */}}
    {{- $opExists | toString -}}
  {{- end -}}
{{- end -}}
