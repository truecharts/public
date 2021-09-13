{{/*
Probes selection logic.
*/}}
{{- define "common.controller.probes" -}}
{{- $primaryService := get .Values.service (include "common.service.primary" .) -}}
{{- $primaryPort := "" -}}
{{- if $primaryService -}}
  {{- $primaryPort = get $primaryService.ports (include "common.classes.service.ports.primary" (dict "serviceName" (include "common.service.primary" .) "values" $primaryService)) -}}
{{- end -}}
{{- $probeType := "TCP" -}}

{{- range $probeName, $probe := .Values.probes }}
  {{- if $probe.enabled -}}
    {{- $probeType = "TCP" -}}
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
              {{- $probeType := $probe.type -}}
            {{- end }}
          {{- end }}

          {{- if or ( eq $probeType "HTTPS" ) ( eq $probeType "HTTP" ) -}}
              {{- "httpGet:" | nindent 2 }}
                {{- printf "path: %v" $probe.path | nindent 4 }}
                {{- printf "scheme: %v" $probeType | nindent 4 }}
          {{- else -}}
            {{- "tcpSocket:" | nindent 2 }}
          {{- end }}

          {{- if $primaryPort.targetPort }}
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
