{{/* Returns Probes */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.container.probes" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the container.
*/}}
{{- define "tc.v1.common.lib.container.probes" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $probeNames := (list "liveness" "readiness" "startup") -}}
  {{- $probeTypes := (list "http" "https" "tcp" "grpc" "exec") -}}

  {{- if not $objectData.probes -}}
    {{- fail "Container - Expected non-empty [probes]" -}}
  {{- end -}}

  {{- range $key := $probeNames -}}
    {{- if not (get $objectData.probes $key) -}}
      {{- fail (printf "Container - Expected [probes.%s] to be defined" $key) -}}
    {{- end -}}
  {{- end -}}

  {{- range $probeName, $probe := $objectData.probes -}}

    {{- if not (mustHas $probeName $probeNames) -}}
      {{- fail (printf "Container - Expected probe to be one of [%s], but got [%s]" (join ", " $probeNames) $probeName) -}}
    {{- end -}}

    {{- $isEnabled := true -}}
    {{- if kindIs "bool" $probe.enabled -}}
      {{- $isEnabled = $probe.enabled -}}
    {{- end -}}

    {{- if $isEnabled -}}

      {{- $probeType := $rootCtx.Values.global.fallbackDefaults.probeType -}}

      {{- with $probe.type -}}
        {{- $probeType = tpl . $rootCtx -}}
      {{- end -}}

      {{- if not (mustHas $probeType $probeTypes) -}}
        {{- fail (printf "Container - Expected probe type to be one of [%s], but got [%s]" (join ", " $probeTypes) $probeType) -}}
      {{- end }}
{{ $probeName }}Probe:
      {{- if (mustHas $probeType (list "http" "https")) -}}
        {{- include "tc.v1.common.lib.container.actions.httpGet" (dict "rootCtx" $rootCtx "objectData" $probe "caller" "probes") | trim | nindent 2 -}}
      {{- else if eq $probeType "tcp" -}}
        {{- include "tc.v1.common.lib.container.actions.tcpSocket" (dict "rootCtx" $rootCtx "objectData" $probe "caller" "probes") | trim | nindent 2 -}}
      {{- else if eq $probeType "grpc" -}}
        {{- include "tc.v1.common.lib.container.actions.grpc" (dict "rootCtx" $rootCtx "objectData" $probe "caller" "probes") | trim | nindent 2 -}}
      {{- else if eq $probeType "exec" -}}
        {{- include "tc.v1.common.lib.container.actions.exec" (dict "rootCtx" $rootCtx "objectData" $probe "caller" "probes") | trim | nindent 2 -}}
      {{- end -}}

      {{- include "tc.v1.common.lib.container.probeTimeouts" (dict "rootCtx" $rootCtx "objectData" $probe "probeName" $probeName) | trim | nindent 2 -}}

    {{- end -}}
  {{- end -}}
{{- end -}}

{{/* Returns Probe Timeouts */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.container.probeTimeouts" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the container.
*/}}
{{- define "tc.v1.common.lib.container.probeTimeouts" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}
  {{- $probeName := .probeName -}}

  {{- $timeouts := mustDeepCopy (get $rootCtx.Values.global.fallbackDefaults.probeTimeouts $probeName) -}}

  {{- if $objectData.spec -}} {{/* Overwrite with defined timeouts */}}
    {{- $timeouts = mustMergeOverwrite $timeouts $objectData.spec -}}
  {{- end -}}

  {{- $keys := (list "initialDelaySeconds" "failureThreshold" "successThreshold" "timeoutSeconds" "periodSeconds") -}}
  {{- range $key := $keys -}}
    {{- $number := get $timeouts $key -}}
    {{- if not (mustHas (kindOf $number) (list "float64" "int" "int64")) -}}
      {{- fail (printf "Container - Expected [probes] [%s] to be a number, but got [%v]" $key $number) -}}
    {{- end -}}
  {{- end -}}

  {{- if mustHas $probeName (list "liveness" "startup") -}}
    {{- if ne (int $timeouts.successThreshold) 1 -}}
      {{- fail (printf "Container - Expected [probes] [successThreshold] to be 1 on [%s] probe" $probeName) -}}
    {{- end -}}
  {{- end }}

initialDelaySeconds: {{ $timeouts.initialDelaySeconds }}
failureThreshold: {{ $timeouts.failureThreshold }}
successThreshold: {{ $timeouts.successThreshold }}
timeoutSeconds: {{ $timeouts.timeoutSeconds }}
periodSeconds: {{ $timeouts.periodSeconds }}
{{- end -}}
