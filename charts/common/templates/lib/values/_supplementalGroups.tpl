{{/* Append default supplementalGroups to user defined groups */}}
{{- define "tc.common.lib.values.supplementalGroups" -}}

  {{/* save supplementalGroups to placeholder variables */}}
  {{- $fixedGroups := list 568 }}
  {{- $valuegroups := list }}
  {{- $devGroups := list }}
  {{- $gpuGroups := list }}

  {{/* put user-entered supplementalgroups in placeholder variable */}}
  {{- if .Values.podSecurityContext.supplementalGroups }}
  {{- $valuegroups = .Values.podSecurityContext.supplementalGroups }}
  {{- end }}

  {{/* Append requered groups to supplementalGroups when deviceList is used */}}
  {{- if and ( .Values.deviceList ) ( .Values.global.ixChartContext ) }}
  {{- $devGroups = list 5 10 20 24 }}
  {{- end }}

  {{/* Append requered groups to supplementalGroups when scaleGPU is used */}}
  {{- if and ( .Values.scaleGPU ) ( .Values.global.ixChartContext ) }}
  {{- $gpuGroups = list 44 107 }}
  {{- end }}

  {{/* combine and write all supplementalGroups to .Values */}}
  {{- $supGroups := concat $fixedGroups $valuegroups $devGroups $gpuGroups }}
  {{- $_ := set .Values.podSecurityContext "supplementalGroups" $supGroups -}}
{{- end -}}
