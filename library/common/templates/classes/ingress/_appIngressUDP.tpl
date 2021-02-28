{{/*
This template serves as a blueprint for all appIngressTCP objects that are created
within the common library.
*/}}
{{- define "common.classes.appIngressUDP" -}}
{{- $values := .Values.appIngress -}}
{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.appIngress -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}
{{- $IngressName := include "common.names.fullname" . -}}
{{- if hasKey $values "nameSuffix" -}}
  {{- $IngressName = printf "%v-%v" $IngressName $values.nameSuffix -}}
{{ end -}}
{{- $svcName := $values.serviceName | default (include "common.names.fullname" .) -}}
{{- $svcPort := $values.servicePort | default $.Values.service.port.port -}}
apiVersion: traefik.containo.us/v1alpha1
kind: IngressRouteUDP
metadata:
  name: {{ $IngressName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
  {{- with $values.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  entryPoints:
    - {{ $values.entrypoint }}
  routes:
  - services:
    - name: {{ $svcName }}
      port: {{ $svcPort }}
      weight: 10
{{- end }}
