{{- define "zabbix.agent2" -}}
image: {{ .Values.agent2Image.repository }}:{{ .Values.agent2Image.tag }}
imagePullPolicy: {{ .Values.agent2Image.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
  capabilities:
    add:
      - SYS_TIME
volumeMounts:
  - name: hostsys
    mountPath: {{ .Values.persistence.hostsys.mountPath }}
  - name: hostproc
    mountPath: {{ .Values.persistence.hostproc.mountPath }}
  - name: agentconf
    mountPath: {{ .Values.persistence.agentconf.mountPath }}
  - name: agentenc
    mountPath: {{ .Values.persistence.agentenc.mountPath }}
  - name: agentbuffer
    mountPath: {{ .Values.persistence.agentbuffer.mountPath }}
envFrom:
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-agent-config'
ports:
  - containerPort: {{ .Values.service.agent.ports.agent.port }}
    name: agent
readinessProbe:
  tcpSocket:
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
livenessProbe:
  tcpSocket:
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
startupProbe:
  tcpSocket:
    port: {{ .Values.service.main.ports.main.targetPort }}
  initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
{{- end -}}
