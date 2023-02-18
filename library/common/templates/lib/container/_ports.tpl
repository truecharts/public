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
            {{/* If no selector is defined but contaienr is primary */}}
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
          {{- $protocol := tpl ($portValues.protocol | default $rootCtx.Values.fallbackDefaults.serviceProtocol) $rootCtx -}}
          {{- if mustHas $protocol $tcpProtocols -}}
            {{- $protocol = "tcp" -}}
          {{- end }}
- name: {{ $portName }}
  containerPort: {{ $containerPort }}
  protocol: {{ $protocol | upper }}
        {{- with $portValues.hostPort }}
  hostPort: {{ . }}
          {{- end -}}
        {{- end -}}

      {{- end -}}
    {{- end -}}
  {{- end -}}

{{- end -}}
