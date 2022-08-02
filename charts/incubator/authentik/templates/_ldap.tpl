{{/* Define the ldap container */}}
{{- define "authentik.ldap" -}}
image: {{ .Values.ldapImage.repository }}:{{ .Values.ldapImage.tag }}
imagePullPolicy: '{{ .Values.ldapImage.pullPolicy }}'
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: true
  runAsNonRoot: true
envFrom:
  - secretRef:
      name: '{{ include "tc.common.names.fullname" . }}-ldap-secret'
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-ldap-config'
{{/* TODO: Add healthchecks */}}
{{- end -}}
---
{{- define "authentik.ldap.service" -}}
enabled: true
ports:
  ldap1:
    enabled: true
    type: {{ .Values.outposts.ldap.ldap1_type }}
    port: {{ .Values.outposts.ldap.ldap1_external_port }}
    targetPort: 3389
  ldap2:
    enabled: true
    type: {{ .Values.outposts.ldap.ldap2_type }}
    port: {{ .Values.outposts.ldap.ldap2_external_port }}
    targetPort: 6636
{{- end -}}
