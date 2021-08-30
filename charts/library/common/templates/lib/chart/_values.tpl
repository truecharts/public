{{/* Merge the local chart values and the common chart defaults */}}
{{- define "common.values.setup" -}}
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
   {{- $persistenceAnnotationsDict := dict }}
   {{- range $item.annotationsList }}
   {{- $_ := set $persistenceAnnotationsDict .name .value }}
   {{- end }}
   {{- $tmp := $item.annotations }}
   {{- $persistenceanno := merge $tmp $persistenceAnnotationsDict }}
   {{- $_ := set $item "annotations" (deepCopy $persistenceanno) -}}
   {{- end }}


   {{/* merge persistenceLabelsList with persistenceLabels */}}
   {{- range $index, $item := .Values.persistence }}
   {{- $persistenceLabelsDict := dict }}
   {{- range $item.labelsList }}
   {{- $_ := set $persistenceLabelsDict .name .value }}
   {{- end }}
   {{- $tmp := $item.labels }}
   {{- $persistencelab := merge $tmp $persistenceLabelsDict }}
   {{- $_ := set $item "labels" (deepCopy $persistencelab) -}}
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
   {{- $ingressAnnotationsDict := dict }}
   {{- range $item.annotationsList }}
   {{- $_ := set $ingressAnnotationsDict .name .value }}
   {{- end }}
   {{- $tmp := $item.annotations }}
   {{- $ingressanno := merge $tmp $ingressAnnotationsDict }}
   {{- $_ := set $item "annotations" (deepCopy $ingressanno) -}}
   {{- end }}


   {{/* merge ingressLabelsList with ingressLabels */}}
   {{- range $index, $item := .Values.ingress }}
   {{- $ingressLabelsDict := dict }}
   {{- range $item.labelsList }}
   {{- $_ := set $ingressLabelsDict .name .value }}
   {{- end }}
   {{- $tmp := $item.labels }}
   {{- $ingresslab := merge $tmp $ingressLabelsDict }}
   {{- $_ := set $item "labels" (deepCopy $ingresslab) -}}
   {{- end }}

  {{/* Enable privileged securitycontext when deviceList is used */}}
  {{- if .Values.securityContext.privileged }}
  {{- else if .Values.deviceList }}
  {{- $_ := set .Values.securityContext "privileged" true -}}
  {{- end }}

  {{/* save supplementalGroups to placeholder variable */}}
  {{- $supGroups := list }}
  {{ if .Values.podSecurityContext.supplementalGroups }}
  {{- $supGroups = .Values.podSecurityContext.supplementalGroups }}
  {{- end }}

  {{/* Append requered groups to supplementalGroups when deviceList is used */}}
  {{- if .Values.deviceList}}
  {{- $devGroups := list 5 20 24 }}
  {{- $supGroups := list ( concat $supGroups $devGroups ) }}
  {{- end }}

  {{/* Append requered groups to supplementalGroups when scaleGPU is used */}}
  {{- if .Values.scaleGPU }}
  {{- $gpuGroups := list 44 107 }}
  {{- $supGroups := list ( concat $supGroups $gpuGroups ) }}
  {{- end }}

  {{/* write appended supplementalGroups to .Values */}}
  {{- $_ := set .Values.podSecurityContext "supplementalGroups" $supGroups -}}

  {{/* merge serviceList with service */}}
  {{- $portsDict := dict }}
  {{- range $index, $item := .Values.serviceList -}}
    {{- $name := ( printf "list-%s" ( $index | toString ) ) }}
    {{- if $item.name }}
      {{- $name = $item.name }}
    {{- end }}
    {{- $_ := set $portsDict $name $item }}
  {{- end }}
  {{- $srv := merge .Values.service $portsDict }}
  {{- $_ := set .Values "service" (deepCopy $srv) -}}

  {{/* merge portsList with ports */}}
  {{- range $index, $item := .Values.service -}}
  {{- $portsDict := dict }}
  {{- range $index2, $item2 :=  $item.portsList -}}
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

{{- end -}}
