{{- define "ix.v1.common.lib.values.deviceList" -}}
  {{- $root := . -}}

  {{/* Go over the device list on the main container */}}
  {{- range $index, $device := $root.Values.deviceList -}}
    {{/* Generate the name */}}
    {{- $name := (printf "device-%s" (toString $index)) -}}

    {{- with $device.name -}}
      {{- $name = . -}}
    {{- end -}}

    {{/* Make sure a persistence dict exists before trying to add items */}}
    {{- if not (hasKey $root.Values "persistence") -}}
      {{- $_ := set $root.Values "persistence" dict -}}
    {{- end -}}

    {{/* Add the device as a persistence dict,
    other templates will take care of the
    volume and volumeMounts */}}
    {{- $_ := set $root.Values.persistence $name $device -}}
  {{- end -}}

  {{/* Go over all types of containers */}}
  {{- range $key := (list "initContainers" "systemContainers" "installContainers" "upgradeContainers" "additionalContainers") -}}
    {{/* If they have containers defined... */}}
    {{- if (get $root.Values $key) -}}
      {{- include "ix.v1.common.lib.values.deviceList.containers" (dict "root" $root "containers" (get $root.Values $key)) -}}
    {{- end -}}
  {{- end -}}
  {{/* Go over all jobs */}}
  {{- range $name, $job := $root.Values.jobs -}}
    {{- if $job.enabled -}}
      {{- if and  $job.podSpec $job.podSpec.containers -}}
        {{- include "ix.v1.common.lib.values.deviceList.containers" (dict "root" $root "isJob" true "containers" ($job.podSpec.containers)) -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "ix.v1.common.lib.values.deviceList.containers" -}}
  {{- $containers := .containers -}}
  {{- $root := .root -}}
  {{- $isJob := .isJob -}}
  {{/* Go over the containers */}}
  {{- range $containerName, $container := $containers -}}
    {{/* If the container has deviceList */}}
    {{- if hasKey $container "deviceList" -}}

      {{/* Go over the devices */}}
      {{- range $index, $device := $container.deviceList -}}
        {{/* Generate the name */}}
        {{- $name := $containerName -}}
        {{- if $isJob -}}
          {{- $name = (printf "job-%s" $containerName) -}}
        {{- end -}}
        {{- $deviceName := (printf "device-%s-%s" $name (toString $index)) -}}

        {{- if $device.name -}}
          {{- $deviceName = (printf "%s-%s" $name (toString $device.name)) -}}
        {{- end -}}

        {{/* Add the name on the device item */}}
        {{- $_ := set $device "name" $deviceName -}}
        {{/* Note that "set" mutates the actual item and not a copy */}}

        {{/* Make sure a volumeMount list exists */}}
        {{- if not (hasKey $container "volumeMounts") -}}
          {{- $_ := set $container "volumeMounts" list -}}
        {{- end -}}

        {{/* Append a volumeMount item, so other templates
        take care of the mounting of the device */}}
        {{- $_ := set $container "volumeMounts" (mustAppend $container.volumeMounts $device) -}}

        {{/* Make sure a persistence dict exists */}}
        {{- if not (hasKey $root.Values "persistence") -}}
          {{- $_ := set $root.Values "persistence" dict -}}
        {{- end -}}

        {{/* Add a noMount flag so it won't get mounted in the main container */}}
        {{- $_ := set $device "noMount" true -}}
        {{- $_ := set $device "type" "hostPath" -}}
        {{/* Add the device on persistence,
        so other templates take care of the volume creation */}}
        {{- $_ := set $root.Values.persistence $deviceName $device -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
