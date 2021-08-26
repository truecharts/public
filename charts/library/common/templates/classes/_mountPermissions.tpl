{{/*
This template serves as the blueprint for the mountPermissions job that is run
before chart installation.
*/}}
{{- define "common.class.mountPermissions" -}}
  {{- if .Values.persistence -}}
    {{- $jobName := include "common.names.fullname" . -}}
    {{- $group := 568 -}}
    {{- if .Values.env -}}
        {{- $group = dig "PGID" $group .Values.env -}}
    {{- end -}}
    {{- $group = dig "fsGroup" $group .Values.podSecurityContext -}}
    {{- $hostPathMounts := dict -}}
    {{- range $name, $mount := .Values.persistence -}}
      {{- if and $mount.enabled $mount.setPermissions -}}
        {{- $name = default ( $name| toString ) $mount.name -}}
        {{- $_ := set $hostPathMounts $name $mount -}}
      {{- end -}}
    {{- end }}
    {{- if $hostPathMounts -}}
---
apiVersion: batch/v1
kind: Job
metadata:
  name: {{ printf "%s-auto-permissions" $jobName }}
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
          image: alpine:3.3
          command: ["/bin/sh", "-c"]
          args:
            {{- range $_, $hpm := $hostPathMounts }}
            - chown -R {{ printf ":%d %s" (int $group) ( $hpm.mountPath | squote ) }}
            {{- end }}
          volumeMounts:
            {{- range $name, $hpm := $hostPathMounts }}
            - name: {{ printf "hostpathmounts-%s" $name }}
              mountPath: {{ $hpm.mountPath }}
              {{- if $hpm.subPath }}
              subPath: {{ $hpm.subPath }}
              {{- end }}
            {{- end }}
      volumes:
        {{- range $name, $hpm := $hostPathMounts }}
        - name: {{ printf "hostpathmounts-%s" $name }}
          {{- /* Always prefer an emptyDir next if that is set */}}
          {{- $emptyDir := false -}}
          {{- if $hpm.emptyDir -}}
            {{- if $hpm.emptyDir.enabled -}}
              {{- $emptyDir = true -}}
            {{- end -}}
          {{- end -}}
          {{- if $emptyDir }}
          {{- if or $hpm.emptyDir.medium $hpm.emptyDir.sizeLimit }}
          emptyDir:
            {{- with $hpm.emptyDir.medium }}
            medium: "{{ . }}"
            {{- end }}
            {{- with $hpm.emptyDir.sizeLimit }}
            sizeLimit: "{{ . }}"
            {{- end }}
          {{- else }}
          emptyDir: {}
          {{- end }}
          {{- else }}
          hostPath:
            path: {{ required "hostPath not set" $hpm.hostPath }}
          {{ end }}
        {{- end }}
    {{- end -}}
  {{- end -}}
{{- end -}}
