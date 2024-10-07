{{- define "common.classes.externalService" -}}
{{- $serviceName := include "common.names.fullname" . -}}
{{- $values := .Values -}}
{{- $svcPort := 80 }}
{{- $ingressService := $.Values }}
{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.ingress -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}

{{- if hasKey $values "nameSuffix" -}}
  {{- $serviceName = printf "%v-%v" $serviceName $values.nameSuffix -}}
{{ end -}}

{{- $svcName := $values.serviceName | default $serviceName -}}

{{- if $values.servicePort }}
  {{- $svcPort = $values.servicePort -}}
{{- end }}

apiVersion: v1
kind: Service
metadata:
  name: {{ $svcName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
  annotations:
    {{- if eq ( $values.serviceType | default "" ) "HTTPS" }}
    traefik.ingress.kubernetes.io/service.serversscheme: https
    {{- end }}
    {{- with $values.annotations }}
      {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  ports:
{{- if eq $values.type "UDP"}}
    - protocol: UDP
      port: {{ $values.servicePort }}
      targetPort: {{ $values.servicePort }}
{{- else }}
    - protocol: TCP
      port: {{ $values.servicePort }}
      targetPort: {{ $values.servicePort }}
{{- end }}
---
apiVersion: v1
kind: Endpoints
metadata:
  name: {{ $svcName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
  annotations:
    {{- with $values.annotations }}
      {{- toYaml . | nindent 4 }}
    {{- end }}
subsets:
  - addresses:
      - ip: {{ $values.serviceTarget }}
    ports:
      - port: {{ $values.servicePort }}

{{- end }}
