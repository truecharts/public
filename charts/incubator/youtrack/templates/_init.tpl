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
  {{- range (include "youtrack.args" . | fromYaml).args }}
  - {{ . }}
  {{- end -}}
{{- end -}}

{{- define "youtrack.args" -}}
args:
  - --listen-port={{ .Values.service.main.ports.main.port }}
  - --statistics-upload={{ .Values.youtrack.statisticsUpload }}
  - --jetbrains.youtrack.disableCheckForUpdate={{ .Values.youtrack.disableCheckForUpdate }}
  - --jetbrains.dnq.textIndex.minPrefixQueryLength={{ .Values.youtrack.minPrefixQueryLength }}
  - --jetbrains.youtrack.mailLimit={{ .Values.youtrack.mailLimit }}
  - --jetbrains.youtrack.event.merge.timeout={{ .Values.youtrack.eventMergeTimeout }}
  - --jetbrains.youtrack.default.page={{ .Values.youtrack.defaultPage }}
  - --jetbrains.http.request.header.buffer.size={{ .Values.youtrack.requestHeaderBufferSize }}
  - --jetbrains.youtrack.dumbMode={{ .Values.youtrack.dumbMode }}
  {{- with .Values.youtrack.licenseName }}
  - --jetbrains.youtrack.licenseName={{ . }}
  {{- end }}
  {{- with .Values.youtrack.licenseKey }}
  - --jetbrains.youtrack.licenseKey={{ . }}
  {{- end }}
  {{- with .Values.youtrack.webHooksBaseUrl }}
  - --jetbrains.youtrack.webHooksBaseUrl={{ . }}
  {{- end }}
  {{- if .Values.youtrack.admin_restore }}
  - --jetbrains.youtrack.admin.restore=true
  {{- end }}
  {{- with .Values.youtrack.support_email }}
  - --jetbrains.youtrack.support.email= {{ . }}
  {{- end }}
  {{- with .Values.youtrack.baseURL }}
  - --base-url={{ . }}
  {{- end }}
  {{- if .Values.youtrack.hubURL }}
  - --jetbrains.hub.auth.login.throttling.enabled={{ .Values.youtrack.authThrottlingEnabled }}
  - --hub-url={{ .Values.youtrack.hubURL }}
  {{- end }}
  {{- with .Values.youtrack.jvm.maxHeapSize }}
  - -J-Xmx{{ . }}
  {{- end }}
  {{- with .Values.youtrack.jvm.maxMetaspaceMemory }}
  - -J-XX:MaxMetaspaceSize{{ . }}
  {{- end }}
  {{- with .Values.youtrack.jvm.metaspaceMemory }}
  - -J-XX:MetaspaceSize{{ . }}
  {{- end }}
  {{- range .Values.youtrack.jvm.extraJVMOptions }}
  - -J{{ . }}
  {{- end }}
{{- end -}}
