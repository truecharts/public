{{/*
Template to render code-server addon
It will include / inject the required templates based on the given values.
*/}}
{{- define "common.addon.codeserver" -}}
{{- if .Values.addons.codeserver.enabled -}}
  {{/* Append the code-server container to the additionalContainers */}}
  {{- $container := include "common.addon.codeserver.container" . | fromYaml -}}
  {{- if $container -}}
    {{- $_ := set .Values.additionalContainers "addon-codeserver" $container -}}
  {{- end -}}

  {{/* Include the deployKeySecret if not empty */}}
  {{- $secret := include "common.addon.codeserver.deployKeySecret" . -}}
  {{- if $secret -}}
    {{- $secret | nindent 0 -}}
  {{- end -}}

  {{/* Append the secret volume to the volumes */}}
  {{- $volume := include "common.addon.codeserver.deployKeyVolumeSpec" . | fromYaml -}}
  {{- if $volume -}}
    {{- $_ := set .Values.persistence "deploykey" (dict "enabled" "true" "mountPath" "-" "type" "custom" "volumeSpec" $volume) -}}
  {{- end -}}

  {{/* Add the code-server service */}}
  {{- if .Values.addons.codeserver.service.enabled -}}
    {{- $serviceValues := .Values.addons.codeserver.service -}}
    {{- $_ := set $serviceValues "nameOverride" "codeserver" -}}
    {{- $_ := set $ "ObjectValues" (dict "service" $serviceValues) -}}
    {{- include "common.classes.service" $ -}}
    {{- $_ := unset $ "ObjectValues" -}}
  {{- end -}}

  {{/* Add the code-server ingress */}}
  {{- if .Values.addons.codeserver.ingress.enabled -}}
    {{- $ingressValues := .Values.addons.codeserver.ingress -}}
    {{- $_ := set $ingressValues "nameOverride" "codeserver" -}}

    {{/* Determine the target service name & port */}}
    {{- $svcName := printf "%v-codeserver" (include "common.names.fullname" .) -}}
    {{- $svcPort := .Values.addons.codeserver.service.ports.codeserver.port -}}
    {{- range $_, $host := $ingressValues.hosts -}}
      {{- $_ := set (index $host.paths 0) "service" (dict "name" $svcName "port" $svcPort) -}}
    {{- end -}}
    {{- $_ := set $ "ObjectValues" (dict "ingress" $ingressValues) -}}
    {{- include "common.classes.ingress" $ -}}
    {{- $_ := unset $ "ObjectValues" -}}
  {{- end -}}
{{- end -}}
{{- end -}}
