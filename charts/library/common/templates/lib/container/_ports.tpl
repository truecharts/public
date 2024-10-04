{{/* Returns ports list */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.container.ports" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the container.
*/}}
{{- define "tc.v1.common.lib.container.ports" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

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
        {{- end -}}

      {{- end -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
{{/* Turning hostNetwork on, it creates hostPort automatically and turning it back off does not remove them. Setting hostPort explicitly to null will remove them.
    There are still cases that hostPort is not removed, for example, if you have a TCP and UDP port with the same number. Only the TCPs hostPort will be removed.
    Also note that setting hostPort to null always, it will NOT affect hostNetwork, as it will still create the hostPorts.
    It only helps to remove them when hostNetwork is turned off.
*/}}
