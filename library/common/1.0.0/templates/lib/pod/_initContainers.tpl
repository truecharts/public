{{- define "ix.v1.common.controller.initContainers" -}}
  {{- $initContainers := .initContainers -}}
  {{- $root := .root -}}

  {{- range $name, $container := $initContainers }}
    {{- if $container.name -}}
      {{- $name = $container.name -}}
    {{- end -}}
    {{- if ne $name ($name | lower) -}}
      {{- fail (printf "Name (%s) of Init Container must be all lowercase" $name) -}}
    {{- end -}}
    {{- $name = (printf "%s-%s" (include "ix.v1.common.names.fullname" $root) $name) }}
- name: {{ $name }}
  image: {{ include "ix.v1.common.images.selector" (dict "root" $root "selectedImage" $container.imageSelector ) }}
  imagePullPolicy: {{ include "ix.v1.common.images.pullPolicy" (dict "policy" $container.pullPolicy) }}
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
  {{- with (include "ix.v1.common.container.envVars" (dict "envs" $container.env "envList" $container.envList "container" $name "root" $root) | trim) }}
  env:
    {{- . | nindent 4 }} {{/* env, fixedEnvs and envList */}}
  {{- end -}}
  {{- with (include "ix.v1.common.container.envFrom" (dict "envFrom" $container.envFrom "container" $name "root" $root) | trim) }}
  envFrom:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.lifecycle" (dict "lifecycle" $container.lifecycle "root" $root)) | trim }}
  lifecycle:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.securityContext" (dict "secCont" $container.securityContext "podSecCont" $container.podSecurityContext "root" $root)) | trim }}
  securityContext:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.termination.messagePath" (dict "msgPath" $container.termination.messagePath "root" $root)) | trim }}
  terminationMessagePath: {{ . }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.termination.messagePolicy" (dict "msgPolicy" $container.termination.messagePolicy "root" $root)) | trim }}
  terminationMessagePolicy: {{ . }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.resources" (dict "resources" $container.resources "gpu" $container.scaleGPU "root" $root) | trim) }}
  resources:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- end -}}
{{- end -}}

{{/* TODO: Rename this as container and use this template for main container, additionals, init, upgrade, installs */}}
