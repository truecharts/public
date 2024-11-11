{{/* Returns ports list */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.container.ports" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the container.
*/}}
{{- define "tc.v1.common.lib.container.ports" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $portsByName := dict -}}

  {{- range $serviceName, $serviceValues := $rootCtx.Values.service -}}
    {{- $podSelected := false -}}
    {{/* If service is enabled... */}}
    {{- if $serviceValues.enabled -}}

      {{/* If there is a selector */}}
      {{- if $serviceValues.targetSelector -}}

        {{/* And pod is selected */}}
        {{- if eq $serviceValues.targetSelector $objectData.podShortName -}}
          {{- $podSelected = true -}}
        {{- end -}}

      {{- else -}}
        {{/* If no selector is defined but pod is primary */}}
        {{- if $objectData.podPrimary -}}
          {{- $podSelected = true -}}
        {{- end -}}

      {{- end -}}
    {{- end -}}

    {{- if $podSelected -}}
      {{- range $portName, $portValues := $serviceValues.ports -}}
        {{- $containerSelected := false -}}

        {{/* If service is enabled... */}}
        {{- if $portValues.enabled -}}
          {{/* If there is a selector */}}
          {{- if $portValues.targetSelector -}}

            {{/* And container is selected */}}
            {{- if eq $portValues.targetSelector $objectData.shortName -}}
              {{- $containerSelected = true -}}
            {{- end -}}

          {{- else -}}
            {{/* If no selector is defined but container is primary */}}
            {{- if $objectData.primary -}}
              {{- $containerSelected = true -}}
            {{- end -}}

          {{- end -}}
        {{- end -}}

        {{/* If the container is selected render port */}}
        {{- if $containerSelected -}}
          {{- $containerPort := $portValues.targetPort | default $portValues.port -}}
          {{- if kindIs "string" $containerPort -}}
            {{- $containerPort = (tpl $containerPort $rootCtx) -}}
          {{- end -}}

          {{- $tcpProtocols := (list "tcp" "http" "https") -}}
          {{- $protocol := tpl ($portValues.protocol | default $rootCtx.Values.global.fallbackDefaults.serviceProtocol) $rootCtx -}}
          {{- if mustHas $protocol $tcpProtocols -}}
            {{- $protocol = "tcp" -}}
          {{- end }}
- name: {{ $portName }}
  containerPort: {{ $containerPort }}
  protocol: {{ $protocol | upper }}
          {{- with $portValues.hostPort }}
  hostPort: {{ . }}
          {{- else }}
  hostPort: null
          {{- end -}}
        {{- $_ := set $portsByName $portName (dict "containerPort" (toString $containerPort) "serviceName" $serviceName) -}}
        {{- end -}}

      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- include "tc.v1.common.lib.container.ports.detectSortingIssues" (dict "portsByName" $portsByName "rootCtx" $rootCtx) -}}

{{- end -}}
{{/* Turning hostNetwork on, it creates hostPort automatically and turning it back off does not remove them. Setting hostPort explicitly to null will remove them.
    There are still cases that hostPort is not removed, for example, if you have a TCP and UDP port with the same number. Only the TCPs hostPort will be removed.
    Also note that setting hostPort to null always, it will NOT affect hostNetwork, as it will still create the hostPorts.
    It only helps to remove them when hostNetwork is turned off.
*/}}


{{- define "tc.v1.common.lib.container.ports.detectSortingIssues" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $portsByName := .portsByName -}}

  {{- $portCounts := dict -}}
  {{- range $name, $portValues := $portsByName -}}
    {{- $count := 1 -}}
    {{- $port := (get $portValues "containerPort") -}}
    {{- if hasKey $portCounts $port -}}
      {{- $count = add1 (get $portCounts $port) -}}
    {{- end -}}
    {{- $_ := set $portCounts $port $count -}}
  {{- end -}}

  {{- $sorted := keys $portsByName | sortAlpha -}}
  {{- range $idx, $name := $sorted -}}
    {{- $portValues := (get $portsByName $name) -}}
    {{- $port := $portValues.containerPort -}}
    {{- if eq (get $portCounts $port) 1 -}}
      {{- continue -}}
    {{- end -}}

    {{- if lt $idx (sub (len $sorted) 1) -}}
      {{- $nextPort := (get $portsByName (index $sorted (add1 $idx))).containerPort -}}
      {{- if ne $port $nextPort -}}
        {{- $portNamesUsingNum := list -}}
        {{- range $name, $p := $portsByName -}}
          {{- if eq $p.containerPort $port -}}
            {{- $portNamesUsingNum = mustAppend $portNamesUsingNum $name -}}
          {{- end -}}
        {{- end -}}
        {{- fail (printf "Port number [%s] is used by multiple ports [%s] in the service [%s] but their names are not adjacent when sorted alphabetically (Other ports in this container sorted: [%s]). This can cause issues with Kubernetes port updates." $port (join ", " $portNamesUsingNum) $portValues.serviceName (join ", " (keys $portsByName | sortAlpha))) -}}
      {{- end -}}
      {{- $_ := set $portCounts $port 1 -}}
    {{- end -}}

  {{- end -}}
{{- end -}}
