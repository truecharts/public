{{- define "prometheus.prometheus.prometheus" -}}
{{- if .Values.prometheus.enabled }}
---
apiVersion: monitoring.coreos.com/v1
kind: Prometheus
metadata:
  name: {{ template "kube-prometheus.prometheus.fullname" . }}
  namespace: {{ .Release.Namespace }}
  labels: {{- include "kube-prometheus.prometheus.labels" . | nindent 4 }}
spec:
  replicas: {{ .Values.prometheus.replicaCount }}
  serviceAccountName: {{ template "kube-prometheus.prometheus.serviceAccountName" . }}
  {{- if .Values.prometheus.serviceMonitorSelector }}
  serviceMonitorSelector: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.serviceMonitorSelector "context" $) | nindent 4 }}
  {{- else }}
  serviceMonitorSelector: {}
  {{- end }}
  {{- if .Values.prometheus.podMonitorSelector }}
  podMonitorSelector: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.podMonitorSelector "context" $) | nindent 4 }}
  {{- else }}
  podMonitorSelector: {}
  {{- end }}
  {{- if .Values.prometheus.probeSelector }}
  probeSelector: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.probeSelector "context" $) | nindent 4 }}
  {{- else }}
  probeSelector: {}
  {{- end }}
  {{- if .Values.prometheus.scrapeConfigSelector }}
  scrapeConfigSelector: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.scrapeConfigSelector "context" $) | nindent 4 }}
  {{- else }}
  scrapeConfigSelector: {}
  {{- end }}
  alerting:
    alertmanagers:
    {{- if .Values.prometheus.alertingEndpoints }}
    {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.alertingEndpoints "context" $) | nindent 6 }}
    {{- else if .Values.alertmanager.enabled }}
      - namespace: {{ .Release.Namespace }}
        name: {{ template "kube-prometheus.alertmanager.fullname" . }}
        port: http
        pathPrefix: "{{ .Values.alertmanager.routePrefix }}"
    {{- else }}
      []
    {{- end }}
  {{- if .Values.prometheus.image }}
  image: {{ template "kube-prometheus.prometheus.image" . }}
  {{- end }}
  {{- if .Values.prometheus.externalLabels }}
  externalLabels: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.externalLabels "context" $) | nindent 4 }}
  {{- end }}
  {{- if .Values.prometheus.prometheusExternalLabelNameClear }}
  prometheusExternalLabelName: ""
  {{- else if .Values.prometheus.prometheusExternalLabelName }}
  prometheusExternalLabelName: "{{ .Values.prometheus.prometheusExternalLabelName }}"
  {{- end }}
  {{- if .Values.prometheus.replicaExternalLabelNameClear }}
  replicaExternalLabelName: ""
  {{- else if .Values.prometheus.replicaExternalLabelName }}
  replicaExternalLabelName: "{{ .Values.prometheus.replicaExternalLabelName }}"
  {{- end }}
  {{- if index .Values.prometheus "externalUrl" }}
  externalUrl: "{{ .Values.prometheus.externalUrl }}"
  {{- else if and .Values.ingress.main.enabled .Values.ingress.main.hosts }}
  externalUrl: {{ if .Values.ingress.main.tls }}https{{else}}http{{ end }}://{{ (index .Values.ingress.main.hosts 0).name }}{{ .Values.prometheus.routePrefix }}
  {{- else }}
  externalUrl: http://{{ template "kube-prometheus.prometheus.fullname" . }}.{{ .Release.Namespace }}:9090{{ .Values.prometheus.routePrefix }}
  {{- end }}
  paused: {{ .Values.prometheus.paused }}
  logLevel: {{ .Values.prometheus.logLevel }}
  logFormat: {{ .Values.prometheus.logFormat }}
  listenLocal: {{ .Values.prometheus.listenLocal }}
  enableAdminAPI: {{ .Values.prometheus.enableAdminAPI }}
  {{- if .Values.prometheus.enableFeatures }}
  enableFeatures:
    {{- range .Values.prometheus.enableFeatures }}
    - {{ . | quote }}
    {{- end }}
  {{- end }}
  {{- if .Values.prometheus.scrapeInterval }}
  scrapeInterval: {{ .Values.prometheus.scrapeInterval }}
  {{- end }}
  {{- if .Values.prometheus.evaluationInterval }}
  evaluationInterval: {{ .Values.prometheus.evaluationInterval }}
  {{- end }}
  {{- if .Values.prometheus.resources }}
  resources: {{- toYaml .Values.prometheus.resources | nindent 4 }}
  {{- end }}
  retention: {{ .Values.prometheus.retention }}
  {{- if .Values.prometheus.retentionSize }}
  retentionSize: {{ .Values.prometheus.retentionSize }}
  {{- end }}
  {{- if .Values.prometheus.disableCompaction }}
  disableCompaction: {{ .Values.prometheus.disableCompaction }}
  {{- end }}
  {{- if .Values.prometheus.enableRemoteWriteReceiver }}
  enableRemoteWriteReceiver: {{ .Values.prometheus.enableRemoteWriteReceiver }}
  {{- end }}
  {{- if .Values.prometheus.walCompression }}
  walCompression: {{ .Values.prometheus.walCompression }}
  {{- end }}
  portName: "{{ .Values.prometheus.portName }}"
  routePrefix: "{{ .Values.prometheus.routePrefix }}"
  {{- if .Values.prometheus.secrets }}
  secrets: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.secrets "context" $) | nindent 4 }}
  {{- end }}
  {{- if .Values.prometheus.configMaps }}
  configMaps: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.configMaps "context" $) | nindent 4 }}
  {{- end }}
  {{- if .Values.prometheus.serviceMonitorNamespaceSelector }}
  serviceMonitorNamespaceSelector: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.serviceMonitorNamespaceSelector "context" $) | nindent 4 }}
  {{- else }}
  serviceMonitorNamespaceSelector: {}
  {{- end }}
  {{- if .Values.prometheus.podMonitorNamespaceSelector }}
  podMonitorNamespaceSelector: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.podMonitorNamespaceSelector "context" $) | nindent 4 }}
  {{- else }}
  podMonitorNamespaceSelector: {}
  {{- end }}
  {{- if .Values.prometheus.probeNamespaceSelector }}
  probeNamespaceSelector: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.probeNamespaceSelector "context" $) | nindent 4 }}
  {{- else }}
  probeNamespaceSelector: {}
  {{- end }}
  {{- if .Values.prometheus.scrapeConfigNamespaceSelector }}
  scrapeConfigNamespaceSelector: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.scrapeConfigNamespaceSelector "context" $) | nindent 4 }}
  {{- else }}
  scrapeConfigNamespaceSelector: {}
  {{- end }}
  {{- if .Values.prometheus.remoteRead }}
  remoteRead: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.remoteRead "context" $) | nindent 4 }}
  {{- end }}
  {{- with .Values.prometheus.remoteWrite }}
  remoteWrite:
    {{- tpl (toYaml .) $ | nindent 4 }}
  {{- end }}
  {{- if .Values.prometheus.podSecurityContext.enabled }}
  securityContext: {{- omit .Values.prometheus.podSecurityContext "enabled" | toYaml | nindent 4 }}
  {{- end }}
  {{- if .Values.prometheus.ruleNamespaceSelector }}
  ruleNamespaceSelector: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.ruleNamespaceSelector "context" $) | nindent 4 }}
  {{- else }}
  ruleNamespaceSelector: {}
  {{- end }}
  {{- if .Values.prometheus.ruleSelector }}
  ruleSelector: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.ruleSelector "context" $) | nindent 4 }}
  {{- else }}
  ruleSelector: {}
  {{- end }}
  {{- if .Values.prometheus.storageSpec }}
  storage: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.storageSpec "context" $) | nindent 4 }}
  {{- else if .Values.prometheus.persistence.enabled }}
  storage:
    volumeClaimTemplate:
      spec:
        accessModes:
          {{- range .Values.prometheus.persistence.accessModes }}
          - {{ . | quote }}
          {{- end }}
        resources:
          requests:
            storage: {{ .Values.prometheus.persistence.size | quote }}
        {{- with (include "tc.v1.common.lib.storage.storageClassName" ( dict "rootCtx" . "objectData" .Values.prometheus.persistence )) | trim }}
        storageClassName: {{ . }}
        {{- end }}
  {{- end }}
  {{- if or .Values.prometheus.podMetadata.labels .Values.prometheus.podMetadata.annotations (eq .Values.prometheus.podAntiAffinityPreset "soft") (eq .Values.prometheus.podAntiAffinityPreset "hard") }}
  podMetadata:
    labels:
    {{- if .Values.prometheus.podMetadata.labels }}
    {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.podMetadata.labels "context" $) | nindent 6 }}
    {{- end }}
    {{- if or (eq .Values.prometheus.podAntiAffinityPreset "soft") (eq .Values.prometheus.podAntiAffinityPreset "hard") }}
    {{- include "kube-prometheus.prometheus.matchLabels" . | nindent 6 }}
    {{- end }}
    {{- if .Values.prometheus.podMetadata.annotations }}
    annotations:
    {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.podMetadata.annotations "context" $) | nindent 6 }}
    {{- end }}
  {{- end }}
  {{- if .Values.prometheus.querySpec }}
  query: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.querySpec "context" $) | nindent 4 }}
  {{- end }}
  {{- if .Values.prometheus.affinity }}
  affinity: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.affinity "context" $) | nindent 4 }}
  {{- end }}
  {{- if .Values.prometheus.nodeSelector }}
  nodeSelector: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.nodeSelector "context" $) | nindent 4 }}
  {{- end }}
  {{- if .Values.prometheus.tolerations }}
  tolerations: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.tolerations "context" $) | nindent 4 }}
  {{- end }}
  {{- if .Values.prometheus.volumes }}
  volumes: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.volumes "context" $) | nindent 4 }}
  {{- end }}
  {{- if .Values.prometheus.volumeMounts }}
  volumeMounts: {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.volumeMounts "context" $) | nindent 4 }}
  {{- end }}
  {{- if or .Values.prometheus.additionalScrapeConfigs.enabled .Values.prometheus.additionalScrapeConfigsExternal.enabled }}
  additionalScrapeConfigs:
    {{- if and .Values.prometheus.additionalScrapeConfigs.enabled (eq .Values.prometheus.additionalScrapeConfigs.type "external") }}
    name: {{ .Values.prometheus.additionalScrapeConfigs.external.name }}
    key: {{ .Values.prometheus.additionalScrapeConfigs.external.key }}
    {{- else if and .Values.prometheus.additionalScrapeConfigs.enabled (eq .Values.prometheus.additionalScrapeConfigs.type "internal") }}
    name: additional-scrape-jobs-{{ template "kube-prometheus.prometheus.fullname" . }}
    key: scrape-jobs.yaml
    {{- else if and (not .Values.prometheus.additionalScrapeConfigs.enabled) .Values.prometheus.additionalScrapeConfigsExternal.enabled }}
    name: {{ .Values.prometheus.additionalScrapeConfigsExternal.name }}
    key: {{ .Values.prometheus.additionalScrapeConfigsExternal.key }}
    {{- end }}
  {{- end }}
  {{- if .Values.prometheus.additionalAlertRelabelConfigsExternal.enabled }}
  additionalAlertRelabelConfigs:
    name: {{ .Values.prometheus.additionalAlertRelabelConfigsExternal.name }}
    key: {{ .Values.prometheus.additionalAlertRelabelConfigsExternal.key }}
  {{- end }}
{{- include "kube-prometheus.imagePullSecrets" . | indent 2 }}
  {{- if or .Values.prometheus.containers .Values.prometheus.thanos.create .Values.prometheus.containerSecurityContext.enabled .Values.prometheus.containerSecurityContext.enabled .Values.operator.prometheusConfigReloader.containerSecurityContext.enabled }}
  containers:
    {{- if .Values.prometheus.thanos.create }}
    - name: thanos-sidecar
      image: {{ template "kube-prometheus.prometheus.thanosImage" . }}
      imagePullPolicy: {{ .Values.prometheus.thanos.image.pullPolicy }}
      args:
        - sidecar
        - --prometheus.url={{ default "http://localhost:9090" .Values.prometheus.thanos.prometheusUrl }}
        - --grpc-address=0.0.0.0:10901
        - --http-address=0.0.0.0:10902
        - --tsdb.path=/prometheus/
        {{- if .Values.prometheus.thanos.objectStorageConfig }}
        - --objstore.config=$(OBJSTORE_CONFIG)
        {{- end }}
        {{- if .Values.prometheus.thanos.extraArgs }}
        {{ toYaml .Values.prometheus.thanos.extraArgs | indent 8  | trim }}
        {{- end }}
      {{- if .Values.prometheus.thanos.objectStorageConfig }}
      env:
        - name: OBJSTORE_CONFIG
          valueFrom:
            secretKeyRef:
              name: {{ .Values.prometheus.thanos.objectStorageConfig.secretName }}
              key: {{ .Values.prometheus.thanos.objectStorageConfig.secretKey | default "thanos.yaml" }}
      {{- end }}
      {{- if .Values.prometheus.thanos.resources }}
      resources: {{- toYaml .Values.prometheus.thanos.resources | nindent 8 }}
      {{- end }}
      ports:
        - name: thanos
          containerPort: 10901
          protocol: TCP
        - name: http
          containerPort: 10902
          protocol: TCP
      volumeMounts:
        - mountPath: /prometheus
          name: prometheus-{{ template "kube-prometheus.prometheus.fullname" . }}-db
          {{- if not (.Values.prometheus.storageSpec.disableMountSubPath | default (not .Values.prometheus.persistence.enabled)) }}
          subPath: prometheus-db
          {{- end }}
        {{- if .Values.prometheus.thanos.extraVolumeMounts }}
        {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.thanos.extraVolumeMounts "context" $) | nindent 8 }}
        {{- end }}
      {{- if .Values.prometheus.thanos.containerSecurityContext.enabled }}
      # yamllint disable rule:indentation
      securityContext: {{- omit .Values.prometheus.thanos.containerSecurityContext "enabled" | toYaml | nindent 8 }}
      # yamllint enable rule:indentation
      {{- end }}
      {{- if .Values.prometheus.thanos.livenessProbe.enabled }}
      livenessProbe:
        httpGet:
          path: {{ .Values.prometheus.thanos.livenessProbe.path }}
          port: http
          scheme: HTTP
        initialDelaySeconds: {{ .Values.prometheus.thanos.livenessProbe.initialDelaySeconds }}
        periodSeconds: {{ .Values.prometheus.thanos.livenessProbe.periodSeconds }}
        timeoutSeconds: {{ .Values.prometheus.thanos.livenessProbe.timeoutSeconds }}
        failureThreshold: {{ .Values.prometheus.thanos.livenessProbe.failureThreshold }}
        successThreshold: {{ .Values.prometheus.thanos.livenessProbe.successThreshold }}
      {{- end }}
      {{- if .Values.prometheus.thanos.readinessProbe.enabled }}
      readinessProbe:
        httpGet:
          path: {{ .Values.prometheus.thanos.readinessProbe.path }}
          port: http
          scheme: HTTP
        initialDelaySeconds: {{ .Values.prometheus.thanos.readinessProbe.initialDelaySeconds }}
        periodSeconds: {{ .Values.prometheus.thanos.readinessProbe.periodSeconds }}
        timeoutSeconds: {{ .Values.prometheus.thanos.readinessProbe.timeoutSeconds }}
        failureThreshold: {{ .Values.prometheus.thanos.readinessProbe.failureThreshold }}
        successThreshold: {{ .Values.prometheus.thanos.readinessProbe.successThreshold }}
      {{- end }}
    {{- end }}
    {{- if or .Values.prometheus.containerSecurityContext.enabled .Values.prometheus.livenessProbe.enabled .Values.prometheus.readinessProbe.enabled }}
    ## This monkey patching is needed until the securityContexts are
    ## directly patchable via the CRD.
    ## ref: https://github.com/prometheus-operator/prometheus-operator/issues/3947
    ## currently implemented with strategic merge
    ## ref: https://github.com/prometheus-operator/prometheus-operator/blob/master/Documentation/user-guides/strategic-merge-patch.md
    - name: prometheus
      {{- if .Values.prometheus.containerSecurityContext.enabled }}
      securityContext: {{- omit .Values.prometheus.containerSecurityContext "enabled" | toYaml | nindent 8 }}
      {{- end }}
      {{- if .Values.prometheus.livenessProbe.enabled }}
      livenessProbe:
        httpGet:
          path: {{ .Values.prometheus.livenessProbe.path }}
          port: main
          scheme: HTTP
        initialDelaySeconds: {{ .Values.prometheus.livenessProbe.initialDelaySeconds }}
        periodSeconds: {{ .Values.prometheus.livenessProbe.periodSeconds }}
        timeoutSeconds: {{ .Values.prometheus.livenessProbe.timeoutSeconds }}
        failureThreshold: {{ .Values.prometheus.livenessProbe.failureThreshold }}
        successThreshold: {{ .Values.prometheus.livenessProbe.successThreshold }}
      {{- end }}
      {{- if .Values.prometheus.readinessProbe.enabled }}
      readinessProbe:
        httpGet:
          path: {{ .Values.prometheus.readinessProbe.path }}
          port: main
          scheme: HTTP
        initialDelaySeconds: {{ .Values.prometheus.readinessProbe.initialDelaySeconds }}
        periodSeconds: {{ .Values.prometheus.readinessProbe.periodSeconds }}
        timeoutSeconds: {{ .Values.prometheus.readinessProbe.timeoutSeconds }}
        failureThreshold: {{ .Values.prometheus.readinessProbe.failureThreshold }}
        successThreshold: {{ .Values.prometheus.readinessProbe.successThreshold }}
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
    {{- if .Values.prometheus.containers }}
    {{- include "tc.v1.common.tplvalues.render" (dict "value" .Values.prometheus.containers "context" $) | nindent 4 }}
    {{- end }}
  {{- end }}
  {{- if .Values.prometheus.priorityClassName }}
  priorityClassName: {{ .Values.prometheus.priorityClassName }}
  {{- end }}
{{- end }}
{{- end }}
