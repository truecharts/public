{{/*
Bellow function calculates security values, based on defaults,
inherit or not, or overrides.
This function is used if few places, on each place it only requires
a subset of the actual output. Depending on the input (secCont, podSecCont, secEnvs),
it returns an object with the calculated values and default values for the rest.
The reason is not splitted, is that on one of the places needs a combo of all values calculated.
*/}}
{{- define "ix.v1.common.lib.security" -}}
  {{- $root := .root -}}
  {{- $secCont := .secCont -}}
  {{- $podSecCont := .podSecCont -}}
  {{- $secEnvs := .secEnvs -}}
  {{- $isMainContainer := .isMainContainer -}}

  {{/* TODO: deviceList + suppleGroups */}}
  {{- $defaultPodSecCont := $root.Values.global.defaults.podSecurityContext -}}
  {{- $defaultSecCont := $root.Values.global.defaults.securityContext -}}
  {{- $defaultSecEnvs := $root.Values.global.defaults.security -}}
  {{- $returnValue := dict -}}

  {{- if and (hasKey $secCont "inherit") $isMainContainer -}}
    {{- fail "<inherit> key is only available for additional/init/install/upgrade containers." -}}
  {{- end -}}

  {{- if and $secCont.inherit (not $isMainContainer) -}} {{/* if inherit is set, use the secContext from main container as default */}}
    {{- if gt (len (keys $secCont)) 1 -}}
      {{- fail (printf "Overriding inherited securityContext is not supported. Please unset inherit or remove the keys (%s)" (without (keys $secCont) "inherit")) -}}
      {{/* TODO: allow override single values after inherit / TODO: resolve all this bellow with mustMergeOverwrite and untagle the mess */}}
    {{- end -}}
    {{- $secCont = $root.Values.securityContext -}}
  {{- end -}}

  {{/* Initialiaze Values */}}
  {{- $_ := set $returnValue "capAdd" $defaultSecCont.capabilities.add -}}
  {{- $_ := set $returnValue "capDrop" $defaultSecCont.capabilities.drop -}}
  {{- $_ := set $returnValue "runAsNonRoot" $defaultSecCont.runAsNonRoot -}}
  {{- $_ := set $returnValue "runAsGroup" $defaultSecCont.runAsGroup -}}
  {{- $_ := set $returnValue "readOnlyRootFilesystem" $defaultSecCont.readOnlyRootFilesystem -}}
  {{- $_ := set $returnValue "allowPrivilegeEscalation" $defaultSecCont.allowPrivilegeEscalation -}}
  {{- $_ := set $returnValue "privileged" $defaultSecCont.privileged -}}
  {{- $_ := set $returnValue "runAsUser" $defaultSecCont.runAsUser -}}
  {{- $_ := set $returnValue "fsGroup" $defaultPodSecCont.fsGroup -}}
  {{- $_ := set $returnValue "fsGroupChangePolicy" $defaultPodSecCont.fsGroupChangePolicy -}}
  {{- $_ := set $returnValue "supplementalGroups" $defaultPodSecCont.supplementalGroups -}}
  {{- $_ := set $returnValue "UMASK" $defaultSecEnvs.UMASK -}}
  {{- $_ := set $returnValue "PUID" $defaultSecEnvs.PUID -}}

  {{/* Override based on user/dev input */}}
  {{- if (hasKey $secCont "runAsNonRoot") -}}
    {{- if not (kindIs "bool" $secCont.runAsNonRoot) -}}
      {{- fail (printf "<runAsNonRoot> key has value (%v). But it must be boolean." $secCont.runAsNonRoot) -}}
    {{- else if or (eq $secCont.runAsNonRoot true) (eq $secCont.runAsNonRoot false) -}}
      {{- $_ := set $returnValue "runAsNonRoot" $secCont.runAsNonRoot -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $secCont "readOnlyRootFilesystem") -}}
    {{- if not (kindIs "bool" $secCont.readOnlyRootFilesystem) -}}
      {{- fail (printf "<readOnlyRootFilesystem> key has value (%v). But it must be boolean." $secCont.readOnlyRootFilesystem) -}}
    {{- else if or (eq $secCont.readOnlyRootFilesystem true) (eq $secCont.readOnlyRootFilesystem false) -}}
      {{- $_ := set $returnValue "readOnlyRootFilesystem" $secCont.readOnlyRootFilesystem -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $secCont "allowPrivilegeEscalation") -}}
    {{- if not (kindIs "bool" $secCont.allowPrivilegeEscalation) -}}
      {{- fail (printf "<allowPrivilegeEscalation> key has value (%v). But it must be boolean." $secCont.allowPrivilegeEscalation) -}}
    {{- else if or (eq $secCont.allowPrivilegeEscalation true) (eq $secCont.allowPrivilegeEscalation false) -}}
      {{- $_ := set $returnValue "allowPrivilegeEscalation" $secCont.allowPrivilegeEscalation -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $secCont "privileged") -}}
    {{- if not (kindIs "bool" $secCont.privileged) -}}
      {{- fail (printf "<privileged> key has value (%v). But it must be boolean." $secCont.privileged) -}}
    {{- else if or (eq $secCont.privileged true) (eq $secCont.privileged false) -}}
      {{- $_ := set $returnValue "privileged" $secCont.privileged -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $secCont "runAsUser") -}}
    {{- if eq (toString $secCont.runAsUser) "<nil>" -}}
      {{- fail (printf "<runAsUser> key cannot be empty. Set a value or remove the key for the default (%v) to take effect." $defaultSecCont.runAsUser) -}}
    {{- else if ge (int $secCont.runAsUser) 0 -}}
      {{- $_ := set $returnValue "runAsUser" $secCont.runAsUser -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $secCont "runAsGroup") -}}
    {{- if eq (toString $secCont.runAsGroup) "<nil>" -}}
      {{- fail (printf "<runAsGroup> key cannot be empty. Set a value or remove the key for the default (%v) to take effect." $defaultSecCont.runAsGroup) -}}
    {{- else if ge (int $secCont.runAsGroup) 0 -}}
      {{- $_ := set $returnValue "runAsGroup" $secCont.runAsGroup -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $secCont "capabilities") -}}
    {{- if (hasKey $secCont.capabilities "add") -}}
      {{- if $secCont.capabilities.add -}}
        {{- $_ := set $returnValue "capAdd" $secCont.capabilities.add -}}
      {{- else -}}
        {{- fail (printf "<capabilities.add> key cannot be empty. Set a value or remove the key for the default (%s) to take effect." $defaultSecCont.capabilities.add) -}}
      {{- end -}}
    {{- end -}}
    {{- if (hasKey $secCont.capabilities "drop") -}}
      {{- if $secCont.capabilities.drop -}}
        {{- $_ := set $returnValue "capDrop" $secCont.capabilities.drop -}}
      {{- else -}}
        {{- fail (printf "<capabilities.drop> key cannot be empty. Set a value or remove the key for the default (%s) to take effect." $defaultSecCont.capabilities.add) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $podSecCont "fsGroup") -}}
    {{- if eq (toString $podSecCont.fsGroup) "<nil>" -}}
      {{- fail (printf "<fsGroup> key cannot be empty. Set a value or remove the key for the default (%v) to take effect." $defaultPodSecCont.fsGroup) -}}
    {{- else if ge (int $podSecCont.fsGroup) 0 -}}
      {{- $_ := set $returnValue "fsGroup" $podSecCont.fsGroup -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $podSecCont "fsGroupChangePolicy") -}}
    {{- if $podSecCont.fsGroupChangePolicy -}}
      {{- $_ := set $returnValue "fsGroupChangePolicy" $podSecCont.fsGroupChangePolicy -}}
    {{- else -}}
      {{- fail (printf "<fsGroupChangePolicy> key cannot be empty. Set a value or remove the key for the default (%s) to take effect." $defaultPodSecCont.fsGroupChangePolicy) -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $podSecCont "supplementalGroups") -}}
    {{- if $podSecCont.supplementalGroups -}}
      {{- $_ := set $returnValue "supplementalGroups" $podSecCont.supplementalGroups -}}
    {{- else -}}
      {{- fail (printf "<supplementalGroups> key cannot be empty. Set a value or remove the key for the default (%s) to take effect." $defaultPodSecCont.supplementalGroups) -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $secEnvs "UMASK") -}}
    {{- if not $secEnvs.UMASK -}}
      {{- fail (printf "<UMASK> key cannot be empty. Set a value or remove the key for the default (%v) to take effect." $defaultSecEnvs.UMASK) -}}
    {{- else if not (kindIs "string" $secEnvs.UMASK) -}}
      {{- fail (printf "<UMASK> key must be a string, so the format is kept intact.") -}}
    {{- else if $secEnvs.UMASK -}}
      {{- $_ := set $returnValue "UMASK" $secEnvs.UMASK -}}
    {{- end -}}
  {{- end -}}

  {{- if (hasKey $secEnvs "PUID") -}}
    {{- if eq (toString $secEnvs.PUID) "<nil>" -}}
      {{- fail (printf "<PUID> key cannot be empty. Set a value or remove the key for the default (%v) to take effect." $defaultSecEnvs.PUID) -}}
    {{- else if not (mustHas (kindOf $secEnvs.PUID) (list "int" "float64")) -}}
      {{- fail "<PUID> key must be an int." -}}
    {{- else if ge (int $secEnvs.PUID) 0 -}}
      {{- $_ := set $returnValue "PUID" $secEnvs.PUID -}}
    {{- end -}}
  {{- end -}}

  {{- $returnValue | toJson -}}
{{- end -}}
