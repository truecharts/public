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
  - --base-url={{ .Values.youtrack.baseURL }}
  - --statistics-upload={{ .Values.youtrack.statisticsUpload }}
  {{- with .Values.youtrack.hubURL }}
  - --hub-url={{ . }}
  {{- end }}
  - -J-Ddisable.configuration.wizard.on.clean.install=true
  - -J-Djetbrains.youtrack.disableCheckForUpdate={{ .Values.youtrack.disableCheckForUpdate }}
  - -J-Djetbrains.dnq.textIndex.minPrefixQueryLength={{ .Values.youtrack.minPrefixQueryLength }}
  - -J-Djetbrains.youtrack.mailLimit={{ .Values.youtrack.mailLimit }}
  - -J-Djetbrains.youtrack.event.merge.timeout={{ .Values.youtrack.eventMergeTimeout }}
  - -J-Djetbrains.youtrack.default.page={{ .Values.youtrack.defaultPage }}
  - -J-Djetbrains.http.request.header.buffer.size={{ .Values.youtrack.requestHeaderBufferSize }}
  - -J-Djetbrains.youtrack.dumbMode={{ .Values.youtrack.dumbMode }}
  - -J-Djetbrains.hub.auth.login.throttling.enabled={{ .Values.youtrack.authThrottlingEnabled }}
  {{- with .Values.youtrack.licenseName }}
  - -J-Djetbrains.youtrack.licenseName={{ . }}
  {{- end }}
  {{- with .Values.youtrack.licenseKey }}
  - -J-Djetbrains.youtrack.licenseKey={{ . }}
  {{- end }}
  {{- with .Values.youtrack.webHooksBaseUrl }}
  - -J-Djetbrains.youtrack.webHooksBaseUrl={{ . }}
  {{- end }}
  {{- if .Values.youtrack.admin_restore }}
  - -J-Djetbrains.youtrack.admin.restore=true
  {{- end }}
  {{- with .Values.youtrack.support_email }}
  - -J-Djetbrains.youtrack.support.email= {{ . }}
  {{- end }}
  {{- with .Values.youtrack.jvm.maxHeapSize }}
  - -J-Xmx{{ . }}
  {{- end }}
  {{- with .Values.youtrack.jvm.maxMetaspaceMemory }}
  - -J-XX:MaxMetaspaceSize={{ . }}
  {{- end }}
  {{- with .Values.youtrack.jvm.metaspaceMemory }}
  - -J-XX:MetaspaceSize={{ . }}
  {{- end }}
  {{- range .Values.youtrack.jvm.extraJVMOptions }}
  - -J{{ . }}
  {{- end }}
{{- end -}}
