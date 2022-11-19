{{- define "ix.v1.common.class.serivce.endpoints" -}}
  {{- $root := .root -}}
  {{- $svcName := .svcName -}}
  {{- $svcValues := .svc }}

---
apiVersion: {{ include "ix.v1.common.capabilities.endpoints.apiVersion" $root }}
kind: Endpoints
metadata:
  name: {{ $svcName }}
  {{- $labels := (mustMerge ($svcValues.labels | default dict) (include "ix.v1.common.labels" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $root "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end }}
  {{- $annotations := (mustMerge ($svcValues.annotations | default dict) (include "ix.v1.common.annotations" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $root "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
  {{- with $svcValues.externalIP }}
subsets:
  - addresses:
      - {{ tpl . $root }}
  {{- else -}}
    {{- fail "Service type is set to ExternalIP, but no externalIP is defined." -}}
  {{- end }}
    ports:
    {{- range $name, $port := $svcValues.ports }}
      {{- if $port.enabled }}
      - port: {{ $port.port }}
        name: {{ $name }}
      {{- end }}
    {{- end }}
{{- end -}}
