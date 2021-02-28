{{/*
This template serves as a blueprint for all appIngressTCP objects that are created
within the common library.
*/}}
{{- define "common.classes.appIngressTCP" -}}
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
kind: IngressRouteTCP
metadata:
  name: {{ $IngressName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
  annotations:
    {{- if or (eq $values.certType "letsencrypt-prod") (eq $values.certType "letsencrypt-staging") }}
    cert-manager.io/cluster-issuer:  {{ $values.certType }}
    {{- end }}
    {{- with $values.annotations }}
    {{- toYaml . | nindent 4 }}
    {{- end }}
spec:
  entryPoints:
    - {{ $values.entrypoint }}
  routes:
  - match: HostSNI(`*`)
    services:
    - name: {{ $svcName }}
      port: {{ $svcPort }}
      weight: 10
      terminationDelay: 400
  {{- if $values.certType }}
  tls:
  {{- if eq $values.certType "selfsigned" -}}{}{{ else }}
    domains:
      - main: {{ index  $values.hosts 0 }}
        sans:
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
    passthrough: false
  {{- end }}
{{- end }}
