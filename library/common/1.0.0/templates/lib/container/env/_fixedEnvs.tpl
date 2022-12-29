{{/*
"toYaml" makes sure that any type of data (int/float/strin)
will be parsed correctly without causing errors.
*/}}
{{- define "ix.v1.common.container.fixedEnvs" -}}
  {{- $root := .root -}}
  {{- $containerName := .containerName -}}
  {{- $isMainContainer := .isMainContainer -}}
  {{- $secEnvs := .secEnvs -}}
  {{- $secCont := .secCont -}}

  {{- $podSecCont := $root.Values.podSecurityContext -}}

  {{/* Calculate all security values */}}
  {{- $security := (include "ix.v1.common.lib.security" (dict "root" $root "secCont" $secCont "podSecCont" $podSecCont "secEnvs" $secEnvs "isMainContainer" $isMainContainer) | fromJson) -}}

  {{- $vars := list -}}
  {{/* TODO: container aware NVIDIA Caps*/}}
  {{/* TODO: Convert this to yaml directly */}}
  {{- $vars = mustAppend $vars (dict "name" "TZ" "value" (tpl (toYaml $root.Values.TZ) $root)) -}}
  {{- $vars = mustAppend $vars (dict "name" "UMASK" "value" $security.UMASK) -}}
  {{- $vars = mustAppend $vars (dict "name" "UMASK_SET" "value" $security.UMASK) -}}
  {{- if not ($root.Values.scaleGPU) -}} {{/* TODO: container aware GPU */}}
    {{- $vars = mustAppend $vars (dict "name" "NVIDIA_VISIBLE_DEVICES" "value" "void") -}}
  {{- else -}}
    {{- $vars = mustAppend $vars (dict "name" "NVIDIA_DRIVER_CAPABILITIES" "value" (join "," $root.Values.nvidiaCaps)) -}}
  {{- end -}}
  {{- if and (or (eq ($security.runAsUser | int) 0) (eq ($security.runAsGroup | int) 0)) (ge ($security.PUID | int) 0) -}} {{/* If root user or root group and a PUID is set, set PUID and related envs */}}
    {{- $vars = mustAppend $vars (dict "name" "PUID" "value" $security.PUID) -}}
    {{- $vars = mustAppend $vars (dict "name" "USER_ID" "value" $security.PUID) -}}
    {{- $vars = mustAppend $vars (dict "name" "UID" "value" $security.PUID) -}}
    {{- $vars = mustAppend $vars (dict "name" "PGID" "value" $security.fsGroup) -}}
    {{- $vars = mustAppend $vars (dict "name" "GROUP_ID" "value" $security.fsGroup) -}}
    {{- $vars = mustAppend $vars (dict "name" "GID" "value" $security.fsGroup) -}}
  {{- end -}}
  {{- if or ($security.readOnlyRootFilesystem) ($security.runAsNonRoot) -}} {{/* Mainly for LSIO containers, tell S6 to avoid using rootfs */}}
    {{- $vars = mustAppend $vars (dict "name" "S6_READ_ONLY_ROOT" "value" "1") -}}
  {{- end -}}
  {{- include "ix.v1.common.util.storeEnvsForDupeCheck" (dict "root" $root "source" "fixedEnv" "data" (toJson $vars) "containers" (list $containerName)) -}}
  {{- toJson $vars -}} {{/* Helm can only return "string", so we stringify the output */}}
{{- end -}}
