{{/* Define the ldap container */}}
{{- define "authentik.ldap" -}}
enabled: true
imageSelector: ldapImage
imagePullPolicy: {{ .Values.ldapImage.pullPolicy }}
envFrom:
  - secretRef:
      name: 'ldap-secret'
  - configMapRef:
      name: 'ldap-config'
probes:
  readiness:

    path: /outpost.goauthentik.io/ping
      port: {{ .Values.service.ldapmetrics.ports.ldapmetrics.targetPort }}




  liveness:

    path: /outpost.goauthentik.io/ping
      port: {{ .Values.service.ldapmetrics.ports.ldapmetrics.targetPort }}




  startup:

    path: /outpost.goauthentik.io/ping
      port: {{ .Values.service.ldapmetrics.ports.ldapmetrics.targetPort }}




{{- end -}}
