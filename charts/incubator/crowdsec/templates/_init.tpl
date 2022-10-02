{{/* Define the fetch container */}}
{{- define "crowdsec.init" -}}
image: {{ .Values.image.repository }}:{{ .Values.image.tag }}
imagePullPolicy: {{ .Values.image.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
command:
  - /bin/sh
  - -c
args:
  - |
    echo "Fetching metabase assets..."
    wget {{ .Values.crowdsec.lapi.dashboard.assetURL }} && \
    unzip metabase_sqlite.zip -d /metabase-data/

    echo "Creating crowdsec files that do not exit..."
    mv -n /staging/etc/crowdsec/* /etc/crowdsec/
volumeMounts:
  - name: metabase-data
    mountPath: /metabase-data
  - name: crowdsec-config
    mountPath: /etc/crowdsec
{{- end -}}
