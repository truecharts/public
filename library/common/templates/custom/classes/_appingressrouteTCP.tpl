{{/*
This template serves as a blueprint for all appIngressTCP objects that are created 
within the common library.
*/}}
{{- define "custom.classes.appIngressTCP" -}}
{{- $appingressTCPName := include "common.names.fullname" . -}}
{{- $values := .Values.appIngress -}}
{{- if hasKey . "ObjectValues" -}}
  {{- with .ObjectValues.appIngress -}}
    {{- $values = . -}}
  {{- end -}}
{{ end -}}
{{- if hasKey $values "nameSuffix" -}}
  {{- $appingressTCPName = printf "%v-%v" $appingressTCPName $values.nameSuffix -}}
{{ end -}}
{{- $svcName := $values.serviceName | default (include "common.names.fullname" .) -}}
{{- $svcPort := $values.servicePort | default $.Values.service.port.port -}}
apiVersion: {{ include "common.capabilities.ingress.apiVersion" . }}
kind: IngressTCP
metadata:
  name: {{ $appingressTCPName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
  annotations:
    cert-manager.io/cluster-issuer: {{- if or (eq $values.certType "letsencrypt-prod") (eq $values.certType "letsencrypt-staging") }} {{ $values.certType }} {{ end }}
    traefik.ingress.kubernetes.io/router.entrypoints: {{ $values.entrypoint }}
    traefik.ingress.kubernetes.io/router.middlewares: traefik-middlewares-chain-public@kubernetescrd
  {{- with $values.annotations }}
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- if eq (include "common.capabilities.ingress.apiVersion" $) "networking.k8s.io/v1" }}
  {{- if $values.appingressTCPClassName }}
  appingressTCPClassName: {{ $values.appingressTCPClassName }}
  {{- end }}
  {{- end }}
  tls:
  {{- if eq $values.certType "selfsigned" -}}{{ else if eq $values.certType "existingcert" }}
    secretName: {{ $values.existingcert }}
  {{ else if eq $values.certType "wildcard" }}
    secretName: wilddcardcert
  {{ else }}
    - hosts:
        {{- range $values.hosts }}
        - {{ .host | quote }}
        {{- end }}
      secretName: {{ $appingressTCPName }}-tls-secret
  {{ end }}
  rules:
  {{- range $values.hosts }}
    - host: {{ .host | quote }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
            {{- if eq (include "common.capabilities.ingress.apiVersion" $) "networking.k8s.io/v1" }}
            pathType: Prefix
            {{- end }}
            backend:
            {{- if eq (include "common.capabilities.ingress.apiVersion" $) "networking.k8s.io/v1" }}
              service:
                name: {{ $svcName }}
                port:
                  number: {{ $svcPort }}
            {{- else }}
              serviceName: {{ $svcName }}
              servicePort: {{ $svcPort }}
            {{- end }}
          {{- end }}
  {{- end }}
{{- end }}
