{{/*
Probes selection logic.
*/}}
{{- define "common.controller.probes" -}}
{{- $primaryService := get .Values.service (include "common.service.primary" .) -}}
{{- $primaryPort := "" -}}
{{- if $primaryService -}}
  {{- $primaryPort = get $primaryService.ports (include "common.classes.service.ports.primary" (dict "serviceName" (include "common.service.primary" .) "values" $primaryService)) -}}
{{- end -}}

{{- range $probeName, $probe := .Values.probes }}
  {{- if $probe.enabled -}}
    {{- "" | nindent 0 }}
    {{- $probeName }}Probe:
    {{- if $probe.custom -}}
      {{- $probe.spec | toYaml | nindent 2 }}
    {{- else }}
      {{- if and $primaryService $primaryPort -}}
        {{- if or ( eq $primaryPort.protocol "HTTP" ) ( eq $primaryPort.protocol "HTTPS" ) -}}
          {{- "httpGet:" | nindent 2 }}
            {{- printf "path: %v" $probe.path | nindent 4 }}
            {{- ( printf "path: %v" "/" ) | nindent 4 }}
            {{- printf "scheme: %v" $primaryPort.protocol | nindent 4 }}
        {{- else -}}
          {{- "tcpSocket:" | nindent 2 }}
            {{- printf "port: %v" $primaryPort.port  | nindent 4 }}
        {{- end }}
            {{- printf "port: %v" $primaryPort.port  | nindent 4 }}
        {{- printf "initialDelaySeconds: %v" $probe.spec.initialDelaySeconds  | nindent 2 }}
        {{- printf "failureThreshold: %v" $probe.spec.failureThreshold  | nindent 2 }}
        {{- printf "timeoutSeconds: %v" $probe.spec.timeoutSeconds  | nindent 2 }}
        {{- printf "periodSeconds: %v" $probe.spec.periodSeconds | nindent 2 }}
      {{- end }}
    {{- end }}
  {{- end }}
{{- end }}
{{- end }}
