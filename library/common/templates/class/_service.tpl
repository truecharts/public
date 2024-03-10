{{/* Service Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.service" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData: The service data, that will be used to render the Service object.
*/}}

{{- define "tc.v1.common.class.service" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $svcType := $objectData.type | default $rootCtx.Values.global.fallbackDefaults.serviceType -}}

  {{/* Init variables */}}
  {{- $hasHTTPSPort := false -}}
  {{- $hasHostPort := false -}}
  {{- $hostNetwork := false -}}
  {{- $podValues := dict -}}

  {{- range $portName, $port := $objectData.ports -}}
    {{- if $port.enabled -}}
      {{- if eq (tpl ($port.protocol | default "") $rootCtx) "https" -}}
        {{- $hasHTTPSPort = true -}}
      {{- end -}}

      {{- if and (hasKey $port "hostPort") $port.hostPort -}}
        {{- $hasHostPort = true -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- $specialTypes := (list "ExternalName" "ExternalIP") -}}
  {{/* External Name / External IP does not rely on any pod values */}}
  {{- if not (mustHas $svcType $specialTypes) -}}
    {{/* Get Pod Values based on the selector (or the absence of it) */}}
    {{- $podValues = fromJson (include "tc.v1.common.lib.helpers.getSelectedPodValues" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Service")) -}}

    {{- if $podValues -}}
      {{/* Get Pod hostNetwork configuration */}}
      {{- $hostNetwork = include "tc.v1.common.lib.pod.hostNetwork" (dict "rootCtx" $rootCtx "objectData" $podValues) -}}
      {{/* When hostNetwork is set on the pod, force ClusterIP, so services wont try to bind the same ports on the host */}}
      {{- if or (and (kindIs "bool" $hostNetwork) $hostNetwork) (and (kindIs "string" $hostNetwork) (eq $hostNetwork "true")) -}}
        {{- $svcType = "ClusterIP" -}}
      {{- end -}}
    {{- end -}}

    {{/* When hostPort is defined, force ClusterIP aswell */}}
    {{- if $hasHostPort -}}
      {{- $svcType = "ClusterIP" -}}
    {{- end -}}
  {{- end -}}

  {{/* When Stop All is set, force ClusterIP as well */}}
  {{- if (include "tc.v1.common.lib.util.stopAll" $rootCtx) -}}
    {{- $svcType = "ClusterIP" -}}
  {{- end -}}
  {{- $_ := set $objectData "type" $svcType  }}
---
apiVersion: v1
kind: Service
metadata:
  name: {{ $objectData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Service") }}
  {{- $labels := (mustMerge ($objectData.labels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml)
                            (include "tc.v1.common.lib.metadata.selectorLabels" (dict "rootCtx" $rootCtx "objectType" "service" "objectName" $objectData.shortName) | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($objectData.annotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml)) -}}
  {{- if eq $objectData.type "LoadBalancer" -}}
    {{- include "tc.v1.common.lib.service.metalLBAnnotations" (dict "rootCtx" $rootCtx "objectData" $objectData "annotations" $annotations) -}}
  {{- end -}}
  {{- if $hasHTTPSPort -}}
    {{- include "tc.v1.common.lib.service.traefikAnnotations" (dict "rootCtx" $rootCtx "annotations" $annotations) -}}
  {{- end -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  {{- if eq $objectData.type "ClusterIP" -}}
    {{- include "tc.v1.common.lib.service.spec.clusterIP" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 2 -}}
  {{- else if eq $objectData.type "LoadBalancer" -}}
    {{- include "tc.v1.common.lib.service.spec.loadBalancer" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 2 -}}
  {{- else if eq $objectData.type "NodePort" -}}
    {{- include "tc.v1.common.lib.service.spec.nodePort" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 2 -}}
  {{- else if eq $objectData.type "ExternalName" -}}
    {{- include "tc.v1.common.lib.service.spec.externalName" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 2 -}}
  {{- else if eq $objectData.type "ExternalIP" -}}
    {{- include "tc.v1.common.lib.service.spec.externalIP" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 2 -}}
  {{- end -}}
  {{- with (include "tc.v1.common.lib.service.ports" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim) }}
  ports:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- if not (mustHas $objectData.type $specialTypes) }}
  selector:
    {{- if $objectData.selectorLabels }}
      {{- tpl (toYaml $objectData.selectorLabels) $rootCtx | nindent 4 }}
    {{- else }}
      {{- include "tc.v1.common.lib.metadata.selectorLabels" (dict "rootCtx" $rootCtx "objectType" "pod" "objectName" $podValues.shortName) | trim | nindent 4 -}}
    {{- end }}
  {{- end -}}
  {{- if eq $objectData.type "ExternalIP" -}}
    {{- $useSlice := true -}}
    {{- if kindIs "bool" $objectData.useSlice -}}
      {{- $useSlice = $objectData.useSlice -}}
    {{- end -}}

    {{- if $useSlice -}}
      {{- include "tc.v1.common.class.endpointSlice" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 0 }}
    {{- else -}}
      {{- include "tc.v1.common.class.endpoint" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 0 }}
    {{- end -}}
  {{- end -}}
{{- end -}}
