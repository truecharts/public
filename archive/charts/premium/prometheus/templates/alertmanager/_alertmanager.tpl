{{- define "prometheus.alertmanager.alertmanager" -}}
{{- if .Values.alertmanager.enabled }}
---
apiVersion: monitoring.coreos.com/v1
kind: Alertmanager
metadata:
  name: {{ template "kube-prometheus.alertmanager.fullname" . }}
  namespace: {{ .Release.Namespace }}
  labels: {{- include "kube-prometheus.alertmanager.labels" . | nindent 4 }}
spec:
  replicas: {{ .Values.alertmanager.replicaCount }}
  serviceAccountName: {{ template "kube-prometheus.alertmanager.serviceAccountName" . }}
  {{- if .Values.alertmanager.image }}
  image: {{ template "kube-prometheus.alertmanager.image" . }}
  {{- end }}
  listenLocal: {{ .Values.alertmanager.listenLocal }}
  {{- if index .Values.alertmanager "externalUrl" }}
  externalUrl: "{{ .Values.alertmanager.externalUrl }}"
  {{- else if and .Values.ingress.alertmanager.enabled .Values.ingress.alertmanager.hosts }}
  externalUrl: {{ if .Values.ingress.alertmanager.tls }}https{{else}}http{{ end }}://{{ (index .Values.ingress.alertmanager.hosts 0).name }}{{ .Values.alertmanager.routePrefix }}
  {{- else }}
  externalUrl: http://{{ template "kube-prometheus.alertmanager.fullname" . }}.{{ .Release.Namespace }}:{{ .Values.service.alertmanager.ports.alertmanager.port }}{{ .Values.alertmanager.routePrefix }}
  {{- end }}
  portName: "{{ .Values.alertmanager.portName }}"
  paused: {{ .Values.alertmanager.paused }}
  logFormat: {{ .Values.alertmanager.logFormat }}
  logLevel: {{ .Values.alertmanager.logLevel }}
  retention: {{ .Values.alertmanager.retention }}
  {{- if .Values.alertmanager.secrets }}
  secrets: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.alertmanager.secrets "context" $) | nindent 4 }}
  {{- end }}
  {{- if .Values.alertmanager.configMaps }}
  configMaps: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.alertmanager.configMaps "context" $) | nindent 4 }}
  {{- end }}
  resources: {{- toYaml .Values.alertmanager.resources | nindent 4 }}
  routePrefix: "{{ .Values.alertmanager.routePrefix }}"
  {{- if .Values.alertmanager.podSecurityContext.enabled }}
  securityContext: {{- omit .Values.alertmanager.podSecurityContext "enabled" | toYaml | nindent 4 }}
  {{- end }}
  {{- if .Values.alertmanager.storageSpec }}
  storage: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.alertmanager.storageSpec "context" $) | nindent 4 }}
  {{- else }}
  {{- if .Values.alertmanager.persistence.enabled }}
  storage:
    volumeClaimTemplate:
      spec:
        accessModes:
          {{- range .Values.alertmanager.persistence.accessModes }}
          - {{ . | quote }}
          {{- end }}
        resources:
          requests:
            storage: {{ .Values.alertmanager.persistence.size | quote }}
        {{- with (include "tc.v1.common.lib.storage.storageClassName" ( dict "rootCtx" . "objectData" .Values.prometheus.persistence )) | trim }}
        storageClassName: {{ . }}
        {{- end }}
  {{- end }}
  {{- end }}
  {{- if or .Values.alertmanager.podMetadata.labels .Values.alertmanager.podMetadata.annotations (eq .Values.alertmanager.podAntiAffinityPreset "soft") (eq .Values.alertmanager.podAntiAffinityPreset "hard") }}
  podMetadata:
    labels:
    {{- if .Values.alertmanager.podMetadata.labels }}
    {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.alertmanager.podMetadata.labels "context" $) | nindent 6 }}
    {{- end }}
    {{- if or (eq .Values.alertmanager.podAntiAffinityPreset "soft") (eq .Values.alertmanager.podAntiAffinityPreset "hard") }}
    {{- include "kube-prometheus.alertmanager.matchLabels" . | nindent 6 }}
    {{- end }}
    {{- if .Values.alertmanager.podMetadata.annotations }}
    annotations:
    {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.alertmanager.podMetadata.annotations "context" $) | nindent 6 }}
    {{- end }}
  {{- end }}
  {{- if .Values.alertmanager.affinity }}
  affinity: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.alertmanager.affinity "context" $) | nindent 4 }}
  {{- end }}
  {{- if .Values.alertmanager.nodeSelector }}
  nodeSelector: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.alertmanager.nodeSelector "context" $) | nindent 4 }}
  {{- end }}
  {{- if .Values.alertmanager.tolerations }}
  tolerations: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.alertmanager.tolerations "context" $) | nindent 4 }}
  {{- end }}
  {{- if .Values.alertmanager.volumes }}
  volumes: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.alertmanager.volumes "context" $) | nindent 4 }}
  {{- end }}
  {{- if .Values.alertmanager.volumeMounts }}
  volumeMounts: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.alertmanager.volumeMounts "context" $) | nindent 4 }}
  {{- end }}
{{- include "kube-prometheus.imagePullSecrets" . | indent 2 }}
  {{- if or .Values.alertmanager.containers .Values.alertmanager.containerSecurityContext.enabled .Values.operator.prometheusConfigReloader.containerSecurityContext.enabled }}
  containers:
    {{- if or .Values.alertmanager.containerSecurityContext.enabled .Values.alertmanager.livenessProbe.enabled .Values.alertmanager.readinessProbe.enabled }}
    ## This monkey patching is needed until the securityContexts are
    ## directly patchable via the CRD.
    ## ref: https://github.com/prometheus-operator/prometheus-operator/issues/3947
    ## currently implemented with strategic merge
    ## ref: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/user-guides/strategic-merge-patch.md
    - name: alertmanager
      {{- if .Values.alertmanager.containerSecurityContext.enabled }}
      securityContext: {{- omit .Values.alertmanager.containerSecurityContext "enabled" | toYaml | nindent 8 }}
      {{- end }}
      {{- if .Values.alertmanager.livenessProbe.enabled }}
      livenessProbe:
        httpGet:
          path: {{ .Values.alertmanager.livenessProbe.path }}
          port: alertmanager
          scheme: HTTP
        initialDelaySeconds: {{ .Values.alertmanager.livenessProbe.initialDelaySeconds }}
        periodSeconds: {{ .Values.alertmanager.livenessProbe.periodSeconds }}
        timeoutSeconds: {{ .Values.alertmanager.livenessProbe.timeoutSeconds }}
        failureThreshold: {{ .Values.alertmanager.livenessProbe.failureThreshold }}
        successThreshold: {{ .Values.alertmanager.livenessProbe.successThreshold }}
      {{- end }}
      {{- if .Values.alertmanager.readinessProbe.enabled }}
      readinessProbe:
        httpGet:
          path: {{ .Values.alertmanager.readinessProbe.path }}
          port: alertmanager
          scheme: HTTP
        initialDelaySeconds: {{ .Values.alertmanager.readinessProbe.initialDelaySeconds }}
        periodSeconds: {{ .Values.alertmanager.readinessProbe.periodSeconds }}
        timeoutSeconds: {{ .Values.alertmanager.readinessProbe.timeoutSeconds }}
        failureThreshold: {{ .Values.alertmanager.readinessProbe.failureThreshold }}
        successThreshold: {{ .Values.alertmanager.readinessProbe.successThreshold }}
      {{- end }}
    {{- end }}
    {{- if or .Values.operator.prometheusConfigReloader.containerSecurityContext.enabled .Values.operator.prometheusConfigReloader.livenessProbe.enabled .Values.operator.prometheusConfigReloader.readinessProbe.enabled }}
    ## This monkey patching is needed until the securityContexts are
    ## directly patchable via the CRD.
    ## ref: https://github.com/prometheus-operator/prometheus-operator/issues/3947
    ## currently implemented with strategic merge
    ## ref: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/user-guides/strategic-merge-patch.md
    - name: config-reloader
      {{- if .Values.operator.prometheusConfigReloader.containerSecurityContext.enabled }}
      securityContext: {{- omit .Values.operator.prometheusConfigReloader.containerSecurityContext "enabled" | toYaml | nindent 8 }}
      {{- end }}
      {{- if .Values.operator.prometheusConfigReloader.livenessProbe.enabled }}
      livenessProbe:
        tcpSocket:
          port: reloader-web
        initialDelaySeconds: {{ .Values.operator.prometheusConfigReloader.livenessProbe.initialDelaySeconds }}
        periodSeconds: {{ .Values.operator.prometheusConfigReloader.livenessProbe.periodSeconds }}
        timeoutSeconds: {{ .Values.operator.prometheusConfigReloader.livenessProbe.timeoutSeconds }}
        failureThreshold: {{ .Values.operator.prometheusConfigReloader.livenessProbe.failureThreshold }}
        successThreshold: {{ .Values.operator.prometheusConfigReloader.livenessProbe.successThreshold }}
      {{- end }}
      {{- if .Values.operator.prometheusConfigReloader.readinessProbe.enabled }}
      readinessProbe:
        tcpSocket:
          port: reloader-web
        initialDelaySeconds: {{ .Values.operator.prometheusConfigReloader.readinessProbe.initialDelaySeconds }}
        periodSeconds: {{ .Values.operator.prometheusConfigReloader.readinessProbe.periodSeconds }}
        timeoutSeconds: {{ .Values.operator.prometheusConfigReloader.readinessProbe.timeoutSeconds }}
        failureThreshold: {{ .Values.operator.prometheusConfigReloader.readinessProbe.failureThreshold }}
        successThreshold: {{ .Values.operator.prometheusConfigReloader.readinessProbe.successThreshold }}
      {{- end }}
    {{- end }}
    {{- if .Values.alertmanager.containers }}
    {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.alertmanager.containers "context" $) | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- if .Values.alertmanager.priorityClassName }}
  priorityClassName: {{ .Values.alertmanager.priorityClassName }}
  {{- end }}
  {{- if .Values.alertmanager.additionalPeers }}
  additionalPeers: {{ .Values.alertmanager.additionalPeers }}
  {{- end }}
  {{- if .Values.alertmanager.configNamespaceSelector }}
  alertmanagerConfigNamespaceSelector: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.alertmanager.configNamespaceSelector "context" $) | nindent 4 }}
  {{- end }}
  {{- if .Values.alertmanager.configSelector }}
  alertmanagerConfigSelector: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.alertmanager.configSelector "context" $) | nindent 4 }}
  {{- end }}
{{- end }}
{{- end }}
