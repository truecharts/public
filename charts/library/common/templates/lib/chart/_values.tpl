{{/* Merge the local chart values and the common chart defaults */}}
{{- define "common.values.setup" -}}
  {{- if .Values.common -}}
    {{- $defaultValues := deepCopy .Values.common -}}
    {{- $userValues := deepCopy (omit .Values "common") -}}
    {{- $mergedValues := mustMergeOverwrite $defaultValues $userValues -}}
    {{- $_ := set . "Values" (deepCopy $mergedValues) -}}
  {{- end -}}

  {{- $perDict := dict }}
  {{- range $index, $item := .Values.persistenceList -}}
    {{- $name := ( printf "list-%s" ( $index | toString ) ) }}
    {{- if $item.name }}
      {{- $name = $item.name }}
    {{- end }}
    {{- $_ := set $perDict $name $item }}
  {{- end }}
  {{- range $index, $item := .Values.deviceList -}}
    {{- $name := ( printf "device-%s" ( $index | toString ) ) }}
    {{- if $item.name }}
      {{- $name = $item.name }}
    {{- end }}
    {{- $_ := set $perDict $name $item }}
  {{- end }}
  {{- $per := merge .Values.persistence $perDict }}
  {{- $_ := set .Values "persistence" (deepCopy $per) -}}


  {{- if .Values.podSecurityContext.permissive }}
  {{- else if .Values.deviceList }}
  {{- $_ := set .Values.podSecurityContext "permissive" true -}}
  {{- end }}

  {{ if .Values.podSecurityContext.supplementalgroups }}
  {{- $supGroups = .Values.podSecurityContext.supplementalgroups }}
  {{- else
  {{- $supGroups := list }}
  {{- end }}

  {{- if .Values.deviceList}}
  {{- $devGroups := list 5 20 24 }}
  {{- $supGroups := list ( concat $supGroups $devGroups) ) }}
  {{- end }}
  {{- if .Values.scaleGPU }}
  {{- $gpuGroups := list 44 107 }}
  {{- $supGroups := list ( concat $supGroups $gpuGroups) ) }}
  {{- end }}
  {{- $_ := set .Values.podSecurityContext "supplementalgroups" $supGroups -}}

{{- end -}}
