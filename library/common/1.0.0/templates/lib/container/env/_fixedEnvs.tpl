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
  {{- $scaleGPU := .scaleGPU -}}
  {{- $nvidiaCaps := .nvidiaCaps -}}

  {{- $nvidiaCaps = $nvidiaCaps | default $root.Values.global.defaults.nvidiaCaps -}}

  {{- $podSecCont := $root.Values.podSecurityContext -}}

  {{/* Calculate all security values */}}
  {{- $securityContext := (include "ix.v1.common.lib.securityContext" (dict "root" $root "secCont" $secCont "isMainContainer" $isMainContainer) | fromJson) -}}
  {{- $podSecurityContext := (include "ix.v1.common.lib.podSecurityContext" (dict "root" $root "podSecCont" $podSecCont) | fromJson) -}}
  {{- $securityEnvs := (include "ix.v1.common.lib.securityEnvs" (dict "root" $root "secEnvs" $secEnvs) | fromJson) -}}

  {{- $vars := list -}}
  {{- $vars = mustAppend $vars (dict "name" "TZ" "value" (tpl (toYaml $root.Values.TZ) $root)) -}}
  {{- $vars = mustAppend $vars (dict "name" "UMASK" "value" $securityEnvs.UMASK) -}}
  {{- $vars = mustAppend $vars (dict "name" "UMASK_SET" "value" $securityEnvs.UMASK) -}}
  {{- if not $scaleGPU -}}
    {{- $vars = mustAppend $vars (dict "name" "NVIDIA_VISIBLE_DEVICES" "value" "void") -}}
  {{- else -}}
    {{- $vars = mustAppend $vars (dict "name" "NVIDIA_DRIVER_CAPABILITIES" "value" (join "," $nvidiaCaps)) -}}
  {{- end -}}
  {{- if and (or (eq ($securityContext.runAsUser | int) 0) (eq ($securityContext.runAsGroup | int) 0)) (ge ($securityEnvs.PUID | int) 0) -}} {{/* If root user or root group and a PUID is set, set PUID and related envs */}}
    {{- $vars = mustAppend $vars (dict "name" "PUID" "value" $securityEnvs.PUID) -}}
    {{- $vars = mustAppend $vars (dict "name" "USER_ID" "value" $securityEnvs.PUID) -}}
    {{- $vars = mustAppend $vars (dict "name" "UID" "value" $securityEnvs.PUID) -}}
    {{- $vars = mustAppend $vars (dict "name" "PGID" "value" $podSecurityContext.fsGroup) -}}
    {{- $vars = mustAppend $vars (dict "name" "GROUP_ID" "value" $podSecurityContext.fsGroup) -}}
    {{- $vars = mustAppend $vars (dict "name" "GID" "value" $podSecurityContext.fsGroup) -}}
  {{- end -}}
  {{- if or ($securityContext.readOnlyRootFilesystem) ($securityContext.runAsNonRoot) -}} {{/* Mainly for LSIO containers, tell S6 to avoid using rootfs */}}
    {{- $vars = mustAppend $vars (dict "name" "S6_READ_ONLY_ROOT" "value" "1") -}}
  {{- end -}}
  {{- include "ix.v1.common.util.storeEnvsForDupeCheck" (dict "root" $root "source" "fixedEnv" "data" (toJson $vars) "containers" (list $containerName)) -}}
  {{- toJson $vars -}} {{/* Helm can only return "string", so we stringify the output */}}
{{- end -}}
