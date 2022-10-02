{{/* Define the fetch container */}}
{{- define "crowdsec.fetch" -}}
image: {{ .Values.alpineImage.repository }}:{{ .Values.alpineImage.tag }}
imagePullPolicy: {{ .Values.alpineImage.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
command:
  - /bin/sh
  - -c
  - wget {{ .Values.crowdsec.lapi.dashboad.assetURL }} && unzip metabase_sqlite.zip -d /metabase-data/
volumeMounts:
  - name: shared-data
    mountPath: /metabase-data
{{- end -}}
