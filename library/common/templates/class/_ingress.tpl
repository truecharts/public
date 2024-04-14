{{/* Ingress Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.ingress" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData: The object data to be used to render the Ingress.
*/}}

{{- define "tc.v1.common.class.ingress" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $svcData := (include "tc.v1.common.lib.ingress.targetSelector" (dict "rootCtx" $rootCtx "objectData" $objectData) | fromYaml) -}}
  {{- $_ := set $objectData "selectedService" $svcData -}}

  {{- if not (hasKey $objectData "integrations") -}}
    {{- $_ := set $objectData "integrations" dict -}}
  {{- end -}}
  {{- if not (hasKey $objectData "annotations") -}}
    {{- $_ := set $objectData "annotations" dict -}}
  {{- end -}}

  {{- $ingressClassName := "" -}}
  {{- if $objectData.ingressClassName -}}
    {{- $ingressClassName = (tpl $objectData.ingressClassName $rootCtx) -}}
  {{- end -}}

  {{/* When Stop All is set, force ingressClass "stopped"
  to yeet ingress from the ingresscontroller */}}
  {{- if (include "tc.v1.common.lib.util.stopAll" $rootCtx) -}}
    {{- $ingressClassName = "tc-stopped" -}}
  {{- end -}}

  {{- include "tc.v1.common.lib.ingress.integration.certManager" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
  {{- include "tc.v1.common.lib.ingress.integration.traefik" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
  {{- if ne $ingressClassName "tc-stopped" -}}{{/* If is stopped, dont render homepage annotations */}}
    {{- include "tc.v1.common.lib.ingress.integration.homepage" (dict "rootCtx" $rootCtx "objectData" $objectData) -}}
  {{- end }}
---
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ $objectData.name }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Ingress") }}
  {{- $labels := (mustMerge ($objectData.labels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end }}
  annotations:
    checksum/secrets: {{ toJson $rootCtx.Values.secret | sha256sum }}
    checksum/services: {{ toJson $rootCtx.Values.service | sha256sum }}
  {{- $annotations := (mustMerge ($objectData.annotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
    {{- . | nindent 4 }}
  {{- end }}
spec:
  ingressClassName: {{ $ingressClassName | default nil }}
  rules:
    {{- range $h := $objectData.hosts }}
    - host: {{ (tpl $h.host $rootCtx) | quote }}
      http:
        paths:
          {{- if not $h.paths -}} {{/* If no paths given, default to "/" */}}
            {{- $_ := set $h "paths" (list (dict "path" "/")) -}}
          {{- end -}}
          {{- range $p := $h.paths -}}
            {{- $newSvcData := (include "tc.v1.common.lib.ingress.backend.data" (dict
                "rootCtx" $rootCtx "svcData" $svcData "override" $p.overrideService)) | fromYaml
            }}
          - path: {{ tpl ($p.path | default "/") $rootCtx }}
            pathType: {{ tpl ($p.pathType | default "Prefix") $rootCtx }}
            backend:
              service:
                name: {{ $newSvcData.name }}
                port:
                  number: {{ $newSvcData.port }}
          {{- end -}}
    {{- end -}}
  {{/* If a certificateIssuer is defined in the whole ingress, use that */}}
  {{- if and $objectData.integrations.certManager $objectData.integrations.certManager.enabled }}
  tls:
    {{- range $idx, $h := $objectData.hosts }}
    - secretName: {{ printf "%s-tls-%d" $objectData.name ($idx | int) }}
      hosts:
        - {{ (tpl $h.host $rootCtx) | quote }}
    {{- end -}}
  {{/* else if a tls section is defined use the configuration from there */}}
  {{- else if $objectData.tls }}
  tls:
    {{- range $idx, $t := $objectData.tls -}}
      {{- $secretName := "" -}}
      {{- if $t.secretName -}}
        {{- $secretName = tpl $t.secretName $rootCtx -}}
      {{- else if $t.certificateIssuer -}}
        {{- $secretName = printf "%s-tls-%d" $objectData.name ($idx | int) -}}
      {{- else if $t.clusterCertificate -}}
        {{- $secretName = printf "certificate-issuer-%s" (tpl $t.clusterCertificate $rootCtx) -}}
      {{- end }}
    - secretName: {{ $secretName }}
      hosts:
        {{- range $h := $t.hosts }}
        - {{ (tpl $h $rootCtx) | quote }}
        {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
