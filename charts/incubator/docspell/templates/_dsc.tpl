{{/* Define the dsc container */}}
{{- define "docspell.dsc" -}}
image: {{ .Values.dscImage.repository }}:{{ .Values.dscImage.tag }}
imagePullPolicy: {{ .Values.dscImage.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
volumeMounts:
  - name: import
    mountPath: /import
command:
  - dsc
  - --docspell-url
  - {{ printf "%v:%v" "http://localhost" .Values.service.main.ports.main.port | quote }}
  - watch
  - --recursive
  - --integration
  - --header
  - {{ printf "%v:%v" .Values.rest_server.integration_endpoint.http_header.header_name .Values.rest_server.integration_endpoint.http_header.header_value | quote }}
  {{- if .Values.dsc.language }}
  - --language
  - {{ .Values.dsc.language }}
  {{- end }}
  {{- if .Values.dsc.tag }}
  - --tag
  - {{ .Values.dsc.tag }}
  {{- end }}
  {{- if .Values.dsc.not_match_glob }}
  - --not-matches
  - {{ .Values.dsc.not_match_glob | quote }}
  {{- end }}
  {{- if .Values.dsc.match_glob }}
  - --matches
  - {{ .Values.dsc.match_glob | quote }}
  {{- end }}
  {{- if eq .Values.dsc.imported_action "delete" }}
  - --delete
  {{- else if eq .Values.dsc.imported_action "move" }}
  - --move
  - {{ .Values.persistence.import.mountPath }}/imported
  {{- end }}
  - {{ .Values.persistence.import.mountPath }}/docs
{{- end -}}
