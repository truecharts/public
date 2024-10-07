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
          {{ range $name, $csm := .Values.customStorage }}
          {{- if $csm.enabled -}}
          {{- if $csm.setPermissions -}}
          {{ if $csm.name }}
            {{ $name = $csm.name }}
          {{ end }}
          - name: customstorage-{{ $name }}
            mountPath: {{ $csm.mountPath }}
            {{ if $csm.subPath }}
            subPath: {{ $csm.subPath }}
            {{ end }}
          {{- end -}}
          {{- end -}}
          {{ end }}
      volumes:
      {{- range $name, $cs := .Values.customStorage -}}
      {{ if $cs.enabled }}
      {{ if $cs.setPermissions }}
      {{ if $cs.name }}
      {{ $name = $cs.name }}
      {{ end }}
      - name: customstorage-{{ $name }}
        {{ if $cs.emptyDir }}
        emptyDir: {}
        {{- else -}}
        hostPath:
          path: {{ required "hostPath not set" $cs.hostPath }}
        {{ end }}
      {{ end }}
      {{ end }}
      {{- end -}}


{{- end }}
{{- end }}
