{{/*
Probes selection logic.
*/}}
{{- define "tc.common.controller.probes" -}}
{{- $primaryService := get .Values.service (include "tc.common.lib.util.service.primary" .) -}}
{{- $primaryPort := "" -}}
{{- if $primaryService -}}
  {{- $primaryPort = get $primaryService.ports (include "tc.common.lib.util.service.ports.primary" (dict "serviceName" (include "tc.common.lib.util.service.primary" .) "values" $primaryService)) -}}
{{- end -}}
{{- $probeType := "TCP" -}}

{{- range $probeName, $probe := .Values.probes }}
  {{- if $probe.enabled -}}
    {{- "" | nindent 0 }}
    {{- $probeName }}Probe:
    {{- if $probe.custom -}}
      {{- $probe.spec | toYaml | nindent 2 }}
    {{- else }}
      {{- if and $primaryService $primaryPort -}}
          {{- if $probe.type -}}
            {{- if eq $probe.type "AUTO" -}}
              {{- $probeType = $primaryPort.protocol -}}
            {{- else -}}
              {{- $probeType = $probe.type -}}
            {{- end }}
          {{- end }}

          {{- if or ( eq $probeType "HTTPS" ) ( eq $probeType "HTTP" ) -}}
              {{- "httpGet:" | nindent 2 }}
                {{- printf "path: %v" $probe.path | nindent 4 }}
                {{- printf "scheme: %v" $probeType | nindent 4 }}
          {{- else -}}
            {{- "tcpSocket:" | nindent 2 }}
          {{- end }}

          {{- if $probe.port }}
            {{- printf "port: %v" ( tpl ( $probe.port | toString ) $ ) | nindent 4 }}
          {{- else if $primaryPort.targetPort }}
            {{- printf "port: %v" $primaryPort.targetPort | nindent 4 }}
          {{- else}}
            {{- printf "port: %v" $primaryPort.port | nindent 4 }}
          {{- end }}
          {{- printf "initialDelaySeconds: %v" $probe.spec.initialDelaySeconds  | nindent 2 }}
          {{- printf "failureThreshold: %v" $probe.spec.failureThreshold  | nindent 2 }}
          {{- printf "timeoutSeconds: %v" $probe.spec.timeoutSeconds  | nindent 2 }}
          {{- printf "periodSeconds: %v" $probe.spec.periodSeconds | nindent 2 }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}
