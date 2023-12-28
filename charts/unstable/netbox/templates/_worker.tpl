{{/* Define the worker container */}}
{{- define "netbox.worker" -}}
image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
imagePullPolicy: {{ .Values.image.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
command:
  - /bin/bash
  - -c
  - |
    echo "Starting worker...."
    until $(curl --output /dev/null --silent --head --fail http://127.0.0.1:8080/login); do
      echo "Worker: Waiting for the main netbox container..."
      sleep 5
    done
    /opt/netbox/venv/bin/python /opt/netbox/netbox/manage.py rqworker
volumeMounts:
  - name: config
    mountPath: /etc/netbox/config
  - name: reports
    mountPath: /etc/netbox/reports
  - name: scripts
    mountPath: /etc/netbox/scritps
  - name: media
    mountPath: /opt/netbox/netbox/media
  - name: configfile
    mountPath: /etc/netbox/config/01-config.py
    subPath: config.py
readinessProbe:
  exec:
    command:
      - /bin/bash
      - -c
      - |
        ps -aux | grep -v grep | grep -q rqworker || exit 1
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
livenessProbe:
  exec:
    command:
      - /bin/bash
      - -c
      - |
        ps -aux | grep -v grep | grep -q rqworker || exit 1
  initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
startupProbe:
  exec:
    command:
      - /bin/bash
      - -c
      - |
        ps -aux | grep -v grep | grep -q rqworker || exit 1
  initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
  timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
  periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
  failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
{{- end -}}
