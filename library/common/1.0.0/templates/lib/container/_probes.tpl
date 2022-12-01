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
      {{- "" | nindent 0 -}} {{/* Needed to create a new line, WARNING, needs both the "-" */}}
      {{- $probeName }}Probe:
      {{- if $probe.custom -}} {{/* Allows to add a custom definition on the probe */}}
        {{- $probe.spec | toYaml | nindent 2 }}
      {{- else if eq $probe.type "EXEC" }}
        {{- print "exec:" | nindent 2 }}
        {{- if $probe.command }}
            {{- print "command:" | nindent 4 }}
            {{- include "ix.v1.common.container.command" (dict "commands" $probe.command "root" $) | trim | nindent 6 }}
            {{- include "ix.v1.common.container.probes.timings" (dict "probe" $probe "probeName" $probeName) }}
        {{- else -}}
          {{- fail (printf "No commands were defined for EXEC type on probe (%s)" $probeName) -}}
        {{- end -}}
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

          {{- if has $probeType (list "HTTPS" "HTTP") -}}
            {{- if not $probe.path -}}
              {{- fail (printf "<path> must be defined for HTTP/HTTPS probe types in probe (%s)" $probeName) -}}
            {{- end }}
            {{- print "httpGet:" | nindent 2 }}
            {{- printf "path: %v" (tpl $probe.path $) | nindent 4 }}
            {{- printf "scheme: %v" $probeType | nindent 4 }}
            {{- with $probe.httpHeaders }}
              {{- printf "httpHeaders:" | nindent 4 }}
              {{- range $k, $v := . }}
                {{- if or (kindIs "slice" $v) (kindIs "map" $v) -}}
                  {{- fail (printf "Lists or Dicts are not allowed in httpHeaders on probe (%s)" $probeName) -}}
                {{- end }}
                {{- printf "- name: %s" $k | nindent 6 }}
                {{- printf "  value: %s" (tpl (toString $v) $) | nindent 6 }}
              {{- end }}
            {{- end }}
          {{- else if (eq $probeType "TCP") }}
            {{- print "tcpSocket:" | nindent 2 }}
          {{- else if (eq $probeType "GRPC") }}
            {{- printf "grpc:" | nindent 2 }}
          {{- else if (eq $probeType "UDP") -}}
            {{- fail "UDP Probes are not supported. Please use a different probe or disable probes." -}}
          {{- end -}}

          {{- $probePort := $primaryPort.port -}}
          {{- if $probe.port -}}
            {{- $probePort = (tpl ($probe.port | toString) $) -}}
          {{- else if $primaryPort.targetPort -}}
            {{- $probePort = $primaryPort.targetPort -}}
          {{- end }}

          {{- printf "port: %v" $probePort | nindent 4 }}
          {{- include "ix.v1.common.container.probes.timings" (dict "probe" $probe "probeName" $probeName) }}
        {{- else -}}
          {{- fail (printf "Only custom probes are allowed when service is disabled (%s)" $probeName) -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "ix.v1.common.container.probes.timings" -}}
  {{- $probe := .probe -}}
  {{- $probeName := .probeName -}}
  {{/* ints are usually parsed as floats in helm */}}
  {{- if not (has (kindOf $probe.spec.initialDelaySeconds) (list "float64" "int")) -}}
    {{- fail (printf "<initialDelaySeconds> cannot be empty in probe (%s)" $probeName) -}}
  {{- end -}}
  {{- if not (has (kindOf $probe.spec.failureThreshold) (list "float64" "int")) -}}
    {{- fail (printf "<failureThreshold> cannot be empty in probe (%s)" $probeName) -}}
  {{- end -}}
  {{- if not (has (kindOf $probe.spec.timeoutSeconds) (list "float64" "int")) -}}
    {{- fail (printf "<timeoutSeconds> cannot be empty in probe (%s)" $probeName) -}}
  {{- end -}}
  {{- if not (has (kindOf $probe.spec.periodSeconds) (list "float64" "int")) -}}
    {{- fail (printf "<periodSeconds> cannot be empty in probe (%s)" $probeName) -}}
  {{- end }}
  {{- printf "initialDelaySeconds: %v" $probe.spec.initialDelaySeconds | nindent 2 }}
  {{- printf "failureThreshold: %v" $probe.spec.failureThreshold | nindent 2 }}
  {{- printf "timeoutSeconds: %v" $probe.spec.timeoutSeconds | nindent 2 }}
  {{- printf "periodSeconds: %v" $probe.spec.periodSeconds | nindent 2 }}
{{- end -}}
