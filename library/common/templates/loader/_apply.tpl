{{/* Loads all spawners */}}
{{- define "tc.v1.common.loader.apply" -}}

  {{/* Inject custom tpl files, as defined in values.yaml */}}
  {{- include "tc.v1.common.spawner.extraTpl" . | nindent 0 -}}

  {{/* Ensure automatic permissions containers are injected */}}
  {{- include "tc.v1.common.lib.util.autoperms.job" $ -}}

  {{/* Make sure there are not any YAML errors */}}
  {{- include "tc.v1.common.values.validate" .Values -}}

  {{/* Render ConfigMap(s) */}}
  {{- include "tc.v1.common.spawner.configmap" . | nindent 0 -}}

  {{/* Render priorityclass(s) */}}
  {{- include "tc.v1.common.spawner.priorityclass" . | nindent 0 -}}

  {{/* Render Secret(s) */}}
  {{- include "tc.v1.common.spawner.secret" . | nindent 0 -}}

  {{/* Render Image Pull Secrets(s) */}}
  {{- include "tc.v1.common.spawner.imagePullSecret" . | nindent 0 -}}

  {{/* Render Service Accounts(s) */}}
  {{- include "tc.v1.common.spawner.serviceAccount" . | nindent 0 -}}

  {{/* Render RBAC(s) */}}
  {{- include "tc.v1.common.spawner.rbac" . | nindent 0 -}}

  {{/* Render External Interface(s) */}}
  {{- include "tc.v1.common.spawner.externalInterface" . | nindent 0 -}}

  {{/* Render Workload(s) */}}
  {{- include "tc.v1.common.spawner.workload" . | nindent 0 -}}

  {{/* Render Services(s) */}}
  {{- include "tc.v1.common.spawner.service" . | nindent 0 -}}

  {{/* Render storageClass(s) */}}
  {{- include "tc.v1.common.spawner.storageclass" . | nindent 0 -}}

  {{/* Render PVC(s) */}}
  {{- include "tc.v1.common.spawner.pvc" . | nindent 0 -}}

  {{/* Render volumeSnapshot(s) */}}
  {{- include "tc.v1.common.spawner.volumesnapshot" . | nindent 0 -}}

  {{/* Render volumeSnapshotClass(s) */}}
  {{- include "tc.v1.common.spawner.volumesnapshotclass" . | nindent 0 -}}

  {{/* Render ingress(s) */}}
  {{- include "tc.v1.common.spawner.ingress" . | nindent 0 -}}

  {{/* Render Gateway API Route(s) */}}
  {{- include "tc.v1.common.spawner.routes" . | nindent 0 -}}

  {{/* Render Horizontal Pod Autoscalers(s) */}}
  {{- include "tc.v1.common.spawner.hpa" . | nindent 0 -}}

  {{/* Render Networkpolicy(s) */}}
  {{- include "tc.v1.common.spawner.networkpolicy" . | nindent 0 -}}

  {{/* Render podDisruptionBudget(s) */}}
  {{- include "tc.v1.common.spawner.podDisruptionBudget" . | nindent 0 -}}

  {{/* Render webhook(s) */}}
  {{- include "tc.v1.common.spawner.webhook" . | nindent 0 -}}

  {{/* Render Prometheus Metrics(s) */}}
  {{- include "tc.v1.common.spawner.metrics" . | nindent 0 -}}

  {{/* Render Cert-Manager Certificates(s) */}}
  {{- include "tc.v1.common.spawner.certificate" . | nindent 0 -}}

  {{/* Render/Set portal configmap, .Values.iXPortals and APPURL */}}
  {{- include "tc.v1.common.spawner.portal" . | nindent 0 -}}

{{- end -}}
