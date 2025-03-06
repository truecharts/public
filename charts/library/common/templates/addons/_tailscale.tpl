{{/*
Template to render VPN addon
It will include / inject the required templates based on the given values.
*/}}
{{- define "tc.v1.common.addon.tailscale" -}}
  {{- $ts := $.Values.addons.tailscale -}}
  {{- if $ts.enabled -}}
    {{- $secContext := dict -}}
    {{- $_ := set $secContext "runAsUser" 0 -}}
    {{- $_ := set $secContext "runAsGroup" 0 -}}
    {{- $_ := set $secContext "runAsNonRoot" true -}}
    {{- $_ := set $secContext "readOnlyRootFilesystem" false -}}

    {{- if and $ts.container.env ($ts.container.env.TS_USERSPACE) -}}
      {{- $_ := set $secContext "runAsUser" 1000 -}}
      {{- $_ := set $secContext "runAsGroup" 1000 -}}
      {{- $_ := set $secContext "runAsNonRoot" false -}}
      {{- $_ := set $secContext "readOnlyRootFilesystem" true -}}
    {{- end -}}

    {{- $newSecContext := $ts.container.securityContext -}}
    {{- $newSecContext = mustMergeOverwrite $newSecContext $secContext -}}
    {{- $_ := set $ts.container "securityContext" $newSecContext -}}

    {{- $targetSelector := list "main" -}}
    {{- if $ts.targetSelector -}}
      {{- $targetSelector = $ts.targetSelector -}}
    {{- end -}}

    {{/* Append the vpn container to the workloads */}}
    {{- range $targetSelector -}}
      {{/* FIXME: https://github.com/tailscale/tailscale/issues/8188 */}}
      {{- $workload := get $.Values.workload . -}}
      {{- $_ := set $workload.podSpec "automountServiceAccountToken" true -}}
      {{- $_ := set $workload.podSpec.containers "tailscale" $ts.container -}}
    {{- end -}}

    {{- $persistence := $.Values.persistence.tailscalestate | default dict -}}
    {{- $_ := set $persistence "enabled" true -}}
    {{- if not $persistence.type -}}
      {{- $_ := set $persistence "type" "emptyDir" -}}
    {{- end -}}
    {{- if not $persistence.targetSelector -}}
      {{- $_ := set $persistence "targetSelector" dict -}}
    {{- end -}}

    {{- $selectorValue := (dict "tailscale" (dict "mountPath" "/var/lib/tailscale")) -}}
    {{- range $targetSelector -}}
      {{- $_ := set $persistence.targetSelector . $selectorValue -}}
    {{- end -}}

    {{/* Append the empty dir tailscale to the persistence */}}
    {{- $_ := set $.Values.persistence "tailscalestate" $persistence -}}
  {{- end -}}

{{- end -}}
