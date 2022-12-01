{{/* Template for pvc object, can only be called by the spawner */}}
{{/* An "pvc" object and "root" is passed from the spawner */}}
{{- define "ix.v1.common.class.pvc" -}}
  {{- $pvcValues := .pvc -}}
  {{- $root := .root -}}
  {{- $defaultSize := $root.Values.global.ixChartContext.defaultPVCSize -}}

  {{- $pvcName := include "ix.v1.common.names.fullname" $root -}}

  {{- if and (hasKey $pvcValues "nameOverride") $pvcValues.nameOverride -}}
    {{- if not (eq $pvcValues.nameOverride "-") -}}
      {{- $pvcName = printf "%v-%v" $pvcName $pvcValues.nameOverride -}}
    {{- end -}}
  {{- end -}}

  {{- with $pvcValues.forceName -}}
    {{- $pvcName = tpl . $root -}}
  {{- end -}}

  {{- $accessMode := (tpl (default "ReadWriteOnce" $pvcValues.accessMode) $root) | quote -}}
  {{- $size := (tpl (default $defaultSize $pvcValues.size) $root) | quote }}

---
apiVersion: {{ include "ix.v1.common.capabilities.pvc.apiVersion" $root }}
kind: PersistentVolumeClaim
metadata:
  name: {{ $pvcName }}
  {{- $labels := (mustMerge ($pvcValues.labels | default dict) (include "ix.v1.common.labels" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $root "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end }}
  {{- $annotations := (mustMerge ($pvcValues.annotations | default dict) (include "ix.v1.common.annotations" $root | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $root "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  accessModes:
    - {{ $accessMode }}
  resources:
    requests:
      storage: {{ $size }}
  {{- with $pvcValues.volumeName }}
  volumeName: {{ . | quote }}
  {{- end -}}
  {{/*
  If no storageClassName is defined, either in global or in the persistence object,
  do not define storageClassName, which means use the default storageClass of the node
  */}}
  {{- with (include "ix.v1.common.storage.storageClassName" (dict "persistence" $pvcValues "root" $root)) | trim }}
  storageClassName: {{ . }}
  {{- end -}}
  {{/* Pass custom spec if defined */}}
  {{- with $pvcValues.spec }}
    {{- tpl (toYaml .) $root | nindent 2 }}
  {{- end -}}
{{- end -}}
