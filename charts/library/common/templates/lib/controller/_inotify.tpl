{{/*
This template serves as the blueprint for the mountPermissions job that is run
before chart installation.
*/}}
{{- define "common.controller.inotify" -}}
- name: inotify
  image: {{ .Values.alpineImage.repository }}:{{ .Values.alpineImage.tag }}
  securityContext:
    runAsUser: 0
    privileged: true
    allowPrivilegeEscalation: false
  command:
    - "/bin/sh"
    - "-c"
    - "sysctl -w fs.inotify.max_user_watches=524288 && sysctl -w fs.inotify.max_user_instances=512 "
{{- end -}}
