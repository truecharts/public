{{/* Define the ml container */}}
{{- define "immich.ml" -}}
  {{- if hasKey .Values "imageML" -}} {{/* For smooth upgrade, Remove later*/}}
    {{- $img := .Values.imageML -}}
    {{- $_ := set .Values "mlImage" (dict "repository" $img.repository "tag" $img.tag "pullPolicy" $img.pullPolicy) -}}
  {{- end }}
image: {{ .Values.mlImage.repository }}:{{ .Values.mlImage.tag }}
imagePullPolicy: {{ .Values.mlImage.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
command:
  {{- if .Values.persistence.modelcache }}{{/* Only change command after upgrade */}}
  - python
  - src/main.py
  {{- else }}
  - /bin/sh
  - ./entrypoint.sh
  {{- end }}
volumeMounts:
  - name: uploads
    mountPath: {{ .Values.persistence.uploads.mountPath }}
  {{- if .Values.persistence.modelcache }}
  - name: modelcache
    mountPath: {{ .Values.persistence.modelcache.mountPath }}
  {{- end }}
envFrom:
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-common-config'
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-server-config'
  - secretRef:
      name: '{{ include "tc.common.names.fullname" . }}-immich-secret'
#readinessProbe:
#  exec:
#    command:
#      - /bin/sh
#      - -c
#      - |
#        grep -q main.js /proc/1/cmdline || exit 1
#  initialDelaySeconds: {{ .Values.probes.readiness.spec.initialDelaySeconds }}
#  timeoutSeconds: {{ .Values.probes.readiness.spec.timeoutSeconds }}
#  periodSeconds: {{ .Values.probes.readiness.spec.periodSeconds }}
#  failureThreshold: {{ .Values.probes.readiness.spec.failureThreshold }}
#livenessProbe:
#  exec:
#    command:
#      - /bin/sh
#      - -c
#      - |
#        grep -q main.js /proc/1/cmdline || exit 1
#  initialDelaySeconds: {{ .Values.probes.liveness.spec.initialDelaySeconds }}
#  timeoutSeconds: {{ .Values.probes.liveness.spec.timeoutSeconds }}
#  periodSeconds: {{ .Values.probes.liveness.spec.periodSeconds }}
#  failureThreshold: {{ .Values.probes.liveness.spec.failureThreshold }}
#startupProbe:
#  exec:
#    command:
#      - /bin/sh
#      - -c
#      - |
#        grep -q main.js /proc/1/cmdline || exit 1
#  initialDelaySeconds: {{ .Values.probes.startup.spec.initialDelaySeconds }}
#  timeoutSeconds: {{ .Values.probes.startup.spec.timeoutSeconds }}
#  periodSeconds: {{ .Values.probes.startup.spec.periodSeconds }}
#  failureThreshold: {{ .Values.probes.startup.spec.failureThreshold }}
{{- end -}}
