{{- define "tc.v1.common.class.cnpg.cluster" -}}
  {{- $values := .Values.cnpg -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.cnpg -}}
      {{- $values = . -}}
    {{- end -}}
  {{- end -}}
  {{- $cnpgClusterName := $values.name -}}
  {{- $cnpgClusterLabels := $values.labels -}}
  {{- $cnpgClusterAnnotations := $values.annotations -}}
  {{- $hibernation := "off" -}}
  {{- if or $values.hibernate $.Values.global.stopAll -}}
    {{- $hibernation = "on" -}}
  {{- end }}
---
apiVersion: {{ include "tc.v1.common.capabilities.cnpg.cluster.apiVersion" $ }}
kind: Cluster
metadata:
  name: {{ $cnpgClusterName }}
  {{- $labels := (mustMerge ($cnpgClusterLabels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $ | fromYaml)) }}
  labels:
    cnpg.io/reload: "on"
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "labels" $labels) | trim) }}
    {{- . | nindent 4 }}
  {{- end }}
  {{- $annotations := (mustMerge ($cnpgClusterAnnotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $ | fromYaml)) }}
  annotations:
    cnpg.io/hibernation: {{ $hibernation | quote }}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "annotations" $annotations) | trim) }}
    {{- . | nindent 4 }}
  {{- end }}
spec:
  instances: {{ $values.instances | default 2 }}

  bootstrap:
    initdb:
      database: {{ $values.database | default "app" }}
      owner: {{ $values.user | default "app" }}
      secret:
        name: {{ $cnpgClusterName }}-user

  primaryUpdateStrategy: {{ $values.primaryUpdateStrategy | default "unsupervised" }}

  storage:
    pvcTemplate:
      {{- with (include "tc.v1.common.lib.storage.storageClassName" ( dict "rootCtx" $ "objectData" $values.storage )) | trim }}
      storageClassName: {{ . }}
      {{- end }}
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: {{ tpl ($values.storage.walsize | default $.Values.fallbackDefaults.vctSize) $ | quote }}

  walStorage:
    pvcTemplate:
      {{- with (include "tc.v1.common.lib.storage.storageClassName" ( dict "rootCtx" $ "objectData" $values.storage )) | trim }}
      storageClassName: {{ . }}
      {{- end }}
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: {{ tpl ($values.storage.walsize | default $.Values.fallbackDefaults.vctSize) $ | quote }}

  monitoring:
    enablePodMonitor: {{ $values.monitoring.enablePodMonitor | default true }}

  nodeMaintenanceWindow:
    inProgress: false
    reusePVC: true

  {{- with (include "tc.v1.common.lib.container.resources" (dict "rootCtx" $ "objectData" $values) | trim) }}
  resources:
    {{- . | nindent 4 }}
  {{- end }}

  postgresql:
    {{- tpl ( $values.postgresql | toYaml ) $ | nindent 4 }}

{{- end -}}
