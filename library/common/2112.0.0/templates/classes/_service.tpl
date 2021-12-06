{{/*
This template serves as a blueprint for all Service objects that are created
within the common library.
*/}}
{{- define "common.classes.service" -}}
{{- $values := .commonService -}}
{{- $serviceName := include "common.names.fullname" . -}}
{{- if hasKey $values "nameSuffix" -}}
  {{- $serviceName = (printf "%v-%v" $serviceName $values.nameSuffix) -}}
{{ end -}}
{{- $svcType := $values.type | default "" -}}
apiVersion: v1
kind: Service
metadata:
  name: {{ $serviceName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
  {{- if $values.labels }}
    {{ toYaml $values.labels | nindent 4 }}
  {{- end }}
  {{- if $values.annotations }}
    {{- with $values.annotations }}
  annotations:
    {{ toYaml . | nindent 4 }}
    {{- end }}
   {{- end }}
spec:
  {{- if (or (eq $svcType "ClusterIP") (empty $svcType)) }}
  type: ClusterIP
  {{- if $values.clusterIP }}
  clusterIP: {{ $values.clusterIP }}
  {{end}}
  {{- else if eq $svcType "NodePort" }}
  type: {{ $svcType }}
  {{- else }}
  {{- fail "Only ClusterIP and NodePort services are supported in common chart" }}
  {{- end }}
  {{- include "common.classes.service.ports" (dict "svcType" $svcType "values" $values ) | trim | nindent 2 }}
  selector:
    {{- include "common.labels.selectorLabels" . | nindent 4 }}
{{- end }}
