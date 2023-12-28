{{- define "briefkasten.createdb" -}}
image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
imagePullPolicy: {{ .Values.image.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
envFrom:
  - secretRef:
      name: '{{ include "tc.common.names.fullname" . }}-secret'
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-config'
command: ["/bin/sh", "-c"]
args:
  - |-
    pnpm start &
    echo "Waiting 5s for app to start..."
    sleep 5
    echo "Executing DB Seed..."
    until pnpm db:push; do echo "DB Seed failed... Retrying in 5s..." sleep 5; done;
    echo "...Done"
    echo "Exiting... App will start now..."
    exit 0
{{- end -}}
