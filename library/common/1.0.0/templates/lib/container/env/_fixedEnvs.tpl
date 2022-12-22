{{/*
"toYaml" makes sure that any type of data (int/float/strin)
will be parsed correctly without causing errors.
*/}}
{{- define "ix.v1.common.container.fixedEnvs" -}}
  {{- $root := .root -}}
  {{- $container := .container -}}
  {{- $vars := list -}}

  {{- $vars = mustAppend $vars (dict "name" "TZ" "value" (tpl (toYaml $root.Values.TZ) $root)) -}}
  {{- $vars = mustAppend $vars (dict "name" "UMASK" "value" (tpl (toYaml $root.Values.security.UMASK) $root)) -}}
  {{- $vars = mustAppend $vars (dict "name" "UMASK_SET" "value" (tpl (toYaml $root.Values.security.UMASK) $root)) -}}
  {{- if not ($root.Values.scaleGPU) -}}
    {{- $vars = mustAppend $vars (dict "name" "NVIDIA_VISIBLE_DEVICES" "value" "void") -}}
  {{- else -}}
    {{- $vars = mustAppend $vars (dict "name" "NVIDIA_DRIVER_CAPABILITIES" "value" ( join "," $root.Values.nvidiaCaps )) -}}
  {{- end -}}
  {{- if and (or (eq ($root.Values.podSecurityContext.runAsUser | int) 0) (eq ($root.Values.podSecurityContext.runAsGroup | int) 0)) (or $root.Values.security.PUID (eq ($root.Values.security.PUID | int) 0)) -}} {{/* If root user or root group and a PUID is set, set PUID and related envs */}}
    {{- $vars = mustAppend $vars (dict "name" "PUID" "value" (tpl (toYaml $root.Values.security.PUID) $root)) -}}
    {{- $vars = mustAppend $vars (dict "name" "USER_ID" "value" (tpl (toYaml $root.Values.security.PUID) $root)) -}}
    {{- $vars = mustAppend $vars (dict "name" "UID" "value" (tpl (toYaml $root.Values.security.PUID) $root)) -}}
    {{- $vars = mustAppend $vars (dict "name" "PGID" "value" (tpl (toYaml $root.Values.podSecurityContext.fsGroup) $root)) -}}
    {{- $vars = mustAppend $vars (dict "name" "GROUP_ID" "value" (tpl (toYaml $root.Values.podSecurityContext.fsGroup) $root)) -}}
    {{- $vars = mustAppend $vars (dict "name" "GID" "value" (tpl (toYaml $root.Values.podSecurityContext.fsGroup) $root)) -}}
  {{- end -}}
  {{- if or ($root.Values.securityContext.readOnlyRootFilesystem) ($root.Values.securityContext.runAsNonRoot) -}} {{/* Mainly for LSIO containers, tell S6 to avoid using rootfs */}}
    {{- $vars = mustAppend $vars (dict "name" "S6_READ_ONLY_ROOT" "value" "1") -}}
  {{- end -}}
  {{- include "ix.v1.common.util.storeEnvsForDupeCheck" (dict "root" $root "source" "fixedEnv" "data" (toJson $vars) "containers" (list $container)) -}}
  {{- toJson $vars -}} {{/* Helm can only return "string", so we stringify the output */}}
{{- end -}}
