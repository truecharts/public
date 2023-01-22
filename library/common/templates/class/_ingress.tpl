{{/*
This template serves as a blueprint for all Ingress objects that are created
within the common library.
*/}}
{{- define "tc.v1.common.class.ingress" -}}
  {{- $fullName := include "ix.v1.common.names.fullname" . -}}
  {{- $ingressName := $fullName -}}
  {{- $values := .Values.ingress -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.ingress -}}
      {{- $values = . -}}
    {{- end -}}
  {{- end -}}
  {{- $ingressLabels := $values.labels -}}
  {{- $ingressAnnotations := $values.annotations -}}

  {{- if and (hasKey $values "nameOverride") $values.nameOverride -}}
    {{- $ingressName = printf "%v-%v" $ingressName $values.nameOverride -}}
  {{- end -}}

  {{/* Get the name of the primary service, if any */}}
  {{- $primarySeriviceName := (include "ix.v1.common.lib.util.service.primary" (dict "services" .Values.service "root" .)) -}}
  {{/* Get service values of the primary service, if any */}}
  {{- $primaryService := get .Values.service $primarySeriviceName -}}
  {{- $autoLinkService := $primaryService -}}
  {{- $defaultServiceName := $fullName -}}

  {{- if and (hasKey $primaryService "nameOverride") $primaryService.nameOverride -}}
    {{- $defaultServiceName = printf "%v-%v" $defaultServiceName $primaryService.nameOverride -}}
  {{- end -}}
  {{- $defaultServicePort := get $primaryService.ports (include "ix.v1.common.lib.util.service.ports.primary" (dict "svcValues" $primaryService "svcName" $primarySeriviceName )) -}}

  {{- if and (hasKey $values "nameOverride") ( $values.nameOverride ) ( $values.autoLink ) -}}
    {{- $autoLinkService = get .Values.service $values.nameOverride -}}
    {{- $defaultServiceName = $ingressName -}}
    {{- $defaultServicePort = get $autoLinkService.ports $values.nameOverride -}}
  {{- end -}}

  {{- $mddwrNamespace := "default" -}}
  {{- if $values.ingressClassName -}}
    {{- $mddwrNamespace = ( printf "ix-%s" $values.ingressClassName ) -}}
  {{- end -}}

  {{- $fixedMiddlewares := "" -}}
  {{- if $values.enableFixedMiddlewares -}}
  {{- range $index, $fixedMiddleware := $values.fixedMiddlewares -}}
      {{- if $index -}}
        {{- $fixedMiddlewares = ( printf "%v, %v-%v@%v" $fixedMiddlewares $mddwrNamespace $fixedMiddleware "kubernetescrd" ) -}}
      {{- else -}}
        {{- $fixedMiddlewares = ( printf "%v-%v@%v" $mddwrNamespace $fixedMiddleware "kubernetescrd" ) -}}
      {{- end -}}
  {{- end -}}
  {{- end -}}

  {{- $middlewares := "" -}}
  {{- range $index, $middleware := $values.middlewares -}}
      {{- if $index -}}
        {{- $middlewares = ( printf "%v, %v-%v@%v" $middlewares $mddwrNamespace $middleware "kubernetescrd" ) -}}
      {{- else -}}
        {{- $middlewares = ( printf "%v-%v@%v" $mddwrNamespace $middleware "kubernetescrd" ) -}}
      {{- end -}}
  {{ end }}

  {{- if and ( $fixedMiddlewares ) ( $middlewares ) -}}
    {{- $middlewares = ( printf "%v, %v" $fixedMiddlewares $middlewares ) -}}
  {{- else if $fixedMiddlewares -}}
    {{- $middlewares = ( printf "%s" $fixedMiddlewares ) -}}
  {{- end }}
---
apiVersion: {{ include "tc.v1.common.capabilities.ingress.apiVersion" $ }}
kind: Ingress
metadata:
  name: {{ $ingressName }}
  {{- $labels := (mustMerge ($ingressLabels | default dict) (include "ix.v1.common.labels" $ | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $ "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($ingressAnnotations | default dict) (include "ix.v1.common.annotations" $ | fromYaml)) }}
  annotations:
  {{- with $values.certificateIssuer }}
    cert-manager.io/cluster-issuer: {{ tpl ( toYaml . ) $ }}
  {{- end }}
    "traefik.ingress.kubernetes.io/router.entrypoints": {{ $values.entrypoint | default "websecure" }}
    "traefik.ingress.kubernetes.io/router.middlewares": {{ $middlewares | quote }}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $ "annotations" $annotations) | trim) }}
    {{- . | nindent 4 }}
  {{- end }}
spec:
  {{- if $values.ingressClassName }}
  ingressClassName: {{ $values.ingressClassName }}
  {{- end -}}
  {{- if $values.certificateIssuer }}
  tls:
    {{- range $index, $hostsValues := $values.hosts }}
    - hosts:
      - {{ tpl $hostsValues.host $ | quote }}
      secretName: {{ ( printf "%v-%v-%v" $ingressName "tls" $index ) }}
    {{- end -}}
  {{- else if $values.tls }}
  tls:
    {{- range $index, $tlsValues :=  $values.tls }}
    - hosts:
        {{- range $tlsValues.hosts }}
        - {{ tpl . $ | quote }}
        {{- end -}}
      {{- if $tlsValues.certificateIssuer }}
      secretName: {{ ( printf "%v-%v-%v" $ingressName "tls" $index ) }}
      {{- else if $tlsValues.scaleCert }}
      secretName: {{ ( printf "%v-%v-%v-%v-%v-%v" $ingressName "tls" $index "ixcert" $tlsValues.scaleCert $.Release.Revision ) }}
      {{- else if .secretName }}
      secretName: {{ tpl .secretName $ | quote}}
      {{- end -}}
    {{- end -}}
  {{- end }}
  rules:
  {{- range $values.hosts }}
    - host: {{ tpl .host $ | quote }}
      http:
        paths:
          {{- range .paths -}}
            {{- $service := $defaultServiceName -}}
            {{- $port := $defaultServicePort.port -}}
            {{- if .service -}}
              {{- $service = default $service .service.name -}}
              {{- $port = default $port .service.port -}}
            {{- end }}
          - path: {{ tpl .path $ | quote }}
            pathType: {{ default "Prefix" .pathType }}
            backend:
              service:
                name: {{ $service }}
                port:
                  number: {{ $port }}
          {{- end -}}
  {{- end -}}


{{- if and $values.tls ( not $values.certificateIssuer ) -}}
{{- range $index, $tlsValues :=  $values.tls -}}

{{- if $tlsValues.certificateIssuer }}
---
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: {{ ( printf "%v-%v-%v" $ingressName "tls" $index ) }}
spec:
  secretName: {{ ( printf "%v-%v-%v" $ingressName "tls" $index ) }}
  dnsNames:
  {{- range $tlsValues.hosts }}
  - {{ tpl . $ | quote }}
  {{- end }}
  privateKey:
    algorithm: ECDSA
    size: 256
  issuerRef:
    name: {{ tpl $tlsValues.certificateIssuer $ | quote }}
    kind: ClusterIssuer
    group: cert-manager.io
{{- end -}}
{{- end -}}
{{- end -}}


{{- end -}}
