init{{/* Security Context included by the container */}}
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
  {{- range $bool := (list "runAsNonRoot" "privileged" "readOnlyRootFilesystem" "allowPrivilegeEscalation") -}}
    {{- if (hasKey $secContext $bool) -}}
      {{- if not (kindIs "bool" (get $secContext $bool)) -}}
        {{- fail (printf "<%s> key has value (%s). But it must be boolean." $bool (get $secContext $bool)) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- with $secContext -}}
    {{- if or (not (kindIs "bool" .runAsNonRoot)) (not (kindIs "bool" .privileged)) (not (kindIs "bool" .readOnlyRootFilesystem)) (not (kindIs "bool" .allowPrivilegeEscalation)) -}}
        {{- fail "One or more of the following are not set as booleans (runAsNonRoot, privileged, readOnlyRootFilesystem, allowPrivilegeEscalation)" -}}
    {{- end -}}
  {{- end -}}

  {{- if $secContext.inheritMain -}} {{/* if inheritMain is set, use the secContext from main container as default */}}
    {{- $defaultSecCont = $root.Values.securityContext -}}
  {{- end -}} {{/* TODO: Unittests for inherit + normal securityContext */}}

  {{/* Override defaults based on user/dev input */}}
  {{- if and (hasKey $secContext "runAsNonRoot") (ne (toString $secContext.runAsNonRoot) (toString $runAsNonRoot)) -}}
    {{- $runAsNonRoot = $secContext.runAsNonRoot -}}
  {{- end -}}
  {{- if and (hasKey $secContext "readOnlyRootFilesystem") (ne (toString $secContext.readOnlyRootFilesystem) (toString $readOnlyRootFilesystem)) -}}
    {{- $readOnlyRootFilesystem = $secContext.readOnlyRootFilesystem -}}
  {{- end -}}
  {{- if and (hasKey $secContext "allowPrivilegeEscalation") (ne (toString $secContext.allowPrivilegeEscalation) (toString $allowPrivilegeEscalation)) -}}
    {{- $allowPrivilegeEscalation = $secContext.allowPrivilegeEscalation -}}
  {{- end -}}
  {{- if and (hasKey $secContext "privileged") (ne (toString $secContext.privileged) (toString $privileged)) -}}
    {{- $privileged = $secContext.privileged -}}
  {{- end -}}
  {{/* If has key "add" and has items in the list. */}}
  {{- if and (hasKey $secContext.capabilities "add") $secContext.capabilities.add -}}
    {{- $capAdd = $secContext.capabilities.add -}}
  {{- end -}}
  {{/* If has key "drop" and has items in the list. */}}
  {{- if and (hasKey $secContext.capabilities "drop") $secContext.capabilities.drop -}}
    {{- $capDrop = $secContext.capabilities.drop -}}
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
  {{- if or (not (kindIs "slice" $capAdd)) (not (kindIs "slice" $capDrop)) -}}
    {{- fail "Either <add> or <drop> capabilities is not a list." -}}
  {{- end -}}
  {{- with $capAdd }}
  add:
    {{- range . }}
    - {{ tpl . $root | quote }}
    {{- end -}}
  {{- else }}
  add: []
  {{- end -}}
  {{- with $capDrop }}
  drop:
    {{- range . }}
    - {{ tpl . $root | quote }}
    {{- end -}}
  {{- else }}
  drop: []
  {{- end -}}
{{- end -}}
