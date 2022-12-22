{{/* Security Context included by the container */}}
{{- define "ix.v1.common.container.securityContext" -}}
  {{- $secContext := .secCont -}}
  {{- $podSecContext := .podSecCont -}}
  {{- $root := .root -}}

  {{- $defaultSecCont := $root.Values.global.defaults.securityContext -}}
  {{- $runAsNonRoot := $defaultSecCont.runAsNonRoot -}} {{/* TODO: Inherit from main container? */}}
  {{- $readOnlyRootFilesystem := $defaultSecCont.readOnlyRootFilesystem -}}
  {{- $allowPrivilegeEscalation := $defaultSecCont.allowPrivilegeEscalation -}}
  {{- $privileged := $defaultSecCont.privileged -}}
  {{- $capAdd := $defaultSecCont.capabilities.add -}}
  {{- $capDrop := $defaultSecCont.capabilities.drop -}}

  {{/* Check that they are set as booleans to prevent typos */}}
  {{- with $secContext -}}
    {{- if or (not (kindIs "bool" .runAsNonRoot)) (not (kindIs "bool" .privileged)) (not (kindIs "bool" .readOnlyRootFilesystem)) (not (kindIs "bool" .allowPrivilegeEscalation)) -}}
        {{- fail "One or more of the following are not set as booleans (runAsNonRoot, privileged, readOnlyRootFilesystem, allowPrivilegeEscalation)" -}}
    {{- end -}}
  {{- end -}}

  {{/* Override defaults based on user/dev input */}}
  {{- if ne (toString $secContext.runAsNonRoot) (toString $runAsNonRoot) -}}
    {{- $runAsNonRoot = $secContext.runAsNonRoot -}}
  {{- end -}}
  {{- if ne (toString $secContext.readOnlyRootFilesystem) (toString $readOnlyRootFilesystem) -}}
    {{- $readOnlyRootFilesystem = $secContext.readOnlyRootFilesystem -}}
  {{- end -}}
  {{- if ne (toString $secContext.allowPrivilegeEscalation) (toString $allowPrivilegeEscalation) -}}
    {{- $allowPrivilegeEscalation = $secContext.allowPrivilegeEscalation -}}
  {{- end -}}
  {{- if ne (toString $secContext.privileged) (toString $privileged) -}}
    {{- $privileged = $secContext.privileged -}}
  {{- end -}}

  {{/* Only run as root if it's explicitly defined */}}
  {{- if or (eq (int $podSecContext.runAsUser) 0) (eq (int $podSecContext.runAsGroup) 0) -}}
    {{- if $runAsNonRoot -}}
      {{- fail "You are trying to run as root (user or group), but runAsNonRoot is set to true" -}}
    {{- end -}}
  {{- end }}
runAsNonRoot: {{ $runAsNonRoot }}
readOnlyRootFilesystem: {{ $readOnlyRootFilesystem }}
allowPrivilegeEscalation: {{ $allowPrivilegeEscalation }}
privileged: {{ $privileged }} {{/* TODO: Set to true if deviceList is used? */}}
capabilities: {{/* TODO: add NET_BIND_SERVICE when port < 80 is used? */}}
  {{- with $secContext.capabilities -}}
    {{- if or .add .drop -}}
      {{- if or (not (kindIs "slice" .add)) (not (kindIs "slice" .drop)) -}}
        {{- fail "Either <add> or <drop> capabilities is not a list." -}}
      {{- end -}}
      {{- with .add }}
    add:
        {{- range . }}
        - {{ tpl . $root | quote }}
        {{- end -}}
      {{- end -}}
      {{- with .drop }}
    drop:
        {{- range . }}
        - {{ tpl . $root | quote }}
        {{- end -}}
      {{- end -}}
    {{- else }}
    add: {{ $capAdd }}
    drop: {{ $capDrop }}
    {{- end -}}
  {{- end }}
{{- end -}}
