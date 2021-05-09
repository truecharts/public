{{/*
This template serves as the blueprint for the mountPermissions job that is run
before chart installation.
*/}}
{{- define "common.classes.mountPermissions" -}}
{{- if .Values.hostPathMounts -}}

{{- $jobName := include "common.names.fullname" . -}}
{{- $values := .Values -}}
{{- $user := 568 -}}
{{- $group := 568 -}}
{{- print "---" | nindent 0 -}}

{{- if $values.podSecurityContext }}
  {{- if $values.podSecurityContext.runAsUser }}
    {{- $user = $values.podSecurityContext.runAsUser -}}
  {{- end -}}
  {{- if $values.podSecurityContext.fsGroup -}}
    {{- $group = $values.podSecurityContext.fsGroup -}}
  {{- end -}}
{{- else if $values.env }}
  {{- if $values.env.PUID }}
    {{- $user = $values.env.PUID -}}
  {{- end -}}
  {{- if $values.env.PGID }}
    {{- $group = $values.env.PGID -}}
  {{- end -}}
{{- end -}}

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
          - | {{ range $index, $hpm := .Values.hostPathMounts}}{{ if and $hpm.enabled $hpm.setPermissions}}
            chown -R {{ print $user }}:{{ print $group }} {{ print $hpm.mountPath }}{{ end }}{{ end }}
          #args:
          #
          #securityContext:
          #
          volumeMounts:
          {{ range $name, $hpmm := .Values.hostPathMounts }}
          {{- if $hpmm.enabled -}}
          {{- if $hpmm.setPermissions -}}
          {{ if $hpmm.name }}
            {{ $name = $hpmm.name }}
          {{ end }}
          - name: hostpathmounts-{{ $name }}
            mountPath: {{ $hpmm.mountPath }}
            {{ if $hpmm.subPath }}
            subPath: {{ $hpmm.subPath }}
            {{ end }}
          {{- end -}}
          {{- end -}}
          {{ end }}
      volumes:
      {{- range $name, $hpm := .Values.hostPathMounts -}}
      {{ if $hpm.enabled }}
      {{ if $hpm.setPermissions }}
      {{ if $hpm.name }}
      {{ $name = $hpm.name }}
      {{ end }}
      - name: hostpathmounts-{{ $name }}
        {{ if $hpm.emptyDir }}
        emptyDir: {}
        {{- else -}}
        hostPath:
          path: {{ required "hostPath not set" $hpm.hostPath }}
        {{ end }}
      {{ end }}
      {{ end }}
      {{- end -}}

{{- end }}
{{- end }}
