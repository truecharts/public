{{/* Security Context included by the container */}}
{{- define "ix.v1.common.container.securityContext" -}}
  {{- $secCont := .secCont -}}
  {{- $isMainContainer := .isMainContainer -}}
  {{- $deviceList := .deviceList -}}
  {{- $scaleGPU := .scaleGPU -}}
  {{- $ports := .ports -}}
  {{- $root := .root -}}

  {{/* Calculate all security values */}}
  {{- $security := (include "ix.v1.common.lib.securityContext"  (dict "root" $root
                                                                      "secCont" $secCont
                                                                      "deviceList" $deviceList
                                                                      "isMainContainer" $isMainContainer
                                                                      "ports" $ports) | fromJson) -}}

  {{/* Only run as root if it's explicitly defined */}}
  {{- if or (eq (int $security.runAsUser) 0) (eq (int $security.runAsGroup) 0) -}}
    {{- if $security.runAsNonRoot -}}
      {{- fail (printf "You are trying to run as root (user or group), but runAsNonRoot is set to %v" $security.runAsNonRoot) -}}
    {{- end -}}
  {{- end }}
runAsNonRoot: {{ $security.runAsNonRoot }}
runAsUser: {{ $security.runAsUser }}
runAsGroup: {{ $security.runAsGroup }}
readOnlyRootFilesystem: {{ $security.readOnlyRootFilesystem }}
allowPrivilegeEscalation: {{ $security.allowPrivilegeEscalation }}
privileged: {{ $security.privileged }}
capabilities:
  {{- with $security.capabilities.add }}
  add:
    {{- range . }}
    - {{ tpl . $root | quote }}
    {{- end -}}
  {{- else }}
  add: []
  {{- end -}}
  {{- with $security.capabilities.drop }}
  drop:
    {{- range . }}
    - {{ tpl . $root | quote }}
    {{- end -}}
  {{- else }}
  drop: []
  {{- end -}}
{{- end -}}
