{{/* Define the typesense container */}}
{{- define "immich.typesense" -}}
  {{- if hasKey .Values "imageTypesense" -}} {{/* For smooth upgrade, Remove later*/}}
    {{- $img := .Values.imageTypesense -}}
    {{- $_ := set .Values "typesenseImage" (dict "repository" $img.repository "tag" $img.tag "pullPolicy" $img.pullPolicy) -}}
  {{- end }}
image: {{ .Values.typesenseImage.repository }}:{{ .Values.typesenseImage.tag }}
imagePullPolicy: {{ .Values.typesenseImage.pullPolicy }}
securityContext:
  runAsUser: {{ .Values.podSecurityContext.runAsUser }}
  runAsGroup: {{ .Values.podSecurityContext.runAsGroup }}
  readOnlyRootFilesystem: {{ .Values.securityContext.readOnlyRootFilesystem }}
  runAsNonRoot: {{ .Values.securityContext.runAsNonRoot }}
volumeMounts:
  - name: tsdata
    mountPath: {{ .Values.persistence.typesense_data.mountPath }}
envFrom:
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-common-config'
  - configMapRef:
      name: '{{ include "tc.common.names.fullname" . }}-server-config'
  - secretRef:
      name: '{{ include "tc.common.names.fullname" . }}-immich-secret'
