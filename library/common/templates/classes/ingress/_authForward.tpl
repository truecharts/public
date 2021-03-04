{{/*
Renders the additional authForward objects from ingress
*/}}
{{- define "common.classes.ingress.authForward" -}}
{{- $authForwardName := include "common.names.fullname" . -}}
{{- $values := .Values -}}
{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.ingress -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}
{{- if hasKey $values "nameSuffix" -}}
  {{- $authForwardName = printf "%v-%v" $authForwardName $values.nameSuffix -}}
{{ end -}}
apiVersion: traefik.containo.us/v1alpha1
kind: Middleware
metadata:
  name: {{ $authForwardName }}-auth-forward
spec:
  forwardAuth:
    address: {{ $values.authForwardURL | quote }}
    tls:
      insecureSkipVerify: true
    trustForwardHeader: true
    authResponseHeaders:
      - Remote-User
      - Remote-Groups
      - Remote-Name
      - Remote-Email
{{- end }}
