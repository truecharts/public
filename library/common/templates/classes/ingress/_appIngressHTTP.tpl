{{/*
This template serves as a blueprint for all appIngress objects that are created
within the common library.
*/}}
{{- define "common.classes.appIngressHTTP" -}}
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
apiVersion: {{ include "common.capabilities.ingress.apiVersion" . }}
kind: Ingress
metadata:
  name: {{ $IngressName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
  annotations:
    {{- if or (eq $values.certType "letsencrypt-prod") (eq $values.certType "letsencrypt-staging") }}
    cert-manager.io/cluster-issuer:  {{ $values.certType }}
    {{- end }}
    traefik.ingress.kubernetes.io/router.entrypoints: {{ $values.entrypoint }}
    traefik.ingress.kubernetes.io/router.middlewares: traefik-middlewares-chain-public@kubernetescrd
    {{- if $values.authForwardURL }}
    traefik.ingress.kubernetes.io/router.middlewares: {{ $IngressName }}
    {{- end }}
  {{- with $values.annotations }}
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- if eq (include "common.capabilities.ingress.apiVersion" $) "networking.k8s.io/v1" }}
  {{- if $values.IngressClassName }}
  IngressClassName: {{ $values.appIngressHTTPClassName }}
  {{- end }}
  {{- end }}
  {{- if $values.certType }}
  tls:
  {{- if eq $values.certType "selfsigned" -}}{}{{ else }}
    - hosts:
        {{- range $values.hosts }}
        - {{ .host | quote }}
        {{- end }}
      {{- if eq $values.certType "selfsigned" -}}
	  secretName:
      {{ else if eq $values.certType "existingcert" }}
      secretName: {{ $values.existingcert }}
      {{ else if eq $values.certType "ixcert" }}
      secretName: {{ $IngressName }}
      {{ else if eq $values.certType "wildcard" }}
      secretName: wildcardcert
      {{ else }}
      secretName: {{ $IngressName }}-tls-secret
      {{ end }}
  {{ end }}
  {{- end }}
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
