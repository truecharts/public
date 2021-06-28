{{/*
This template serves as a blueprint for all Ingress objects that are created
within the common library.
*/}}
{{- define "common.classes.ingress" -}}
  {{- $ingressName := include "common.names.fullname" . -}}
  {{- $values := .Values.ingress -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.ingress -}}
      {{- $values = . -}}
    {{- end -}}
  {{ end -}}

  {{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
    {{- $ingressName = printf "%v-%v" $ingressName $values.nameOverride -}}
  {{- end -}}

  {{- $primaryService := get .Values.service (include "common.service.primary" .) }}
  {{- $primaryPort := get $primaryService.ports (include "common.classes.service.ports.primary" (dict "values" $primaryService)) -}}
  {{- $name := include "common.names.name" . -}}
  {{- $isStable := include "common.capabilities.ingress.isStable" . }}

  {{- $middlewares := "" }}
  {{ range $index, $middleware := $values.middlewares }}
      {{- if $index }}
      {{ $middlewares = ( printf "%v, %v-%v@%v" $middlewares "traefik-middlewares" $middleware "kubernetescrd" ) }}
      {{- else }}
      {{ $middlewares = ( printf "%v-%v@%v" "traefik-middlewares" $middleware "kubernetescrd" ) }}
      {{- end }}
  {{end}}

---
apiVersion: {{ include "common.capabilities.ingress.apiVersion" . }}
kind: Ingress
metadata:
  name: {{ $ingressName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
  annotations:
    "traefik.ingress.kubernetes.io/router.middlewares": {{ $middlewares | quote }}
  {{- with $values.annotations }}
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- if and $isStable $values.ingressClassName }}
  ingressClassName: {{ $values.ingressClassName }}
  {{- end }}
  {{- if $values.tls }}
  tls:
    {{- range $index, $tlsValues :=  $values.tls }}
    - hosts:
        {{- range $tlsValues.hosts }}
        - {{ tpl . $ | quote }}
        {{- end }}
      {{- if $tlsValues.scaleCert }}
      secretName: {{ ( printf "%v-%v-%v-%v-%v" $ingressName "tls" $index "ixcert" $tlsValues.scaleCert ) }}
      {{- else if .secretName }}
      secretName: {{ tpl .secretName $ | quote}}
      {{- end }}
    {{- end }}
  {{- end }}
  rules:
  {{- range $values.hosts }}
    - host: {{ tpl .host $ | quote }}
      http:
        paths:
          {{- range .paths }}
          {{- $service := $name -}}
          {{- $port := $primaryPort.port -}}
          {{- if .service -}}
            {{- $service = default $name .service.name -}}
            {{- $port = default $primaryPort.port .service.port -}}
          {{- end }}
          - path: {{ tpl .path $ | quote }}
            {{- if $isStable }}
            pathType: {{ default "Prefix" .pathType }}
            {{- end }}
            backend:
              {{- if $isStable }}
              service:
                name: {{ $service }}
                port:
                  number: {{ $port }}
              {{- else }}
              serviceName: {{ $service }}
              servicePort: {{ $port }}
              {{- end }}
          {{- end }}
  {{- end }}
{{- end }}
