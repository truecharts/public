{{/* Ingress Homepage Integration */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.ingress.integration.homepage" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
objectData:
  rootCtx: The root context of the chart.
  objectData: The ingress object.
*/}}

{{- define "tc.v1.common.lib.ingress.integration.homepage" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

{{- if and $objectData.integration  $objectData.integration.homepage $objectData.integration.homepage.enabled -}}
gethomepage.dev/enabled: "true"
gethomepage.dev/name: {{ $objectData.integration.homepage.name | default ( camelcase $rootCtx.Chart.Name ) }}
gethomepage.dev/description: {{ $objectData.integration.homepage.description | default $rootCtx.Chart.Description }}
gethomepage.dev/group: {{ $objectData.integration.homepage.group | default "default" }}
gethomepage.dev/icon: {{ $objectData.integration.homepage.icon | default $rootCtx.Chart.Icon }}
{{- if $objectData.integration.homepage.podSelector -}}
gethomepage.dev/pod-selector: {{ . }}
{{- else -}}
gethomepage.dev/pod-selector: ""
{{- end -}}
{{- with $objectData.integration.homepage.weight -}}
gethomepage.dev/weight: {{ . }}
{{- end -}}
gethomepage.dev/widget.type: {{ $objectData.integration.homepage.widget.type | default $rootCtx.Chart.Name }}
{{- with (index $objectData.hosts 0) -}}
gethomepage.dev/widget.url: {{ $objectData.integration.homepage.widget.url | default (printf "%v%v" .host ( .path | default "/")) }}
{{- end -}}
{{- range $objectData.integration.homepage.widget.custom -}}
gethomepage.dev/widget.{{ .name }}: {{ .value }}
{{- end -}}
{{- end -}}
{{- end -}}
