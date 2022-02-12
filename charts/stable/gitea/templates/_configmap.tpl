{{/* Define the configmap */}}
{{- define "gitea.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: gitea-env
data:
  GITEA_APP_INI: "/data/gitea/conf/app.ini"
  GITEA_CUSTOM: "/data/gitea"
  GITEA_WORK_DIR: "/data"
  GITEA_TEMP: "/tmp/gitea"
  GITEA_ADMIN_USERNAME: {{ .Values.admin.username }}
  GITEA_ADMIN_PASSWORD: {{ .Values.admin.password }}
  SSH_PORT: {{ .Values.service.ssh.ports.ssh.port | quote }}
  SSH_LISTEN_PORT: {{ .Values.service.ssh.ports.ssh.targetPort | quote }}
  TMPDIR: "/tmp/gitea"
  GNUPGHOME: "/data/git/.gnupg"

{{- end -}}
