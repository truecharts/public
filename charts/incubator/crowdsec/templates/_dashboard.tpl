{{/* Define the dashboard container */}}
{{- define "crowdsec.dashboard" -}}
image: {{ .Values.dashboardImage.repository }}:{{ .Values.dashboardImage.tag }}
imagePullPolicy: {{ .Values.dashboardImage.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
command:
  - /bin/sh
  - -c
  - ln -fs /var/lib/crowdsec/data/crowdsec.db /metabase-data/crowdsec.db && /app/run_metabase.sh
envFrom:
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-dashboard-config'
ports:
  - containerPort: 3000
    name: dashboard
volumeMounts:
  - name: shared-data
    mountPath: /metabase-data
  - name: crowdsec_data
    mountPath: /var/lib/crowdsec/data
readinessProbe:
  httpGet:
    path: /
    port: 3000
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
livenessProbe:
  httpGet:
    path: /
    port: 3000
  initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
startupProbe:
  httpGet:
    path: /
    port: 3000
  initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
{{- end -}}
