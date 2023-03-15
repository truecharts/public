{{/* Define the ldap container */}}
{{- define "authentik.ldap" -}}
enabled: true
imageSelector: ldapImage
envFrom:
  - secretRef:
      name: 'ldap-secret'
  - configMapRef:
      name: 'ldap-config'
probes:
  readiness:
    enabled: true
    type: http
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.ldapmetrics.ports.ldapmetrics.targetPort }}
  liveness:
    enabled: true
    type: http
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.ldapmetrics.ports.ldapmetrics.targetPort }}
  startup:
    enabled: true
    type: http
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.ldapmetrics.ports.ldapmetrics.targetPort }}
{{- end -}}
