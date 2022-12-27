{{- define "ix.v1.common.controller.extraContainers" -}}
  {{- $containerList := .containerList -}}
  {{- $type := .type -}}
  {{- $root := .root -}}

  {{- if not $type -}} {{/* This can only be triggered while developing the common library */}}
    {{- fail "You have to specify the type of the container" -}}
  {{- end -}}

  {{- if not (mustHas $type (list "init" "install" "upgrade" "addititional")) -}}
    {{- fail (printf "Type (%s) is not valid. Valid types are init, install, upgrade, addititonal" $type) -}}
  {{- end -}}

  {{- $sortedContainers := list -}}

  {{/* Sort containers */}}
  {{- range $index, $name := (keys $containerList | uniq | sortAlpha) -}}
    {{- $container := get $containerList $name -}}
    {{- $_ := set $container "name" $name -}}
    {{- $sortedContainers = mustAppend $sortedContainers $container -}}
  {{- end -}}

  {{/* Empty the list if the phase does not match the container type */}}
  {{- if and (eq $type "install") (not $root.Release.IsInstall) -}}
    {{- $sortedContainers = list -}}
  {{- else if and (eq $type "upgrade") (not $root.Release.IsUpgrade) -}}
    {{- $sortedContainers = list -}}
  {{- end -}}

  {{- range $index, $container := $sortedContainers }}
    {{- if ne $container.name ($container.name | lower) -}}
      {{- fail (printf "Name (%s) of Init Container must be all lowercase" $container.name) -}}
    {{- end -}}
    {{- $name := (printf "%s-%s" (include "ix.v1.common.names.fullname" $root) $container.name) }}
- name: {{ $name }}
  image: {{ include "ix.v1.common.images.selector" (dict "root" $root "selectedImage" $container.imageSelector ) }}
  imagePullPolicy: {{ include "ix.v1.common.images.pullPolicy" (dict "root" $root "selectedImage" $container.imageSelector) }}
  tty: {{ $container.tty | default false }}
  stdin: {{ $container.stdin | default false }}
  {{- with (include "ix.v1.common.container.command" (dict "commands" $container.command "root" $root)) | trim }}
  command:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.args" (dict "args" $container.args "extraArgs" $container.extraArgs "root" $root)) | trim }}
  args:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.envVars" (dict "envs" $container.env "envList" $container.envList "containerName" $name "root" $root) | trim) }}
  env:
    {{- . | nindent 4 }} {{/* env, fixedEnvs and envList */}}
  {{- end -}}
  {{- with (include "ix.v1.common.container.envFrom" (dict "envFrom" $container.envFrom "containerName" $name "root" $root) | trim) }}
  envFrom:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.lifecycle" (dict "lifecycle" $container.lifecycle "root" $root)) | trim -}}
    {{- if and . (mustHas $type (list "init" "install" "upgrades")) -}} {{/* Init containers do not have lifecycle... */}}
      {{- fail (printf "Init/Install/Upgrade Container (%s) do not support lifecycle hooks" $name) -}}
    {{- end }}
  lifecycle:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.securityContext" (dict "secCont" $container.securityContext "podSecCont" $root.Values.podSecurityContext "root" $root)) | trim }}
  securityContext:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- if $container.termination -}}
  {{- with (include "ix.v1.common.container.termination.messagePath" (dict "msgPath" $container.termination.messagePath "root" $root)) | trim }}
  terminationMessagePath: {{ . }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.termination.messagePolicy" (dict "msgPolicy" $container.termination.messagePolicy "root" $root)) | trim }}
  terminationMessagePolicy: {{ . }}
  {{- end -}}
  {{- end -}}
  {{- with (include "ix.v1.common.container.resources" (dict "resources" $container.resources "gpu" $container.scaleGPU "root" $root) | trim) }}
  resources:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- end -}}
{{- end -}}

{{/* TODO: Rename this as container and use this template for main container, additionals, init, upgrade, installs */}}
