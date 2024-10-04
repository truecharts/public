{{/* Returns projected Volume */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.volume.projected" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the volume.
*/}}
{{- define "tc.v1.common.lib.pod.volume.projected" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- if not $objectData.sources -}}
    {{- fail "Persistence - Expected non-empty [sources] on [projected] type" -}}
  {{- end -}}

  {{- $defMode := "" -}}
  {{- if (and $objectData.defaultMode (not (kindIs "string" $objectData.defaultMode))) -}}
    {{- fail (printf "Persistence - Expected [defaultMode] to be [string], but got [%s]" (kindOf $objectData.defaultMode)) -}}
  {{- end -}}

  {{- with $objectData.defaultMode -}}
    {{- $defMode = tpl $objectData.defaultMode $rootCtx -}}
  {{- end -}}

  {{- if and $defMode (not (mustRegexMatch "^[0-9]{4}$" $defMode)) -}}
    {{- fail (printf "Persistence - Expected [defaultMode] to have be in format of [\"0777\"], but got [%q]" $defMode) -}}
  {{- end -}}
  {{- $allowedSources := (list "clusterTrustBundle" "configMap" "downwardAPI" "secret" "serviceAccountToken") }}
- name: {{ $objectData.shortName }}
  projected:
    {{- with $defMode }}
    defaultMode: {{ . }}
    {{- end }}
    sources:
    {{- range $source := $objectData.sources -}}
      {{- if gt ($source | keys | len) 1 -}}
        {{- fail "Persistence - Expected only one source type per item in [projected] volume" -}}
      {{- end -}}

      {{- $k := $source | keys | first -}}
      {{- $v := (get $source $k) -}}

      {{- if eq $k "serviceAccountToken" }}
        {{- include "tc.v1.common.lib.pod.volume.projected.serviceAccountToken" (dict "rootCtx" $rootCtx "source" $v) | nindent 6 }}
      {{- else if or (eq $k "secret") (eq $k "configMap") }}
        {{- include "tc.v1.common.lib.pod.volume.projected.cm-secret" (dict "rootCtx" $rootCtx "source" $v "type" $k) | nindent 6 }}
      {{- else if eq $k "downwardAPI" }}
        {{- include "tc.v1.common.lib.pod.volume.projected.downwardAPI" (dict "rootCtx" $rootCtx "source" $v) | nindent 6 }}
      {{- else if eq $k "clusterTrustBundle" }}
        {{- include "tc.v1.common.lib.pod.volume.projected.clusterTrustBundle" (dict "rootCtx" $rootCtx "source" $v) | nindent 6 }}
      {{- else -}}
        {{- fail (printf "Persistence - Invalid source type [%s] for projected. Valid sources are [%s]" $k (join ", " $allowedSources)) -}}
      {{- end -}}
    {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.pod.volume.projected.serviceAccountToken" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $source := .source -}}

  {{- if hasKey $source "expirationSeconds" -}}
    {{- if lt ($source.expirationSeconds | int) 600 -}}
      {{- fail (printf "Persistence - Expected [expirationSeconds] to be greater than 600 seconds, but got [%v]" $source.expirationSeconds) -}}
    {{- end -}}
  {{- end -}}

  {{- if not $source.path -}}
    {{- fail "Persistence - Expected non-empty [path] on [serviceAccountToken] type" -}}
  {{- end -}}
- serviceAccountToken:
  {{- with $source.audience }}
    audience: {{ tpl . $rootCtx }}
  {{- end -}}
  {{- with $source.expirationSeconds }}
    expirationSeconds: {{ . }}
  {{- end }}
    path: {{ tpl $source.path $rootCtx }}
{{- end -}}

{{- define "tc.v1.common.lib.pod.volume.projected.downwardAPI" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $source := .source -}}

  {{- if not (kindIs "map" $source) -}}
    {{- fail (printf "Persistence - Expected [downwardAPI] in [sources] to be a map on [downwardAPI] type, but got [%s]" (kindOf $source)) -}}
  {{- end -}}

  {{- if not $source.items -}}
    {{- fail "Persistence - Expected non-empty [items] on [downwardAPI] type" -}}
  {{- end }}
- downwardAPI:
    items:
  {{- $allowedItems := (list "fieldRef" "resourceFieldRef") }}
  {{- range $item := $source.items -}}
    {{- if not $item.path -}}
      {{- fail "Persistence - Expected non-empty [path] on item in [downwardAPI] type" -}}
    {{- end }}
    - path: {{ tpl $item.path $rootCtx }}
    {{- if hasKey $item "fieldRef" }}
      {{- if not $item.fieldRef.fieldPath -}}
        {{- fail "Persistence - Expected non-empty [fieldPath] under [fieldRef] on item in [downwardAPI] type" -}}
      {{- end }}
      fieldRef:
        {{- with $item.fieldRef.apiVersion }}
        apiVersion: {{ tpl . $rootCtx }}
        {{- end }}
        fieldPath: {{ tpl $item.fieldRef.fieldPath $rootCtx }}
    {{- else if hasKey $item "resourceFieldRef" }}
      {{- if not $item.resourceFieldRef.containerName -}}
        {{- fail "Persistence - Expected non-empty [containerName] under [resourceFieldRef] on item in [downwardAPI] type" -}}
      {{- end -}}
      {{- if not $item.resourceFieldRef.resource -}}
        {{- fail "Persistence - Expected non-empty [resource] under [resourceFieldRef] on item in [downwardAPI] type" -}}
      {{- end }}
      resourceFieldRef:
        resource: {{ tpl $item.resourceFieldRef.resource $rootCtx }}
        containerName: {{ tpl $item.resourceFieldRef.containerName $rootCtx }}
        {{- if hasKey $item.resourceFieldRef "divisor" }}
        divisor: {{ $item.resourceFieldRef.divisor }}
        {{- end -}}
    {{- else -}}
      {{- fail (printf "Persistence - Expected item in downwardAPI to have one of [%s] keys. But found [%s]" (join ", " $allowedItems) (join ", " ($item | keys | sortAlpha))) -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.pod.volume.projected.cm-secret" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $source := .source -}}
  {{- $type := .type -}}

  {{- if not $source.objectName -}}
    {{- fail (printf "Persistence - Expected non-empty [objectName] on [%s] type" $type) -}}
  {{- end -}}

  {{- if not $source.items -}}
    {{- fail (printf "Persistence - Expected non-empty [items] on [%s] type" $type) -}}
  {{- end -}}

  {{- if not (kindIs "slice" $source.items) -}}
    {{- fail (printf "Persistence - Expected [items] to be a slice on [%s] type, but got [%s]" $type (kindOf $source.items)) -}}
  {{- end -}}

  {{- $objectName := tpl $source.objectName $rootCtx -}}

  {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
                  "rootCtx" $rootCtx "objectData" $source
                  "name" $source.objectName "caller" "Persistence - Projected"
                  "key" "persistence")) -}}
  {{- $ltype := $type | lower -}}
  {{- if eq $expandName "true" -}}
    {{- $object := (get (get $rootCtx.Values $ltype) $objectName) -}}
    {{- if and (not $object) (not $source.optional) -}}
      {{- fail (printf "Persistence - Expected %s [%s] defined in [objectName] to exist" $ltype $objectName) -}}
    {{- end -}}

    {{- $objectName = (printf "%s-%s" (include "tc.v1.common.lib.chart.names.fullname" $rootCtx) $objectName) -}}
  {{- end }}
- {{ $type }}:
    name: {{ $objectName }}
    {{- if hasKey $source "optional" }}
    optional: {{ $source.optional }}
    {{- end }}
    items:
    {{- range $item := $source.items -}}
      {{- if not $item.key -}}
        {{- fail (printf "Persistence - Expected non-empty [key] on item in [%s] type" $type) -}}
      {{- end -}}
      {{- if not $item.path -}}
        {{- fail (printf "Persistence - Expected non-empty [path] on item in [%s] type" $type) -}}
      {{- end }}
      - key: {{ tpl $item.key $rootCtx }}
        path: {{ tpl $item.path $rootCtx }}
    {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.pod.volume.projected.clusterTrustBundle" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $source := .source -}}

  {{- fail "Persistence - Key [clusterTrustBundle] is not yet implemented in [projected type]" -}}
{{- end -}}
