{{/*
This template serves as a blueprint for all Ingress objects that are created
within the common library.
*/}}
{{- define "common.classes.ingressRouteUDP" -}}
{{- $ingressName := include "common.names.fullname" . -}}
{{- $values := index .Values.ingress (keys .Values.ingressRouteUDP | first) -}}

{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.ingress -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}

{{- if hasKey $values "nameSuffix" -}}
  {{- $ingressName = printf "%v-%v" $ingressName $values.nameSuffix -}}
{{ end -}}

{{- $svc := index .Values.services (keys .Values.services | first) -}}
{{- $svcName := $values.serviceName | default (include "common.names.fullname" .) -}}
{{- $svcPort := $values.servicePort | default $svc.port.port -}}

apiVersion: traefik.containo.us/v1alpha1
kind: IngressRouteUDP
metadata:
  name: {{ $ingressName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
  {{- with $values.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  entrypoints:
  {{- range $values.entrypoints }}
    - {{ . | quote }}
  {{- end}}
  {{- range .entrypointsTpl }}
    - {{ tpl . $ | quote }}
  {{- end}}

  routes:
  {{- range $values.routes.routes }}
    - services:
        {{- range .routes }}
        - name: {{ .serviceName | default $svcName }}
          port: {{ .servicePort | default $svcPort }}
          weight: {{ .weight | default 10 }}
        {{- end}}
  {{- end}}
{{- end }}
