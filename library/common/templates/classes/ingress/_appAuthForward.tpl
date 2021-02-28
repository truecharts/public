{{/*
Renders the additioanl authForward objects from appAuthForward
*/}}
{{- define "common.classes.appAuthForward" -}}
{{- /* Generate TrueNAS SCALE app services as required v1 */ -}}
{{- $values := .Values.appIngress -}}
{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.appIngress -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}
{{- $authForwardName := include "common.names.fullname" . -}}
{{- if hasKey $values "nameSuffix" -}}
  {{- $authForwardName = printf "%v-%v" $authForwardName $values.nameSuffix -}}
{{ end -}}
apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: {{ $authForwardName }}
spec:
  forwardAuth:
    address: {{ $values.authForwardURL }}
  tls:
    insecureSkipVerify: true
rustForwardHeader: true
  authResponseHeaders:
     - Remote-User
     - Remote-Groups
     - Remote-Name
     - Remote-Email
{{- end }}
