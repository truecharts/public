{{/*
This template serves as the blueprint for the mountPermissions job that is run
before chart installation.
*/}}
{{- define "common.storage.permissions" -}}
{{- if .Values.fixMountPermissions }}


{{- $jobName := include "common.names.fullname" . -}}
{{- $values := .Values -}}


{{- print "---" | nindent 0 -}}

apiVersion: batch/v1
kind: Job
metadata:
  name: {{ $jobName }}-autopermissions
  labels:
    {{- include "common.labels" . | nindent 4 }}
  annotations:
   "helm.sh/hook": pre-install,pre-upgrade
   "helm.sh/hook-weight": "-10"
   "helm.sh/hook-delete-policy": hook-succeeded,hook-failed,before-hook-creation
spec:
  template:
    metadata:
    spec:
      restartPolicy: Never
      containers:
        - name: set-mount-permissions
          image: "alpine:3.3"
          command:
          - /bin/sh
          - -c
          - | {{ range $index, $cs := .Values.customStorage}}{{ if and $cs.enabled $cs.setPermissions}}
            chown -R {{ if eq $values.podSecurityContext.runAsNonRoot false }}{{ print $values.PUID }}{{ else }}{{ print $values.podSecurityContext.runAsUser }}{{ end }}:{{ print $values.podSecurityContext.fsGroup }}  {{ print $cs.mountPath }}{{ end }}{{ end }}
          #args:
          #
          #securityContext:
          #
          volumeMounts:
            {{- include "common.controller.volumeMounts" . | indent 12 }}
      {{- with (include "common.controller.volumes" . | trim) }}
      volumes:
        {{- . | nindent 8 }}
      {{- end }}


{{- end }}
{{- end }}
