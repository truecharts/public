{{/* Security Context included by the container */}}
{{- define "ix.v1.common.container.securityContext" -}}
  {{- $secCont := .secCont -}}
  {{- $isMainContainer := .isMainContainer -}}
  {{- $root := .root -}}

  {{- $defaultSecCont := $root.Values.global.defaults.securityContext -}}

  {{- if and (hasKey $secCont "inherit") $isMainContainer -}}
    {{- fail "<inherit> key is only available for additional/init/install/upgrade containers." -}}
  {{- end -}}
  {{- if and $secCont.inherit (not $isMainContainer) -}} {{/* if inherit is set, use the secContext from main container as default */}}
    {{- if gt (len (keys $secCont)) 1 -}}
      {{- fail (printf "Overriding inherited securityContext is not supported. Please unset inherit or remove the keys (%s)" (without (keys $secCont) "inherit")) -}}
    {{- end -}}
    {{- $secCont = $root.Values.securityContext -}}
  {{- end -}}

  {{/* Init Values */}}
  {{- $runAsNonRoot := $defaultSecCont.runAsNonRoot -}}
  {{- $runAsUser := $defaultSecCont.runAsUser -}}
  {{- $runAsGroup := $defaultSecCont.runAsGroup -}}
  {{- $readOnlyRootFilesystem := $defaultSecCont.readOnlyRootFilesystem -}}
  {{- $allowPrivilegeEscalation := $defaultSecCont.allowPrivilegeEscalation -}}
  {{- $privileged := $defaultSecCont.privileged -}}
  {{- $capAdd := $defaultSecCont.capabilities.add -}}
  {{- $capDrop := $defaultSecCont.capabilities.drop -}}

  {{/* Override based on user/dev input */}}
  {{- if (hasKey $secCont "runAsNonRoot") -}}
    {{- if not (kindIs "bool" $secCont.runAsNonRoot) -}}
      {{- fail (printf "<runAsNonRoot> key has value (%v). But it must be boolean." $secCont.runAsNonRoot) -}}
    {{- else if or (eq $secCont.runAsNonRoot true) (eq $secCont.runAsNonRoot false) -}}
      {{- $runAsNonRoot = $secCont.runAsNonRoot -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $secCont "readOnlyRootFilesystem") -}}
    {{- if not (kindIs "bool" $secCont.readOnlyRootFilesystem) -}}
      {{- fail (printf "<readOnlyRootFilesystem> key has value (%v). But it must be boolean." $secCont.readOnlyRootFilesystem) -}}
    {{- else if or (eq $secCont.readOnlyRootFilesystem true) (eq $secCont.readOnlyRootFilesystem false) -}}
      {{- $readOnlyRootFilesystem = $secCont.readOnlyRootFilesystem -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $secCont "allowPrivilegeEscalation") -}}
    {{- if not (kindIs "bool" $secCont.allowPrivilegeEscalation) -}}
      {{- fail (printf "<allowPrivilegeEscalation> key has value (%v). But it must be boolean." $secCont.allowPrivilegeEscalation) -}}
    {{- else if or (eq $secCont.allowPrivilegeEscalation true) (eq $secCont.allowPrivilegeEscalation false) -}}
      {{- $allowPrivilegeEscalation = $secCont.allowPrivilegeEscalation -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $secCont "privileged") -}}
    {{- if not (kindIs "bool" $secCont.privileged) -}}
      {{- fail (printf "<privileged> key has value (%v). But it must be boolean." $secCont.privileged) -}}
    {{- else if or (eq $secCont.privileged true) (eq $secCont.privileged false) -}}
      {{- $privileged = $secCont.privileged -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $secCont "runAsUser") -}}
    {{- if eq (toString $secCont.runAsUser) "<nil>" -}}
      {{- fail (printf "<runAsUser> key cannot be empty. Set a value or remove the key for the default (%v) to take effect." $runAsUser) -}}
    {{- else if ge (int $secCont.runAsUser) 0 -}}
      {{- $runAsUser = $secCont.runAsUser -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $secCont "runAsGroup") -}}
    {{- if eq (toString $secCont.runAsGroup) "<nil>" -}}
      {{- fail (printf "<runAsGroup> key cannot be empty. Set a value or remove the key for the default (%v) to take effect." $runAsGroup) -}}
    {{- else if ge (int $secCont.runAsGroup) 0 -}}
      {{- $runAsGroup = $secCont.runAsGroup -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $secCont "capabilities") -}}
    {{- if (hasKey $secCont.capabilities "add") -}}
      {{- if $secCont.capabilities.add -}}
        {{- $capAdd = $secCont.capabilities.add -}}
      {{- else -}}
        {{- fail (printf "<capabilities.add> key cannot be empty. Set a value or remove the key for the default (%s) to take effect." $capAdd) -}}
      {{- end -}}
    {{- end -}}
    {{- if (hasKey $secCont.capabilities "drop") -}}
      {{- if $secCont.capabilities.drop -}}
        {{- $capDrop = $secCont.capabilities.drop -}}
      {{- else -}}
        {{- fail (printf "<capabilities.drop> key cannot be empty. Set a value or remove the key for the default (%s) to take effect." $capDrop) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{/* Check that they are still set as booleans after the overrides to prevent errors */}}
  {{- range $bool := (list $runAsNonRoot $privileged $readOnlyRootFilesystem $allowPrivilegeEscalation) -}}
    {{- if not (kindIs "bool" $bool) -}}
      {{- fail (printf "One of <runAsNonRoot>, <privileged>, <readOnlyRootFilesystem>, <allowPrivilegeEscalation> has value of (%s). But it must be boolean." $bool) -}}
    {{- end -}}
  {{- end -}}

  {{/* Only run as root if it's explicitly defined */}}
  {{- if or (eq (int $runAsUser) 0) (eq (int $runAsGroup) 0) -}}
    {{- if $runAsNonRoot -}}
      {{- fail (printf "You are trying to run as root (user or group), but runAsNonRoot is set to %v" $runAsNonRoot) -}}
    {{- end -}}
  {{- end }}
runAsNonRoot: {{ $runAsNonRoot }}
runAsUser: {{ $runAsUser }}
runAsGroup: {{ $runAsGroup }}
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
