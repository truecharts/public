{{/* The main container included in the controller */}}
{{/*
On some includes we pass a dict with the "root" and some other values.
This is because this named function relies on those two, to specify it's context.
So it can work on multiple places, like additional containers and not only the main container.
*/}}
{{- define "ix.v1.common.controller.mainContainer" -}}
  {{- $values := .values -}}
  {{- $root := .root -}}

  {{- $name := include "ix.v1.common.names.fullname" $root -}}
- name: {{ $name }}
  image: {{ include "ix.v1.common.images.selector" (dict "root" $root "selectedImage" $values.imageSelector) }}
  imagePullPolicy: {{ include "ix.v1.common.images.pullPolicy" (dict "root" $root "selectedImage" $values.imageSelector) }}
  tty: {{ $values.tty }}
  stdin: {{ $values.stdin }}
  {{- with (include "ix.v1.common.container.command" (dict "commands" $values.command "root" $root)) | trim }}
  command:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.args" (dict "args" $values.args "extraArgs" $values.extraArgs "root" $root)) | trim }}
  args:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.securityContext"  (dict "secCont" $values.securityContext
                                                                    "isMainContainer" true
                                                                    "deviceList" $values.deviceList
                                                                    "scaleGPU" $values.scaleGPU
                                                                    "root" $root)) | trim }}
  securityContext:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.lifecycle" (dict "lifecycle" $values.lifecycle "root" $root)) | trim }}
  lifecycle:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.termination.messagePath" (dict "msgPath" $values.termination.messagePath "root" $root)) | trim }}
  terminationMessagePath: {{ . }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.termination.messagePolicy" (dict "msgPolicy" $values.termination.messagePolicy "root" $root)) | trim }}
  terminationMessagePolicy: {{ . }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.envVars"  (dict "envs" $values.env
                                                            "envList" $values.envList
                                                            "containerName" $name
                                                            "isMainContainer" true
                                                            "scaleGPU" $values.scaleGPU
                                                            "nvidiaCaps" $values.nvidiaCaps
                                                            "secCont" $values.securityContext
                                                            "secEnvs" $values.security
                                                            "injectFixedEnvs" $values.injectFixedEnvs
                                                            "root" $root) | trim) }}
  env:
    {{- . | nindent 4 }} {{/* env, fixedEnvs and envList */}}
  {{- end -}}
  {{- with (include "ix.v1.common.container.envFrom" (dict "envFrom" $values.envFrom "containerName" $name "root" $root) | trim) }}
  envFrom:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.ports" (dict "services" $values.service "root" $root) | trim) }}
  ports:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.volumeMounts" (dict "root" $root
                                                                "isMainContainer" true) | trim) }}
  volumeMounts:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.probes" (dict "probes" $values.probes
                                                          "services" $values.service
                                                          "containerName" $name
                                                          "isMainContainer" true
                                                          "root" $root) | trim) }}
    {{- . | nindent 2 }}
  {{- end -}}
  {{- with (include "ix.v1.common.container.resources"  (dict "resources" $values.resources
                                                              "gpu" $values.scaleGPU
                                                              "isMainContainer" true
                                                              "root" $root) | trim) }}
  resources:
    {{- . | nindent 4 }}
  {{- end -}}
{{- end -}}
