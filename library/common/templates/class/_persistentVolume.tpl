{{/* PersistentVolume Class */}}
{{/* Call this template:
{{ include "tc.v1.common.class.pv" (dict "rootCtx" $ "objectData" $objectData) }}

rootCtx: The root context of the chart.
objectData:
  name: The name of the PV.
  labels: The labels of the PV.
  annotations: The annotations of the PV.
  provisioner: The provisioner to use for the PersistentVolume.
  driver: The driver to use for the csi
  retain: Whether to retain the PV after deletion. (Default: false)
  size: The size of the PersistentVolume. (Default: 1Gi)
*/}}

{{- define "tc.v1.common.class.pv" -}}

  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $retain := $rootCtx.Values.global.fallbackDefaults.pvcRetain -}}
  {{- if not (kindIs "invalid" $objectData.retain) -}}
    {{- $retain = $objectData.retain -}}
  {{- end -}}

  {{- $reclaimPolicy := ternary "Retain" "Delete" $retain -}}

  {{- $pvcSize := $rootCtx.Values.global.fallbackDefaults.pvcSize -}}
  {{- with $objectData.size -}}
    {{- $pvcSize = tpl . $rootCtx -}}
  {{- end }}
---
apiVersion: v1
kind: PersistentVolume
metadata:
  name: {{ $objectData.name }}
  {{- $labels := (mustMerge ($objectData.labels | default dict) (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end -}}
  {{- $annotations := (mustMerge ($objectData.annotations | default dict) (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml)) -}}
  {{- if $retain -}}
    {{- $_ := set $annotations "\"helm.sh/resource-policy\"" "keep" -}}
  {{- end -}}
  {{- $_ := set $annotations "pv.kubernetes.io/provisioned-by" $objectData.provisioner -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  capacity:
    storage: {{ $pvcSize }}
  persistentVolumeReclaimPolicy: {{ $reclaimPolicy }}
  storageClassName: {{ $objectData.name }}
  accessModes:
    {{- include "tc.v1.common.lib.pvc.accessModes" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "Persistent Volume") | trim | nindent 4 -}}
  {{- if $objectData.mountOptions }}
  mountOptions:
    {{- range $opt := $objectData.mountOptions -}}
      {{- if $opt.value }}
    - {{ printf "%s=%s" (tpl $opt.key $rootCtx) (tpl (include "tc.v1.common.helper.makeIntOrNoop" $opt.value) $rootCtx) }}
      {{- else }}
    - {{ tpl $opt.key $rootCtx }}
      {{- end -}}
    {{- end -}}
  {{- end -}}
  {{- if $objectData.static -}}
    {{- if eq "smb" $objectData.static.mode -}}
      {{- include "tc.v1.common.lib.storage.smbCSI" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 2 -}}
    {{- else if eq "nfs" $objectData.static.mode -}}
      {{- include "tc.v1.common.lib.storage.nfsCSI" (dict "rootCtx" $rootCtx "objectData" $objectData) | trim | nindent 2 -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
