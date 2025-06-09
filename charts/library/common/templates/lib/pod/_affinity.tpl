{{/* Returns pod affinity  */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.pod.affinity" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the Pod.
*/}}
{{- define "tc.v1.common.lib.pod.affinity" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $affinity := dict -}}

  {{/* Initialize from the "global" option */}}
  {{- with $rootCtx.Values.podOptions.affinity -}}
    {{- $affinity = . -}}
  {{- end -}}

  {{/* Override with pods option */}}
  {{- with $objectData.podSpec.affinity -}}
    {{- $affinity = . -}}
  {{- end -}}

  {{/* If default affinity is enabled and its one of this types, then merge it with user input */}}
  {{- $validTypes := (list "Deployment" "StatefulSet") -}}
  {{- if and (mustHas $objectData.type $validTypes) $rootCtx.Values.podOptions.defaultAffinity }}
    {{- $defaultAffinity := (include "tc.v1.common.lib.pod.defaultAffinity" (dict "rootCtx" $rootCtx "objectData" $objectData) | fromYaml) -}}
    {{- $defaultAffinity = $defaultAffinity | default dict -}}
    {{/* Merge user input overwriting the default */}}
    {{- $affinity = mustMergeOverwrite $defaultAffinity $affinity -}}
  {{- end -}}

  {{- include "tc.v1.common.lib.pod.affinity.validation" (dict "rootCtx" $rootCtx "objectData" $affinity) -}}

  {{- if $affinity.nodeAffinity }}
nodeAffinity:
  {{- fail "TODO: not implemented" -}}
  {{- end -}}

  {{- if $affinity.podAffinity }}
podAffinity:
    {{- include "tc.v1.common.lib.pod.podAffinityOrPodAntiAffinity" (dict "rootCtx" $rootCtx "data" $affinity.podAffinity) | nindent 2 -}}
  {{- end -}}

  {{- if $affinity.podAntiAffinity }}
podAntiAffinity:
    {{- include "tc.v1.common.lib.pod.podAffinityOrPodAntiAffinity" (dict "rootCtx" $rootCtx "data" $affinity.podAntiAffinity) | nindent 2 -}}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.pod.podAffinityOrPodAntiAffinity" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $data := .data -}}

  {{- if $data -}}
    {{- if $data.requiredDuringSchedulingIgnoredDuringExecution }}
  requiredDuringSchedulingIgnoredDuringExecution:
      {{- range $term := $data.requiredDuringSchedulingIgnoredDuringExecution }}
    - {{ include "tc.v1.common.lib.pod.podAffinityTerm" (dict "rootCtx" $rootCtx "data" $term) | trim | nindent 6 }}
      {{- end -}}
    {{- end -}}

    {{- if $data.preferredDuringSchedulingIgnoredDuringExecution }}
  preferredDuringSchedulingIgnoredDuringExecution:
      {{- range $term := $data.preferredDuringSchedulingIgnoredDuringExecution }}
      - weight: {{ $term.weight }}
        podAffinityTerm:
          {{- include "tc.v1.common.lib.pod.podAffinityTerm" (dict "rootCtx" $rootCtx "data" $term.podAffinityTerm) | nindent 10 }}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.pod.podAffinityTerm" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $data := .data -}}

  {{- if $data }}
topologyKey: {{ $data.topologyKey }}

    {{- if $data.matchLabelKeys }}
matchLabelKeys:
      {{- range $data.matchLabelKeys }}
        - {{ . }}
      {{- end -}}
    {{- end -}}

    {{- if $data.mismatchLabelKeys }}
mismatchLabelKeys:
      {{- range $data.mismatchLabelKeys }}
        - {{ . }}
      {{- end -}}
    {{- end -}}

    {{- if $data.namespaces }}
namespaces:
      {{- range $data.namespaces }}
        - {{ . }}
      {{- end -}}
    {{- end -}}

    {{- if $data.labelSelector }}
labelSelector:
      {{- include "tc.v1.common.lib.pod.labelSelector" (dict "rootCtx" $rootCtx "data" $data.labelSelector) | nindent 2 -}}
    {{- end -}}

    {{- if $data.namespaceSelector }}
namespaceSelector:
      {{- include "tc.v1.common.lib.pod.labelSelector" (dict "rootCtx" $rootCtx "data" $data.namespaceSelector) | nindent 2 -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.pod.labelSelector" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $data := .data }}

  {{- if $data.matchExpressions -}}
matchExpressions:
    {{- range $expression := $data.matchExpressions }}
  - key: {{ $expression.key }}
    operator: {{ $expression.operator }}
      {{- if mustHas $expression.operator (list "In" "NotIn") }}
    values:
        {{- range $expression.values }}
      - {{ . }}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- if $data.matchLabels -}}
matchLabels:
    {{- range $key, $value := $data.matchLabels }}
  {{ $key }}: {{ $value }}
    {{- end -}}
  {{- end -}}
{{- end -}}


{{- define "tc.v1.common.lib.pod.defaultAffinity" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $selectedVolumes := (include "tc.v1.common.lib.pod.volumes.selected" (dict "rootCtx" $rootCtx "objectData" $objectData)) | fromJson }}

  {{- $names := list -}}
  {{- range $volume := $selectedVolumes.pvc -}}
    {{- $names = mustAppend $names $volume.shortName -}}
  {{- end }}

  {{- if $names }}
podAffinity:
  requiredDuringSchedulingIgnoredDuringExecution:
    - topologyKey: kubernetes.io/hostname
      labelSelector:
        matchExpressions:
          - key: truecharts.org/pvc
            operator: In
            values:
              - {{ $names | join "_" }}
  {{- end -}}
{{- end -}}
