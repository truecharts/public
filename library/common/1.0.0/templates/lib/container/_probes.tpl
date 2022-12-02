{{/* Probes selection logic included by the container. */}}
{{- define "ix.v1.common.container.probes" -}}
  {{- $primarySeriviceName := (include "ix.v1.common.lib.util.service.primary" .) -}}  {{/* Get the name of the primary service, if any */}}
  {{- $primaryService := get .Values.service $primarySeriviceName -}} {{/* Get service values of the primary service, if any */}}
  {{- $primaryPort := "" -}}

  {{- if $primaryService -}}
    {{- $primaryPort = get $primaryService.ports (include "ix.v1.common.lib.util.service.ports.primary" (dict "values" $primaryService "svcName" $primarySeriviceName)) -}}
  {{- end -}}

  {{- $probeType := "TCP" -}}

  {{- range $probeName, $probe := .Values.probes -}}
      {{- if not (has $probeName (list "liveness" "readiness" "startup")) -}}
        {{- fail (printf "Invalid probe name (%s). Valid options are (liveness, readiness, startup)" $probeName) -}}
      {{- end -}}
    {{- if $probe.enabled -}}
      {{/* Prepare a temp Probe to pass in the probe definition function */}}
      {{- $tmpProbe := dict -}}
      {{- $_ := set $tmpProbe "name" $probeName -}}
      {{- $_ := set $tmpProbe "spec" $probe.spec }}
{{ $probeName }}Probe:
      {{- if $probe.custom -}} {{/* Allows to add a custom definition on the probe */}}
        {{- include "ix.v1.common.container.probes.custom" (dict "probe" $tmpProbe "root" $) | trim | nindent 2 }}
      {{- else if eq $probe.type "EXEC" -}}
        {{- $_ := set $tmpProbe "type" $probe.type -}}
        {{- $_ := set $tmpProbe "command" $probe.command -}}
        {{- include "ix.v1.common.container.probes.exec" (dict "probe" $tmpProbe "root" $) | trim | nindent 2 }}
      {{- else -}}
        {{- if and $primaryService $primaryPort -}}
          {{- if $probe.type -}}
            {{- if eq $probe.type "AUTO" -}}
              {{- $probeType = $primaryPort.protocol -}}
            {{- else -}}
              {{- if not (has $probe.type (list "TCP" "HTTP" "HTTPS" "GRPC")) -}}
                {{- fail (printf "Invalid probe type (%s) on probe (%s)" $probe.type $probeName) -}}
              {{- end -}}
              {{- $probeType = $probe.type -}}
            {{- end -}}
          {{- end -}}

          {{- $_ := set $tmpProbe "type" $probeType -}}

          {{- $probePort := $primaryPort.port -}}
          {{- if $probe.port -}}
            {{- $probePort = (tpl ($probe.port | toString) $) -}}
          {{- else if $primaryPort.targetPort -}}
            {{- $probePort = $primaryPort.targetPort -}}
          {{- end -}}

          {{- $_ := set $tmpProbe "port" $probePort -}}

          {{- if has $probeType (list "HTTPS" "HTTP") -}}
            {{- $_ := set $tmpProbe "path" $probe.path -}}
            {{- $_ := set $tmpProbe "httpHeaders" $probe.httpHeaders }}
            {{- include "ix.v1.common.container.probes.httpGet" (dict "probe" $tmpProbe "root" $) | trim | nindent 2 }}
          {{- else if (eq $probeType "TCP") }}
            {{- include "ix.v1.common.container.probes.tcp" (dict "probe" $tmpProbe "root" $) | trim | nindent 2 }}
          {{- else if (eq $probeType "GRPC") }}
            {{- include "ix.v1.common.container.probes.grpc" (dict "probe" $tmpProbe "root" $) | trim | nindent 2 }}
          {{- else if (eq $probeType "UDP") }}
            {{- include "ix.v1.common.container.probes.udp" (dict "probe" $tmpProbe "root" $) | trim | nindent 2 }}
          {{- end -}}
        {{- else -}}
          {{- fail (printf "Only custom probes are allowed when service is disabled (%s)" $probeName) -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "ix.v1.common.container.probes.timeouts" -}}
  {{- $probeSpec := .probeSpec -}}
  {{- $probeName := .probeName -}}
  {{/* ints are usually parsed as floats in helm */}}
  {{- if not (has (kindOf $probeSpec.initialDelaySeconds) (list "float64" "int")) -}}
    {{- fail (printf "<initialDelaySeconds> cannot be empty in probe (%s)" $probeName) -}}
  {{- end -}}
  {{- if not (has (kindOf $probeSpec.failureThreshold) (list "float64" "int")) -}}
    {{- fail (printf "<failureThreshold> cannot be empty in probe (%s)" $probeName) -}}
  {{- end -}}
  {{- if not (has (kindOf $probeSpec.timeoutSeconds) (list "float64" "int")) -}}
    {{- fail (printf "<timeoutSeconds> cannot be empty in probe (%s)" $probeName) -}}
  {{- end -}}
  {{- if not (has (kindOf $probeSpec.periodSeconds) (list "float64" "int")) -}}
    {{- fail (printf "<periodSeconds> cannot be empty in probe (%s)" $probeName) -}}
  {{- end }}
initialDelaySeconds: {{ $probeSpec.initialDelaySeconds }}
failureThreshold: {{ $probeSpec.failureThreshold }}
timeoutSeconds: {{ $probeSpec.timeoutSeconds }}
periodSeconds: {{ $probeSpec.periodSeconds }}
{{- end -}}
