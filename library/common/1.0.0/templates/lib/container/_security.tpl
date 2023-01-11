{{/*
Bellow function calculates security values, based on defaults,
inherit or not, or overrides.
This function is used if few places, on each place it only requires
a subset of the actual output. Depending on the input (secCont, podSecCont, secEnvs),
it returns an object with the calculated values and default values for the rest.
The reason is not splitted, is that on one of the places needs a combo of all values calculated.
*/}}
{{- define "ix.v1.common.lib.securityContext" -}}
  {{- $root := .root -}}
  {{- $secCont := .secCont -}}
  {{- $deviceList := .deviceList -}}
  {{- $ports := .ports -}}
  {{- $isMainContainer := .isMainContainer -}}

  {{/* Initialiaze Values */}}
  {{- $defaultSecCont := $root.Values.global.defaults.securityContext -}}
  {{- $returnValue := (mustDeepCopy $defaultSecCont) -}}

  {{- if and (hasKey $secCont "inherit") $isMainContainer -}}
    {{- fail "<securityContext.inherit> key is only available for additional/init/install/upgrade containers." -}}
  {{- end -}}

  {{- if and $secCont.inherit (not $isMainContainer) -}} {{/* if inherit is set, overwrite values from mainContainer */}}
    {{- if (hasKey $root.Values "securityContext") -}}
      {{- $returnValue = mustMergeOverwrite $returnValue $root.Values.securityContext -}}
    {{- end -}}
  {{- end -}}

  {{/* Overwrite from values that user/dev passed on this container */}}
  {{- if $secCont -}} {{/* If secCont is empty don't try to merge */}}
    {{- $returnValue = mustMergeOverwrite $returnValue $secCont -}}
  {{- end -}}

  {{- $isPrivilegedPort := false -}}

  {{- if $isMainContainer -}}
    {{- range $svcName, $svc := $root.Values.service -}}
      {{- if $svc.enabled -}}
        {{- range $portName, $port := $svc.ports -}}
          {{- if $port.enabled -}} {{/* We failback to port if no targetPort is given */}}
            {{- $portNumber := ($port.targetPort | default $port.port) -}}
            {{- if le (int $portNumber) 1024 -}}
              {{- $isPrivilegedPort = true -}}
            {{- end -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- else -}}
    {{- range $port := $ports -}}
      {{- if le (int $port.containerPort) 1024 -}}
        {{- $isPrivilegedPort = true -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{/* If at least on port is the specific container uses a port <=1024, add the NET_BIND_SERVICE capability */}}
  {{- if $isPrivilegedPort -}}
    {{- $_ := set $returnValue.capabilities "add" (mustAppend $returnValue.capabilities.add "NET_BIND_SERVICE") -}}
  {{- end -}}

  {{/* Devices need privileged container */}}
  {{- if $deviceList -}}
    {{- $_ := set $returnValue "privileged" true -}}
    {{- $_ := set $returnValue "allowPrivilegeEscalation" true -}}
  {{- end -}}

  {{/* Validate values, as mergeOverwrite also passes null values */}}
  {{- if not (kindIs "bool" $returnValue.runAsNonRoot) -}}
    {{- fail (printf "<runAsNonRoot> key has value (%v). But it must be boolean." $returnValue.runAsNonRoot) -}}
  {{- end -}}

  {{- if not (kindIs "bool" $returnValue.readOnlyRootFilesystem) -}}
    {{- fail (printf "<readOnlyRootFilesystem> key has value (%v). But it must be boolean." $returnValue.readOnlyRootFilesystem) -}}
  {{- end -}}

  {{- if not (kindIs "bool" $returnValue.allowPrivilegeEscalation) -}}
    {{- fail (printf "<allowPrivilegeEscalation> key has value (%v). But it must be boolean." $returnValue.allowPrivilegeEscalation) -}}
  {{- end -}}

  {{- if not (kindIs "bool" $returnValue.privileged) -}}
    {{- fail (printf "<privileged> key has value (%v). But it must be boolean." $returnValue.privileged) -}}
  {{- end -}}

  {{- if eq (toString $returnValue.runAsUser) "<nil>" -}}
    {{- fail (printf "<runAsUser> key cannot be empty. Set a value or remove the key for the default (%v) to take effect." $defaultSecCont.runAsUser) -}}
  {{- else if not (mustHas (kindOf $returnValue.runAsUser) (list "int" "float64")) -}}
    {{- fail (printf "<runAsUser> key has value of (%q). But must be an int." $returnValue.runAsUser) -}}
  {{- end -}}

  {{- if eq (toString $returnValue.runAsGroup) "<nil>" -}}
    {{- fail (printf "<runAsGroup> key cannot be empty. Set a value or remove the key for the default (%v) to take effect." $defaultSecCont.runAsGroup) -}}
  {{- else if not (mustHas (kindOf $returnValue.runAsGroup) (list "int" "float64")) -}}
    {{- fail (printf "<runAsGroup> key has value of (%q). But must be an int." $returnValue.runAsGroup) -}}
  {{- end -}}

  {{- if not (kindIs "slice" $returnValue.capabilities.add) -}}
    {{- fail (printf "<capabilities.add> key has value (%v). But it must be a list. Set a list value or remove the key for the default (%v) to take effect." $returnValue.capabilities.add $defaultSecCont.capabilities.add) -}}
  {{- end -}}

  {{- if not (kindIs "slice" $returnValue.capabilities.drop) -}}
    {{- fail (printf "<capabilities.drop> key has value (%v). But it must be a list. Set a list value or remove the key for the default (%v) to take effect." $returnValue.capabilities.drop $defaultSecCont.capabilities.drop) -}}
  {{- end -}}

  {{- $returnValue | toJson -}}
{{- end -}}

{{- define "ix.v1.common.lib.podSecurityContext" -}}
  {{- $root := .root -}}
  {{- $isJob := .isJob -}}
  {{- $podSecCont := .podSecCont -}}

  {{/* Initialiaze Values */}}
  {{- $defaultPodSecCont := $root.Values.global.defaults.podSecurityContext -}}
  {{- $returnValue := (mustDeepCopy $defaultPodSecCont) -}}

  {{/* Overwrite from values that user/dev passed */}}
  {{- $returnValue = mustMergeOverwrite $returnValue $podSecCont -}}

  {{- $appendGPUGroup := false -}}
  {{- $appendDeviceGroups := false -}}

  {{- if $root.Values.scaleGPU -}}
    {{- $appendGPUGroup = true -}}
  {{- end -}}

  {{- if $root.Values.deviceList -}}
    {{- $appendDeviceGroups = true -}}
  {{- end -}}

  {{/* If at least one of those is not true, lets make sure it's not needed by any other container */}}
  {{- if or (not $appendDeviceGroups) (not $appendGPUGroup) -}}
    {{- if not $isJob -}}
      {{- range $key := (list "initContainers" "installContainers" "upgradeContainers" "additionalContainers") -}}
        {{/* If they have containers defined... */}}
        {{- if (get $root.Values $key) -}}

          {{/* Go over the containers */}}
          {{- range $containerName, $container := (get $root.Values $key) -}}
            {{/* If the container has deviceList */}}
            {{- if hasKey $container "deviceList" -}}
              {{- if $container.deviceList -}}
                {{- $appendDeviceGroups = true -}}
              {{- end -}}
            {{- end -}}
            {{/* If the container has scaleGPU */}}
            {{- if hasKey $container "scaleGPU" -}}
              {{- if $container.scaleGPU -}}
                {{- $appendGPUGroup = true -}}
              {{- end -}}
            {{- end -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- else -}}
      {{- range $jobName, $job := $root.Values.jobs -}}
        {{- if $job.enabled -}}
          {{- range $name, $container := $job.podSpec.containers -}}
            {{- if hasKey $container "scaleGPU" -}}
              {{- if $container.scaleGPU -}}
                {{/* If at least 1 container has GPU... */}}
                {{- $appendGPUGroup = true -}}
              {{- end -}}
            {{- end -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if $appendDeviceGroups -}}
    {{/* Append the "tty" Group */}}
    {{- $_ := set $returnValue "supplementalGroups" (mustAppend $returnValue.supplementalGroups 5) -}}
    {{/* Append the "uucp" Group (used for USB/TTY/RS232) */}}
    {{- $_ := set $returnValue "supplementalGroups" (mustAppend $returnValue.supplementalGroups 10) -}}
    {{/* Append the "dialout" Group */}}
    {{- $_ := set $returnValue "supplementalGroups" (mustAppend $returnValue.supplementalGroups 20) -}}
    {{/* Append "cdrom" Group */}}
    {{- $_ := set $returnValue "supplementalGroups" (mustAppend $returnValue.supplementalGroups 24) -}}
  {{- end -}}

  {{- if $appendGPUGroup -}}
    {{/* Append "video" Group */}}
    {{- $_ := set $returnValue "supplementalGroups" (mustAppend $returnValue.supplementalGroups 44) -}}
  {{- end -}}

  {{/* Validate values, as mergeOverwrite also passes null values */}}
  {{- if eq (toString $returnValue.fsGroup) "<nil>" -}}
    {{- fail (printf "<fsGroup> key cannot be empty. Set a value or remove the key for the default (%v) to take effect." $defaultPodSecCont.fsGroup) -}}
  {{- else if not (mustHas (kindOf $returnValue.fsGroup) (list "int" "float64")) -}}
    {{- fail (printf "<fsGroup> key has value of (%q). But must be an int." $returnValue.fsGroup) -}}
  {{- end -}}

  {{- if not $returnValue.fsGroupChangePolicy -}}
    {{- fail (printf "<fsGroupChangePolicy> key cannot be empty. Set a value or remove the key for the default (%s) to take effect." $defaultPodSecCont.fsGroupChangePolicy) -}}
  {{- end -}}

  {{- if not (kindIs "slice" $returnValue.supplementalGroups) -}}
    {{- fail (printf "<supplementalGroups> key has a value (%v). But it must be a list. Set a list value or remove the key for the default (%v) to take effect." $returnValue.supplementalGroups $defaultPodSecCont.supplementalGroups) -}}
  {{- end -}}

  {{- $returnValue | toJson -}}
{{- end -}}

{{- define "ix.v1.common.lib.securityEnvs" -}}
  {{- $root := .root -}}
  {{- $secEnvs := .secEnvs -}}

  {{/* Initialiaze Values */}}
  {{- $defaultSecEnvs := $root.Values.global.defaults.security -}}
  {{- $returnValue := (mustDeepCopy $defaultSecEnvs) -}}

  {{/* Overwrite from values that user/dev passed */}}
  {{- $returnValue = mustMergeOverwrite $returnValue $secEnvs -}}

  {{/* Validate values, as mergeOverwrite also passes null values */}}
  {{- if not $returnValue.UMASK -}}
    {{- fail (printf "<UMASK> key cannot be empty. Set a value or remove the key for the default (%v) to take effect." $defaultSecEnvs.UMASK) -}}
  {{- else if not (kindIs "string" $returnValue.UMASK) -}}
    {{- fail (printf "<UMASK> key must be a string, so the format is kept intact.") -}}
  {{- end -}}

  {{- if eq (toString $returnValue.PUID) "<nil>" -}}
    {{- fail (printf "<PUID> key cannot be empty. Set a value or remove the key for the default (%v) to take effect." $defaultSecEnvs.PUID) -}}
  {{- else if not (mustHas (kindOf $returnValue.PUID) (list "int" "float64")) -}}
    {{- fail (printf "<PUID> key has value of (%q). But must be an int." $returnValue.PUID) -}}
  {{- end -}}

  {{- $returnValue | toJson -}}
{{- end -}}
