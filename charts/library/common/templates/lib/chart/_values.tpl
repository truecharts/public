{{/* Merge the local chart values and the common chart defaults */}}
{{- define "common.values.setup" -}}
  {{- if .Values.common -}}
    {{- $defaultValues := deepCopy .Values.common -}}
    {{- $userValues := deepCopy (omit .Values "common") -}}
    {{- $mergedValues := mustMergeOverwrite $defaultValues $userValues -}}
    {{- $_ := set . "Values" (deepCopy $mergedValues) -}}
  {{- end -}}

  {{/* merge persistenceList with Persitence */}}
  {{- $perDict := dict }}
  {{- range $index, $item := .Values.persistenceList -}}
    {{- $name := ( printf "list-%s" ( $index | toString ) ) }}
    {{- if $item.name }}
      {{- $name = $item.name }}
    {{- end }}
    {{- $_ := set $perDict $name $item }}
  {{- end }}

  {{/* merge deviceList with Persitence */}}
  {{- range $index, $item := .Values.deviceList -}}
    {{- $name := ( printf "device-%s" ( $index | toString ) ) }}
    {{- if $item.name }}
      {{- $name = $item.name }}
    {{- end }}
    {{- $_ := set $perDict $name $item }}
  {{- end }}
  {{- $per := merge .Values.persistence $perDict }}

  {{/* write merged persitence with .Values Persitence */}}
  {{- $_ := set .Values "persistence" (deepCopy $per) -}}

  {{/* Enable privileged securitycontext when deviceList is used */}}
  {{- if .Values.securityContext.privileged }}
  {{- else if .Values.deviceList }}
  {{- $_ := set .Values.securityContext "privileged" true -}}
  {{- end }}

  {{/* save supplementalgroups to placeholder variable */}}
  {{ if .Values.podSecurityContext.supplementalgroups }}
  {{- $supGroups = .Values.podSecurityContext.supplementalgroups }}
  {{- else }}
  {{- $supGroups := list }}
  {{- end }}

  {{/* Append requered groups to supplementalgroups when deviceList is used */}}
  {{- if .Values.deviceList}}
  {{- $devGroups := list 5 20 24 }}
  {{- $supGroups := list ( concat $supGroups $devGroups) ) }}
  {{- end }}

  {{/* Append requered groups to supplementalgroups when scaleGPU is used */}}
  {{- if .Values.scaleGPU }}
  {{- $gpuGroups := list 44 107 }}
  {{- $supGroups := list ( concat $supGroups $gpuGroups) ) }}
  {{- end }}

  {{/* write appended supplementalgroups to .Values */}}
  {{- $_ := set .Values.podSecurityContext "supplementalgroups" $supGroups -}}

{{- end -}}
