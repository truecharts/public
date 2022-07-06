{{/* Define the nginx container */}}
{{- define "nextcloud.nginx" -}}
image: {{ .Values.nginxImage.repository }}:{{ .Values.nginxImage.tag }}
imagePullPolicy: '{{ .Values.image.pullPolicy }}'
securityContext:
  runAsUser: 33
  runAsGroup: 33
  readOnlyRootFilesystem: true
  runAsNonRoot: true
{{- with (include "tc.common.controller.volumeMounts" . | trim) }}
volumeMounts:
  {{ nindent 2 . }}
{{- end }}
  - mountPath: /etc/nginx/nginx.conf
    name: nginx
    readOnly: true
    subPath: nginx.conf
ports:
  - containerPort: 8080

readinessProbe:
  httpGet:
    path: /robots.txt
    port: 8080
    httpHeaders:
    - name: Host
      value: "test.fakedomain.dns"
  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
livenessProbe:
  httpGet:
    path: /robots.txt
    port: 8080
    httpHeaders:
    - name: Host
      value: "test.fakedomain.dns"
  initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
startupProbe:
  httpGet:
    path: /robots.txt
    port: 8080
    httpHeaders:
    - name: Host
      value: "test.fakedomain.dns"
  initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
  periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
  timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
  failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
{{- end -}}
