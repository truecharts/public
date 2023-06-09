{{/*
This template serves as a blueprint for all Ingress objects that are created
within the common library.
*/}}
{{- define "tc.v1.common.class.ingress" -}}
  {{- $fullName := include "tc.v1.common.lib.chart.names.fullname" . -}}
  {{- $ingressName := $fullName -}}
  {{- $values := .Values.ingress -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.ingress -}}
      {{- $values = . -}}
    {{- end -}}
  {{- end -}}
  {{- $ingressLabels := $values.labels -}}
  {{- $ingressAnnotations := $values.annotations -}}

  {{- $ingressName = $values.name -}}

  {{/* Get the name of the primary service, if any */}}
  {{- $primaryServiceName := (include "tc.v1.common.lib.util.service.primary" (dict "services" .Values.service "root" .)) -}}
  {{/* Get service values of the primary service, if any */}}
  {{- $primaryService := get .Values.service $primaryServiceName -}}
  {{- $defaultServiceName := $fullName -}}

  {{- if and (hasKey $primaryService "nameOverride") $primaryService.nameOverride -}}
    {{- $defaultServiceName = printf "%v-%v" $defaultServiceName $primaryService.nameOverride -}}
  {{- end -}}
  {{- $defaultServicePort := get $primaryService.ports (include "tc.v1.common.lib.util.service.ports.primary" (dict "svcValues" $primaryService "svcName" $primaryServiceName )) -}}

  {{- $mddwrNamespace := "tc-system" -}}
  {{- if $.Values.operator.traefik -}}
    {{- if $.Values.operator.traefik.namespace -}}
      {{- $mddwrNamespace = $.Values.operator.traefik.namespace -}}
    {{- end -}}
  {{- end -}}

  {{- if $values.ingressClassName -}}
    
    {{- if $.Values.global.ixChartContext -}}
      {{- $mddwrNamespace = (printf "ix-%s" $values.ingressClassName) -}}
    {{- else -}}
      {{- $mddwrNamespace = $values.ingressClassName -}}
    {{- end -}}
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
  {{- $labels := (mustMerge ($ingressLabels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $ | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($ingressAnnotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $ | fromYaml)) }}
  annotations:
  {{- with $values.certificateIssuer }}
    cert-manager.io/cluster-issuer: {{ tpl ( toYaml . ) $ }}
    cert-manager.io/private-key-rotation-policy: Always
  {{- end }}
    "traefik.ingress.kubernetes.io/router.entrypoints": {{ $values.entrypoint | default "websecure" }}
    "traefik.ingress.kubernetes.io/router.middlewares": {{ $middlewares | quote }}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "annotations" $annotations) | trim) }}
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
    {{- $tlsName := ( printf "%v-%v" "tls" $index ) }}
    - hosts:
        {{- range $tlsValues.hosts }}
        - {{ tpl . $ | quote }}
        {{- end -}}
      {{- if $tlsValues.certificateIssuer }}
      secretName: {{ printf "%v-%v" $ingressName $tlsName }}
      {{- else if  and ($tlsValues.scaleCert) ($.Values.global.ixChartContext) -}}
        {{- $cert := dict }}
        {{- $_ := set $cert "id" $tlsValues.scaleCert }}
        {{- $_ := set $cert "nameOverride" $tlsName }}
      secretName: {{ printf "%s-tls-%v" (include "tc.v1.common.lib.chart.names.fullname" $) $index }}
      {{- else if .secretName }}
      secretName: {{ tpl .secretName $ | quote }}
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


{{- end -}}
