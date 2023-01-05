{{- define "ix.v1.common.lib.values.deviceList" -}}
  {{- $root := . -}}

  {{/* Go over the device list on the main container */}}
  {{- range $index, $device := $root.Values.deviceList -}}
    {{/* Generate the name */}}
    {{- $name := (printf "device-%s" (toString $index)) -}}

    {{- if $device.name -}}
      {{- $name = $device.name -}}
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
  {{- range $key := (list "initContainers" "installContainers" "upgradeContainers" "additionalContainers") -}}
    {{/* If they have containers defined... */}}
    {{- if (get $root.Values $key) -}}

      {{/* Go over the containers */}}
      {{- range $containerName, $container := (get $root.Values $key) -}}
        {{/* If the container has deviceList */}}
        {{- if hasKey $container "deviceList" -}}

          {{/* Go over the devices */}}
          {{- range $index, $device := $container.deviceList -}}
            {{/* Generate the name */}}
            {{- $deviceName := (printf "device-%s-%s" $containerName (toString $index)) -}}

            {{- if $device.name -}}
              {{- $deviceName = (printf "%s-%s" $containerName (toString $device.name)) -}}
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
            {{/* Add the device on persistence,
            so other templates take care of the volume creation */}}
            {{- $_ := set $root.Values.persistence $deviceName $device -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
