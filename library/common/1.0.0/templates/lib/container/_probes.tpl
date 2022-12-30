{{/* Probes selection logic included by the container. */}}
{{- define "ix.v1.common.container.probes" -}}
  {{- $root := .root -}}
  {{- $probes := .probes -}}
  {{- $services := .services -}}
  {{- $containerName := .containerName -}}

  {{- $defaultProbeType := $root.Values.global.defaults.probeType -}}
  {{- $defaultProbePath := $root.Values.global.defaults.probePath -}}

  {{- $primaryPort := "" -}}
  {{- if $services -}} {{/* If no services exist don't try to guess a port */}}
    {{/* Get the name of the primary service, if any */}}
    {{- $primarySeriviceName := (include "ix.v1.common.lib.util.service.primary" (dict "services" $services "root" $root)) -}}
    {{/* Get service values of the primary service, if any */}}
    {{- $primaryService := get $root.Values.service $primarySeriviceName -}}

    {{- if $primaryService -}}
      {{/* Get primaryPort, if any */}}
      {{- $primaryPort = get $primaryService.ports (include "ix.v1.common.lib.util.service.ports.primary" (dict "svcValues" $primaryService "svcName" $primarySeriviceName)) -}}
    {{- end -}}
  {{- end -}}

  {{- range $probeName, $probe := $probes -}}
    {{- if not (mustHas $probeName (list "liveness" "readiness" "startup")) -}}
      {{- fail (printf "Invalid probe name (%s) in (%s) container. Valid options are (liveness, readiness, startup)" $probeName $containerName) -}}
    {{- end -}}

    {{- if $probe.enabled -}}
      {{- $probeType := $defaultProbeType -}}
      {{- if $probe.type -}}
        {{- $probeType = $probe.type -}}
      {{- end -}}

      {{- if not (mustHas $probeType (list "tcp" "http" "https" "grpc" "exec" "custom")) -}}
        {{- fail (printf "Invalid probe type (%s) on probe (%s) in (%s) container. Valid types are tcp, http, https, grpc, exec" $probe.type $probeName $containerName) -}}
      {{- end -}}

      {{- $probePort := "" -}}
      {{- if $primaryPort -}}
        {{/* If port is defined to primaryPort use this */}}
        {{- if $primaryPort.port -}}
          {{- $probePort = $primaryPort.port -}}
        {{- end -}}
        {{/* If targetPort is defined to primaryPort use this */}}
        {{- if $primaryPort.targetPort -}}
          {{- $probePort = $primaryPort.targetPort -}}
        {{- end -}}
      {{- end -}}
      {{/* If a port is set on probe, use this always */}}
      {{- if $probe.port -}}
        {{- $probePort = (tpl ($probe.port | toString) $root) -}}
      {{- end -}}

      {{- $tmpProbe := dict -}}{{/* Prepare a temp Probe to pass in the probe definition function */}}
      {{- $_ := set $tmpProbe "name" $probeName -}}
      {{- $_ := set $tmpProbe "spec" $probe.spec -}}
      {{- $_ := set $tmpProbe "type" $probeType -}}
      {{- $_ := set $tmpProbe "port" $probePort -}}

      {{ printf "%sProbe:" $probeName | nindent 0 }}
      {{- if mustHas $probeType (list "https" "http") -}}
        {{- if $probe.path -}}
          {{- $_ := set $tmpProbe "path" $probe.path -}}
        {{- else -}}
          {{- $_ := set $tmpProbe "path" $defaultProbePath -}}
        {{- end -}}
        {{- $_ := set $tmpProbe "httpHeaders" $probe.httpHeaders -}}
        {{- include "ix.v1.common.container.probes.httpGet" (dict "probe" $tmpProbe "root" $root "containerName" $containerName) | trim | nindent 2 }}
      {{- else if (eq $probeType "tcp") -}}
        {{- include "ix.v1.common.container.probes.tcp" (dict "probe" $tmpProbe "root" $root "containerName" $containerName) | trim | nindent 2 }}
      {{- else if (eq $probeType "grpc") -}}
        {{- include "ix.v1.common.container.probes.grpc" (dict "probe" $tmpProbe "root" $root "containerName" $containerName) | trim | nindent 2 }}
      {{- else if (eq $probeType "exec") -}}
        {{- $_ := set $tmpProbe "command" $probe.command -}}
        {{- include "ix.v1.common.container.probes.exec" (dict "probe" $tmpProbe "root" $root "containerName" $containerName) | trim | nindent 2 }}
      {{- else if (eq $probeType "custom") -}}
        {{- include "ix.v1.common.container.probes.custom" (dict "probe" $tmpProbe "root" $root "containerName" $containerName) | trim | nindent 2 }}
      {{- else if (eq $probeType "udp") -}}
        {{- include "ix.v1.common.container.probes.udp" (dict "probe" $tmpProbe "root" $root "containerName" $containerName) | trim | nindent 2 }}
      {{- end -}}

    {{- end -}}
  {{- end -}}
{{- end -}}
