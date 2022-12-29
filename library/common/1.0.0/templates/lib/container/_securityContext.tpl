{{/* Security Context included by the container */}}
{{- define "ix.v1.common.container.securityContext" -}}
  {{- $secCont := .secCont -}}
  {{- $isMainContainer := .isMainContainer -}}
  {{- $root := .root -}}

  {{/* Calculate all security values */}}
  {{- $security := (include "ix.v1.common.lib.security" (dict "root" $root "secCont" $secCont "isMainContainer" $isMainContainer) | fromJson) -}}

  {{/* Check that they are still set as booleans after the overrides to prevent errors */}}
  {{- range $key := (list "runAsNonRoot" "privileged" "readOnlyRootFilesystem" "allowPrivilegeEscalation") -}}
    {{- $value := (get $security $key) -}}
    {{- if not (kindIs "bool" $value) -}}
      {{- fail (printf "Key <%s> has value of (%s). But it must be boolean." $key $value) -}}
    {{- end -}}
  {{- end -}}

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
privileged: {{ $security.privileged }} {{/* TODO: Set to true if deviceList is used? */}}
capabilities: {{/* TODO: add NET_BIND_SERVICE when port < 80 is used? */}}
  {{- if or (not (kindIs "slice" $security.capAdd)) (not (kindIs "slice" $security.capDrop)) -}}
    {{- fail "Either <add> or <drop> capabilities is not a list." -}}
  {{- end -}}
  {{- with $security.capAdd }}
  add:
    {{- range . }}
    - {{ tpl . $root | quote }}
    {{- end -}}
  {{- else }}
  add: []
  {{- end -}}
  {{- with $security.capDrop }}
  drop:
    {{- range . }}
    - {{ tpl . $root | quote }}
    {{- end -}}
  {{- else }}
  drop: []
  {{- end -}}
{{- end -}}
