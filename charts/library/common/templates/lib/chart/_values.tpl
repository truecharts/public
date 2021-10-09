{{/* Merge the local chart values and the common chart defaults */}}
{{- define "common.values" -}}
  {{- if .Values.common -}}
    {{- $defaultValues := deepCopy .Values.common -}}
    {{- $userValues := deepCopy (omit .Values "common") -}}
    {{- $mergedValues := mustMergeOverwrite $defaultValues $userValues -}}
    {{- $_ := set . "Values" (deepCopy $mergedValues) -}}
  {{- end -}}

   {{/* merge podAnnotationsList with podAnnotations */}}
   {{- $podAnnotationsDict := dict }}
   {{- range .Values.podAnnotationsList }}
   {{- $_ := set $podAnnotationsDict .name .value }}
   {{- end }}
   {{- $podanno := merge .Values.podAnnotations $podAnnotationsDict }}
   {{- $_ := set .Values "podAnnotations" (deepCopy $podanno) -}}

   {{/* merge podLabelsList with podLabels */}}
   {{- $podLabelsDict := dict }}
   {{- range .Values.controller.labelsList }}
   {{- $_ := set $podLabelsDict .name .value }}
   {{- end }}
   {{- $podlab := merge .Values.controller.labels $podLabelsDict }}
   {{- $_ := set .Values.controller "labels" (deepCopy $podlab) -}}

   {{/* merge controllerAnnotationsList with controllerAnnotations */}}
   {{- $controllerAnnotationsDict := dict }}
   {{- range .Values.controller.annotationsList }}
   {{- $_ := set $controllerAnnotationsDict .name .value }}
   {{- end }}
   {{- $controlleranno := merge .Values.controller.annotations $controllerAnnotationsDict }}
   {{- $_ := set .Values.controller "annotations" (deepCopy $controlleranno) -}}

   {{/* merge controllerLabelsList with controllerLabels */}}
   {{- $controllerLabelsDict := dict }}
   {{- range .Values.controller.labelsList }}
   {{- $_ := set $controllerLabelsDict .name .value }}
   {{- end }}
   {{- $controllerlab := merge .Values.controller.labels $controllerLabelsDict }}
   {{- $_ := set .Values "labels" (deepCopy $controllerlab) -}}



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
  {{- $_ := set .Values "persistence" (deepCopy $per) -}}


   {{/* merge persistenceAnnotationsList with persistenceAnnotations */}}
   {{- range $index, $item := .Values.persistence }}
   {{- if $item.enabled }}
   {{- $persistenceAnnotationsDict := dict }}
   {{- range $item.annotationsList }}
   {{- $_ := set $persistenceAnnotationsDict .name .value }}
   {{- end }}
   {{- $tmp := $item.annotations }}
   {{- $persistenceanno := merge $tmp $persistenceAnnotationsDict }}
   {{- $_ := set $item "annotations" (deepCopy $persistenceanno) -}}
   {{- end }}
   {{- end }}


   {{/* merge persistenceLabelsList with persistenceLabels */}}
   {{- range $index, $item := .Values.persistence }}
   {{- if $item.enabled }}
   {{- $persistenceLabelsDict := dict }}
   {{- range $item.labelsList }}
   {{- $_ := set $persistenceLabelsDict .name .value }}
   {{- end }}
   {{- $tmp := $item.labels }}
   {{- $persistencelab := merge $tmp $persistenceLabelsDict }}
   {{- $_ := set $item "labels" (deepCopy $persistencelab) -}}
   {{- end }}
   {{- end }}


  {{/* merge ingressList with ingress */}}
  {{- $ingDict := dict }}
  {{- range $index, $item := .Values.ingressList -}}
    {{- $name := ( printf "list-%s" ( $index | toString ) ) }}
    {{- if $item.name }}
      {{- $name = $item.name }}
    {{- end }}
    {{- $_ := set $ingDict $name $item }}
  {{- end }}
  {{- $ing := merge .Values.ingress $ingDict }}
  {{- $_ := set .Values "ingress" (deepCopy $ing) -}}


   {{/* merge ingressAnnotationsList with ingressAnnotations */}}
   {{- range $index, $item := .Values.ingress }}
   {{- if $item.enabled }}
   {{- $ingressAnnotationsDict := dict }}
   {{- range $item.annotationsList }}
   {{- $_ := set $ingressAnnotationsDict .name .value }}
   {{- end }}
   {{- $tmp := $item.annotations }}
   {{- $ingressanno := merge $tmp $ingressAnnotationsDict }}
   {{- $_ := set $item "annotations" (deepCopy $ingressanno) -}}
   {{- end }}
   {{- end }}


   {{/* merge ingressLabelsList with ingressLabels */}}
   {{- range $index, $item := .Values.ingress }}
   {{- if $item.enabled }}
   {{- $ingressLabelsDict := dict }}
   {{- range $item.labelsList }}
   {{- $_ := set $ingressLabelsDict .name .value }}
   {{- end }}
   {{- $tmp := $item.labels }}
   {{- $ingresslab := merge $tmp $ingressLabelsDict }}
   {{- $_ := set $item "labels" (deepCopy $ingresslab) -}}
   {{- end }}
   {{- end }}

  {{/* Enable privileged securitycontext when deviceList is used */}}
  {{- if .Values.securityContext.privileged }}
  {{- else if .Values.deviceList }}
  {{- $_ := set .Values.securityContext "privileged" true -}}
  {{- end }}


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
  {{- if .Values.deviceList}}
  {{- $devGroups = list 5 20 24 }}
  {{- end }}

  {{/* Append requered groups to supplementalGroups when scaleGPU is used */}}
  {{- if .Values.scaleGPU }}
  {{- $gpuGroups = list 44 107 }}
  {{- end }}

  {{/* combine and write all supplementalGroups to .Values */}}
  {{- $supGroups := concat $fixedGroups $valuegroups $devGroups $gpuGroups }}
  {{- $_ := set .Values.podSecurityContext "supplementalGroups" $supGroups -}}

  {{/* merge serviceList with service */}}
  {{- $portsDict := dict }}
  {{- range $index, $item := .Values.serviceList -}}
  {{- if $item.enabled }}
    {{- $name := ( printf "list-%s" ( $index | toString ) ) }}
    {{- if $item.name }}
      {{- $name = $item.name }}
    {{- end }}
    {{- $_ := set $portsDict $name $item }}
  {{- end }}
  {{- end }}
  {{- $srv := merge .Values.service $portsDict }}
  {{- $_ := set .Values "service" (deepCopy $srv) -}}

  {{/* merge portsList with ports */}}
  {{- range $index, $item := .Values.service -}}
  {{- if $item.enabled }}
  {{- $portsDict := dict }}
  {{- range $index2, $item2 :=  $item.portsList -}}
  {{- if $item2.enabled }}
    {{- $name := ( printf "list-%s" ( $index2 | toString ) ) }}
    {{- if $item2.name }}
      {{- $name = $item2.name }}
    {{- end }}
    {{- $_ := set $portsDict $name $item2 }}
  {{- end }}
  {{- $tmp := $item.ports }}
  {{- $ports := merge $tmp $portsDict }}
  {{- $_ := set $item "ports" (deepCopy $ports) -}}
  {{- end }}
  {{- end }}
  {{- end }}


  {{/* automatically set CAP_NET_BIND_SERVICE */}}
  {{- $fixedCapAdd := list }}
  {{- $customCapAdd := list }}
  {{- $valueCapAdd := list }}
  {{- $dynamicCapAdd := list }}
  {{- $fixedCapDrop := list }}
  {{- $customCapDrop := list }}
  {{- $valueCapDrop := list }}
  {{- $dynamicCapDrop := list }}
  {{- if .Values.securityContext.capabilities.add }}
  {{- $valueCapAdd = .Values.securityContext.capabilities.add }}
  {{- end }}
  {{- if .Values.securityContext.capabilities.drop }}
  {{- $valueCapDrop = .Values.securityContext.capabilities.drop }}
  {{- end }}
  {{- if .Values.customCapabilities.add }}
  {{- $customCapAdd = .Values.customCapabilities.add }}
  {{- end }}
  {{- if .Values.customCapabilities.drop }}
  {{- $customCapDrop = .Values.customCapabilities.drop }}
  {{- end }}

  {{- $privPort := false }}
  {{- range .Values.service }}
  {{- range $name, $values := .ports }}
  {{- if and ( $values.targetPort ) ( kindIs "int" $values.targetPort ) }}
  {{- if ( semverCompare "<= 1024" ( toString $values.targetPort ) ) }}
  {{- $privPort = true }}
  {{- end }}
  {{- else if and ( $values.port ) ( kindIs "int" $values.port )  }}
  {{- if ( semverCompare "<= 1024" ( toString $values.port ) ) }}
  {{- $privPort = true }}
  {{- end }}
  {{- end }}
  {{- end }}
  {{- end }}

  {{- if $privPort }}
  {{- $dynamicCapAdd = list "NET_BIND_SERVICE" }}
  {{- end }}

  {{/* combine and write all capabilities to .Values */}}
  {{- $CapAdd := concat $fixedCapAdd $valueCapAdd $dynamicCapAdd }}
  {{- $CapDrop := concat $fixedCapDrop $valueCapDrop $dynamicCapDrop }}
  {{- if $CapDrop }}
  {{- $_ := set .Values.securityContext.capabilities "drop" $CapDrop -}}
  {{- end }}
  {{- if $CapAdd }}
  {{- $_ := set .Values.securityContext.capabilities "add" $CapAdd -}}
  {{- end }}
{{- end -}}
