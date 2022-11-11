{{/* Security Context included by the container */}}
{{- define "ix.v1.common.controller.securityContext" -}}
{{/* Check that they are set as booleans to prevent typos */}}
{{- with .Values.securityContext -}}
 {{- if or (not (kindIs "bool" .runAsNonRoot)) (not (kindIs "bool" .privileged)) (not (kindIs "bool" .readOnlyRootFilesystem)) (not (kindIs "bool" .allowPrivilegeEscalation)) -}}
    {{- fail "One or more of the following are not set as booleans (runAsNonRoot, privileged, readOnlyRootFilesystem, allowPrivilegeEscalation)" -}}
 {{- end -}}
{{- end -}}
{{/* Only run as root if it's explicitly defined */}}
{{- if or (not .Values.podSecurityContext.runAsUser) (not .Values.podSecurityContext.runAsGroup) -}}
  {{- if .Values.securityContext.runAsNonRoot -}}
    {{- fail "You are trying to run as root (user or group), but runAsNonRoot is set to true" -}}
  {{- end -}}
{{- end -}}
runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
allowPrivilegeEscalation: {{ .Values.securityContext.allowPrivilegeEscalation }}
privileged: {{ .Values.securityContext.privileged }}
capabilities:
{{- if or .Values.securityContext.capabilities.add .Values.securityContext.capabilities.drop }}
  {{- if or (not (kindIs "slice" .Values.securityContext.capabilities.add)) (not (kindIs "slice" .Values.securityContext.capabilities.drop)) }}
    {{- fail "Either <add> or <drop> capabilities is not a list."}}
  {{- end }}
  {{- with .Values.securityContext.capabilities.add }}
  add:
    {{- range . }}
    - {{ tpl . $ | quote }}
    {{- end }}
  {{- end }}
  {{- with .Values.securityContext.capabilities.drop }}
  drop:
    {{- range . }}
    - {{ tpl . $ | quote }}
    {{- end }}
  {{- end }}
{{- else }}
  add: []
  drop: []
{{- end }}
{{- end -}}
