{{/* Security Context included by the container */}}
{{- define "ix.v1.common.controller.securityContext" -}}
{{- $secContext := .Values.securityContext -}}
{{- $podSecContext := .Values.podSecurityContext -}}
{{/* Check that they are set as booleans to prevent typos */}}
{{- with $secContext -}}
 {{- if or (not (kindIs "bool" .runAsNonRoot)) (not (kindIs "bool" .privileged)) (not (kindIs "bool" .readOnlyRootFilesystem)) (not (kindIs "bool" .allowPrivilegeEscalation)) -}}
    {{- fail "One or more of the following are not set as booleans (runAsNonRoot, privileged, readOnlyRootFilesystem, allowPrivilegeEscalation)" -}}
 {{- end -}}
{{- end -}}
{{/* Only run as root if it's explicitly defined */}}
{{- if or (not $podSecContext.runAsUser) (not $podSecContext.runAsGroup) -}}
  {{- if $secContext.runAsNonRoot -}}
    {{- fail "You are trying to run as root (user or group), but runAsNonRoot is set to true"  -}}
  {{- end -}}
{{- end -}}
runAsNonRoot: {{ $secContext.runAsNonRoot }}
readOnlyRootFilesystem: {{ $secContext.readOnlyRootFilesystem }}
allowPrivilegeEscalation: {{ $secContext.allowPrivilegeEscalation }}
privileged: {{ $secContext.privileged }}
capabilities:
{{- if or $secContext.capabilities.add $secContext.capabilities.drop }}
  {{- if or (not (kindIs "slice" $secContext.capabilities.add)) (not (kindIs "slice" $secContext.capabilities.drop)) }}
    {{- fail "Either <add> or <drop> capabilities is not a list."}}
  {{- end }}
  {{- with $secContext.capabilities.add }}
  add:
    {{- range . }}
    - {{ tpl . $ | quote }}
    {{- end }}
  {{- end }}
  {{- with $secContext.capabilities.drop }}
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
