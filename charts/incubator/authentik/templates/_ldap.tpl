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
ports:
  - containerPort: 3389
  - containerPort: 6636
{{- if .Values.outposts.ldap.metrics -}}
  - containerPort: 9300
{{- end -}}
readinessProbe:
  exec:
    command:
      - "wget"
      - "--spider"
      - "http://localhost:9300/outpost.goauthentik.io/ping"
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
livenessProbe:
  exec:
    command:
      - "wget"
      - "--spider"
      - "http://localhost:9300/outpost.goauthentik.io/ping"
  initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
startupProbe:
  exec:
    command:
      - "wget"
      - "--spider"
      - "http://localhost:9300/outpost.goauthentik.io/ping"
  initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
{{- end -}}
---
{{- define "authentik.ldap.services.enabled" -}}
{{- $_ := set .Values.service.ldap "enabled" true -}}
{{- $_ := set .Values.service.ldap.ports.ldap1 "enabled" true -}}
{{- $_ := set .Values.service.ldap.ports.ldap2 "enabled" true -}}
{{- if .Values.outposts.ldap.metrics -}}
{{- $_ := set .Values.service.ldap.ports.metrics "enabled" true -}}
{{- end -}}
{{- end -}}
---
{{- define "authentik.ldap.services.disabled" -}}
{{- $_ := set .Values.service.ldap "enabled" false -}}
{{- $_ := set .Values.service.ldap.ports.ldap1 "enabled" false -}}
{{- $_ := set .Values.service.ldap.ports.ldap2 "enabled" false -}}
{{- $_ := set .Values.service.ldap.ports.metrics "enabled" false -}}
{{- end -}}
