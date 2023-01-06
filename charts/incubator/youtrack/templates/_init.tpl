{{- define "youtrack.init" -}}
image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
imagePullPolicy: {{ .Values.image.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilysystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
volumeMounts:
  - name: conf
    mountPath: {{ .Values.persistence.conf.mountPath }}
args:
  - configure
  {{- (include "youtrack.args" . | trim) | nindent 2 -}}
{{- end -}}

{{- define "youtrack.args" -}}
  - --listen-port={{ .Values.service.main.ports.main.port }}
  - --data-dir={{ .Values.persistence.data.mountPath }}
  - --temp-dir={{ .Values.persistence.youtracktemp.mountPath }}
  - --logs-dir={{ .Values.persistence.logs.mountPath }}
  - --backups-dir={{ .Values.persistence.backups.mountPath }}
  - --statistics-upload={{ .Values.youtrack.statisticsUpload }}
  - --jetbrains.youtrack.disableCheckForUpdate={{ .Values.youtrack.disableCheckForUpdate }}
  - --jetbrains.dnq.textIndex.minPrefixQueryLength={{ .Values.youtrack.minPrefixQueryLength }}
  - --jetbrains.youtrack.mailLimit={{ .Values.youtrack.mailLimit }}
  {{- if .Values.youtrack.admin_restore }}
  - --jetbrains.youtrack.admin.restore=true
  {{- end }}
  {{- with .Values.youtrack.support_email }}
  - --jetbrains.youtrack.support.email= {{ . }}
  {{- end }}
  {{- with .Values.youtrack.baseURL }}
  - --base-url={{ . }}
  {{- end }}
  {{- with .Values.youtrack.hubURL }}
  - --hub-url={{ . }}
  {{- end }}
{{- end -}}
