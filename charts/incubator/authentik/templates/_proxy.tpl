{{/* Define the proxy container */}}
{{- define "authentik.proxy" -}}
image: {{ .Values.proxyImage.repository }}:{{ .Values.proxyImage.tag }}
imagePullPolicy: {{ .Values.proxyImage.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: true
  runAsNonRoot: true
envFrom:
  - secretRef:
      name: '{{ include "tc.common.names.fullname" . }}-proxy-secret'
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-proxy-config'
ports:
  - containerPort: {{ .Values.outposts.proxy.httpsInternalPort }}
  - containerPort: {{ .Values.outposts.proxy.httpInternalPort }}
{{- if .Values.outposts.proxy.metrics }}
  - containerPort: {{ .Values.outposts.proxy.metricsInternalPort }}
    name: proxy-metrics
{{- end }}
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

{{- define "authentik.proxy.service" -}}
enabled: true
type: ClusterIP
ports:
  proxy-https:
    enabled: true
    port: 10233
    protocol: HTTPS
    targetPort: {{ .Values.outposts.proxy.httpsInternalPort }}
  proxy-http:
    enabled: true
    port: 10234
    protocl: HTTP
    targetPort: {{ .Values.outposts.proxy.httpInternalPort }}
{{- if .Values.outposts.ldap.metrics }}
  proxy-metrics:
    enabled: true
    port: 10235
    protocol: HTTP
    targetPort: {{ .Values.outposts.proxy.metricsInternalPort }}
{{- end }}
{{- end -}}
