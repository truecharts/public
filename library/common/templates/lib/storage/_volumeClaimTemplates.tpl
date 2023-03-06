{{/* Returns Volume Claim Templates */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.storage.volumeClaimTemplates" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.storage.volumeClaimTemplates" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- range $name, $vctValues := $rootCtx.Values.volumeClaimTemplates -}}

    {{- if $vctValues.enabled -}}
      {{- $vct := (mustDeepCopy $vctValues) -}}

      {{- $selected := false -}}
      {{- $_ := set $vct "shortName" $name -}}

      {{- include "tc.v1.common.lib.vct.validation" (dict "objectData" $vct) -}}
      {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $vct.shortName) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $vct "caller" "Volume Claim Templates") -}}

      {{/* If targetSelector is set, check if pod is selected */}}
      {{- if $vct.targetSelector -}}
        {{- if (mustHas $objectData.shortName (keys $vct.targetSelector)) -}}
          {{- $selected = true -}}
        {{- end -}}

      {{/* If no targetSelector is set or targetSelectAll, check if pod is primary */}}
      {{- else -}}
        {{- if $objectData.primary -}}
          {{- $selected = true -}}
        {{- end -}}
      {{- end -}}

      {{/* If pod selected */}}
      {{- if $selected -}}
        {{- $vctSize := $rootCtx.Values.fallbackDefaults.vctSize -}}
        {{- with $vct.size -}}
          {{- $vctSize = tpl . $rootCtx -}}
        {{- end }}
- metadata:
    name: {{ $vct.shortName }}
    {{- $labels := $vct.labels | default dict -}}
    {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
    labels:
      {{- . | nindent 6 }}
    {{- end -}}
    {{- $annotations := $vct.annotations | default dict -}}
    {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
    annotations:
      {{- . | nindent 6 }}
    {{- end }}
  spec:
    {{- with (include "tc.v1.common.lib.storage.storageClassName" (dict "rootCtx" $rootCtx "objectData" $vct "caller" "Volume Claim Templates") | trim) }}
    storageClassName: {{ . }}
    {{- end }}
    accessModes:
      {{- include "tc.v1.common.lib.pvc.accessModes" (dict "rootCtx" $rootCtx "objectData" $vct "caller" "Volume Claim Templates") | trim | nindent 6 }}
    resources:
      requests:
        storage: {{ $vctSize }}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
