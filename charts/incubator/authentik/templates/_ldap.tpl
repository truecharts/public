{{/* Define the ldap container */}}
{{- define "authentik.ldap" -}}
image: {{ .Values.ldapImage.repository }}:{{ .Values.ldapImage.tag }}
imagePullPolicy: {{ .Values.ldapImage.pullPolicy }}
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
ports:
  - containerPort: {{ .Values.service.ldapldaps.ports.ldapldaps.targetPort }}
    name: ldapldaps
  - containerPort: {{ .Values.service.ldapldap.ports.ldapldap.targetPort }}
    name: ldapldap
{{- if .Values.outposts.ldap.metrics }}
  - containerPort: {{ .Values.service.ldapmetrics.ports.ldapmetrics.targetPort }}
    name: ldapmetrics
{{- end }}
readinessProbe:
  httpGet:
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.ldapmetrics.ports.ldapmetrics.targetPort }}
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
livenessProbe:
  httpGet:
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.ldapmetrics.ports.ldapmetrics.targetPort }}
  initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
startupProbe:
  httpGet:
    path: /outpost.goauthentik.io/ping
    port: {{ .Values.service.ldapmetrics.ports.ldapmetrics.targetPort }}
  initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
{{- end -}}
