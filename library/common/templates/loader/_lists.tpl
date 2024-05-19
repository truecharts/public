{{- define "tc.v1.common.loader.lists" -}}

  {{- include "tc.v1.common.values.imagePullSecretList" . -}}

  {{- include "tc.v1.common.values.credentialsList" . -}}

  {{- include "tc.v1.common.values.persistenceList" . -}}

  {{- include "tc.v1.common.values.volumeSnapshotList" . -}}

  {{- include "tc.v1.common.values.volumeSnapshotClassList" . -}}

  {{- include "tc.v1.common.values.deviceList" . -}}

  {{- include "tc.v1.common.values.serviceList" . -}}

  {{- include "tc.v1.common.values.ingressList" . -}}

{{- end -}}
