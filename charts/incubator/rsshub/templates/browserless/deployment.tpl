{{- if .Values.mercuryParser.enabled }}
apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ include "rsshub.browserless.fullname" . }}
  labels:
  {{- include "rsshub.labels" . | nindent 4 }}
spec:
  {{- if not .Values.mercuryParser.autoscaling.enabled }}
  replicas: {{ .Values.mercuryParser.replicaCount }}
  {{- end }}
  selector:
    matchLabels:
      {{- include "rsshub.browserless.selectorLabels" . | nindent 6 }}
  template:
    metadata:
      {{- with (mergeOverwrite (deepCopy .Values.global.podAnnotations) .Values.mercuryParser.podAnnotations) }}
      annotations:
      {{- toYaml . | nindent 8 }}
      {{- end }}
      labels:
    {{- include "rsshub.browserless.selectorLabels" . | nindent 8 }}
    spec:
      {{- with .Values.global.imagePullSecrets }}
      imagePullSecrets:
      {{- toYaml . | nindent 8 }}
      {{- end }}
      securityContext:
      {{- toYaml .Values.podSecurityContext | nindent 8 }}
      containers:
        - name: {{ .Chart.Name }}
          securityContext:
          {{- toYaml .Values.securityContext | nindent 12 }}
          image: "{{ .Values.browserless.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
          imagePullPolicy: {{ .Values.image.pullPolicy }}
          resources:
      {{- toYaml .Values.resources | nindent 12 }}
      {{- with  .Values.browserless.nodeSelector }}
      nodeSelector:
      {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.browserless.affinity }}
      affinity:
      {{- toYaml . | nindent 8 }}
      {{- end }}
      {{- with .Values.browserless.tolerations }}
      tolerations:
      {{- toYaml . | nindent 8 }}
  {{- end }}
{{- end }}