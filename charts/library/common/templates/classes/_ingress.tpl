{{/*
This template serves as a blueprint for all Ingress objects that are created
within the common library.
*/}}
{{- define "common.classes.ingress" -}}
{{- $ingressName := include "common.names.fullname" . -}}
{{- $values := index .Values.ingress (keys .Values.ingress | first) -}}

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

apiVersion: {{ include "common.capabilities.ingress.apiVersion" . }}
kind: Ingress
metadata:
  name: {{ $ingressName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
  {{- with $values.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- if eq (include "common.capabilities.ingress.apiVersion" $) "networking.k8s.io/v1" }}
  {{- if $values.ingressClassName }}
  ingressClassName: {{ $values.ingressClassName }}
  {{- end }}
  {{- end }}
  {{- if $values.tls }}
  tls:
    {{- range $index, $tlsValues :=  $values.tls }}
    - hosts:
        {{- range $tlsValues.hosts }}
        - {{ . | quote }}
        {{- end }}
        {{- range $tlsValues.hostsTpl }}
        - {{ tpl . $ | quote }}
        {{- end }}
      {{- if or $tlsValues.secretNameTpl $tlsValues.secretName $tlsValues.scaleCert }}
      {{- if $tlsValues.scaleCert }}
      secretName: {{ ( printf "%v-%v-%v-%v-%v" $ingressName "tls" $index "ixcert" $tlsValues.scaleCert ) }}
      {{- else if $tlsValues.secretNameTpl }}
      secretName: {{ tpl $tlsValues.secretNameTpl $ | quote}}
      {{- else }}
      secretName: {{ $tlsValues.secretName }}
      {{- end }}
      {{- end }}
    {{- end }}
  {{- end }}
  rules:
  {{- range $values.hosts }}
  {{- if .hostTpl }}
    - host: {{ tpl .hostTpl $ | quote }}
  {{- else }}
    - host: {{ .host | quote }}
  {{- end }}
      http:
        paths:
          {{- range .paths }}
          {{- if .pathTpl }}
          - path: {{ tpl .pathTpl $ | quote }}
          {{- else }}
          - path: {{ .path | quote }}
          {{- end }}
            {{- if eq (include "common.capabilities.ingress.apiVersion" $) "networking.k8s.io/v1" }}
            pathType: {{ default "Prefix" .pathType }}
            {{- end }}
            backend:
            {{- if eq (include "common.capabilities.ingress.apiVersion" $) "networking.k8s.io/v1" }}
              service:
                name: {{ .serviceName | default $svcName }}
                port:
                  number: {{ .servicePort | default $svcPort }}
            {{- else }}
              serviceName: {{ .serviceName | default $svcName }}
              servicePort: {{ .servicePort | default $svcPort }}
            {{- end }}
          {{- end }}
  {{- end }}
{{- end }}
