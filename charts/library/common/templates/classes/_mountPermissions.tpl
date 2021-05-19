{{/*
This template serves as the blueprint for the mountPermissions job that is run
before chart installation.
*/}}
{{- define "common.class.mountPermissions" -}}
  {{- if .Values.hostPathMounts -}}
    {{- $jobName := include "common.names.fullname" . -}}
    {{- $user := 568 -}}
    {{- if .Values.env -}}
      {{- $user = dig "PUID" $user .Values.env -}}
    {{- end -}}
    {{- $user = dig "runAsUser" $user .Values.podSecurityContext -}}
    {{- $group := 568 -}}
    {{- if and .Values.env -}}
      {{- $group = dig "PGID" $group .Values.env -}}
    {{- end -}}
    {{- $group = dig "fsGroup" $group .Values.podSecurityContext -}}
    {{- $hostPathMounts := dict -}}
    {{- range $name, $mount := .Values.hostPathMounts -}}
      {{- if and $mount.enabled $mount.setPermissions -}}
        {{- $name = default $name $mount.name -}}
        {{- $_ := set $hostPathMounts $name $mount -}}
      {{- end -}}
    {{- end }}
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
          command:
            - /bin/sh
            - -c
            - |
              {{- range $_, $hpm := $hostPathMounts }}
              chown -R {{ printf "%d:%d %s" (int $user) (int $group) $hpm.mountPath }}
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
          {{- if $hpm.emptyDir }}
          emptyDir: {}
          {{- else }}
          hostPath:
            path: {{ required "hostPath not set" $hpm.hostPath }}
          {{- end }}
        {{- end }}
  {{- end -}}
{{- end -}}
