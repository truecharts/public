{{/* Define the ldap container */}}
{{- define "authentik.ldap.container" -}}
enabled: true
primary: false
imageSelector: ldapImage
securityContext:
  readOnlyRootFilesystem: true
  runAsNonRoot: true
envFrom:
  - secretRef:
      name: '{{ include "tc.v1.common.lib.chart.names.fullname" . }}-ldap-secret'
  - configMapRef:
      name: '{{ include "tc.v1.common.lib.chart.names.fullname" . }}-ldap-config'
ports:
  - containerPort: {{ .Values.service.ldapldaps.ports.ldapldaps.targetPort }}
    name: ldapldaps
  - containerPort: {{ .Values.service.ldapldap.ports.ldapldap.targetPort }}
    name: ldapldap
{{- if .Values.metrics.enabled }}
  - containerPort: {{ .Values.service.ldapmetrics.ports.ldapmetrics.targetPort }}
    name: ldapmetrics
{{- end }}
probes:
  readiness:
    enabled: true
    type: {{ .Values.service.ldapmetrics.ports.ldapmetrics.protocol }}
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.ldapmetrics.ports.ldapmetrics.targetPort }}
  liveness:
    enabled: true
    type: {{ .Values.service.ldapmetrics.ports.ldapmetrics.protocol }}
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.ldapmetrics.ports.ldapmetrics.targetPort }}
  startup:
    enabled: true
    type: {{ .Values.service.ldapmetrics.ports.ldapmetrics.protocol }}
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.ldapmetrics.ports.ldapmetrics.targetPort }}
{{- end -}}
