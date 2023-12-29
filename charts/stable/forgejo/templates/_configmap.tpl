{{/* Define the configmap */}}
{{- define "forgejo.configmap" -}}
enabled: true
data:
  FORGEJO_APP_INI: "/data/gitea/conf/app.ini"
  FORGEJO_CUSTOM: "/data/gitea"
  FORGEJO_WORK_DIR: "/data"
  FORGEJO_TEMP: "/tmp/gitea"
  FORGEJO_ADMIN_USERNAME: {{ .Values.admin.username | quote }}
  FORGEJO_ADMIN_PASSWORD: {{ .Values.admin.password | quote }}
  SSH_PORT: {{ .Values.service.ssh.ports.ssh.port | quote }}
  SSH_LISTEN_PORT: {{ .Values.service.ssh.ports.ssh.targetPort | quote }}
  TMPDIR: "/tmp/gitea"
  GNUPGHOME: "/data/git/.gnupg"
{{- end -}}
