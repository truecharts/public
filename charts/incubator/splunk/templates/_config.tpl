{{/* Define the configmap */}}
{{- define "splunk.config" -}}

{{- $splunkConfig := printf "%s-splunk-Config" (include "tc.common.names.fullname" .) }}
{{- $argList := list -}}


---

{{/* This configmap are loaded on both main authentik container and worker */}}
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $splunkArgs }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  {{- if .Values.splunk.acceptLicense -}}
    {{- $argList := append $argList "--accept-license" -}}
  {{- end -}}

  {{- with .Values.splunk.extraArgs -}}
    {{- range . -}}
      {{- $argList := append $argList . -}}
    {{- end -}}
  {{- end -}}

  {{- with $argList }}
  SPLUNK_START_ARGS: {{ join " " . | quote }}
  {{- end }}

  {{- with .Values.splunk.password }}
  SPLUNK_PASSWORD: {{ . }}
  {{- end }}
