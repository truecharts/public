{{/* PVC Spawwner */}}
{{/* Call this template:
{{ include "tc.v1.common.spawner.pvc" $ -}}
*/}}

{{- define "tc.v1.common.spawner.pvc" -}}

  {{- range $name, $persistence := .Values.persistence -}}

    {{- $enabled := (include "tc.v1.common.lib.util.enabled" (dict
                    "rootCtx" $ "objectData" $persistence
                    "name" $name "caller" "Persistence"
                    "key" "persistence")) -}}

    {{- if eq $enabled "true" -}}

      {{/* Create a copy of the persistence */}}
      {{- $objectData := (mustDeepCopy $persistence) -}}

      {{- $_ := set $objectData "type" ($objectData.type | default $.Values.global.fallbackDefaults.persistenceType) -}}

      {{- include "tc.v1.common.lib.util.metaListToDict" (dict "objectData" $objectData) -}}

      {{/* Perform general validations */}}
      {{- include "tc.v1.common.lib.persistence.validation" (dict "rootCtx" $ "objectData" $objectData) -}}
      {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "Persistence") -}}

      {{/* Only spawn PVC if its enabled and any type of "pvc" */}}
      {{- $types := (list "pvc") -}}
      {{- if and (mustHas $objectData.type $types) (not $objectData.existingClaim) -}}

        {{/* Set the name of the PVC */}}
        {{- $_ := set $objectData "name" (include "tc.v1.common.lib.storage.pvc.name" (dict "rootCtx" $ "objectName" $name "objectData" $objectData)) -}}
        {{- $_ := set $objectData "shortName" $name -}}

        {{- if and $objectData.static $objectData.static.mode (ne $objectData.static.mode "disabled") -}}
          {{- $_ := set $objectData "storageClass" ($objectData.storageClass | default $objectData.name) -}}
          {{- $_ := set $objectData "volumeName" $objectData.name -}}

          {{- if eq $objectData.static.mode "smb" -}}
            {{/* Validate SMB CSI */}}
            {{- include "tc.v1.common.lib.storage.smbCSI.validation" (dict "rootCtx" $ "objectData" $objectData) -}}

            {{- $_ := set $objectData "provisioner" "smb.csi.k8s.io" -}}
            {{- $_ := set $objectData.static "driver" "smb.csi.k8s.io" -}}

            {{/* Create secret with creds */}}
            {{- $secretData := (dict
                                  "name" $objectData.name
                                  "labels" ($objectData.labels | default dict)
                                  "annotations" ($objectData.annotations | default dict)
                                  "data" (dict "username" $objectData.static.username "password" $objectData.static.password)
                                ) -}}
            {{- with $objectData.domain -}}
              {{- $_ := set $secretData.data "domain" . -}}
            {{- end -}}
            {{- include "tc.v1.common.class.secret" (dict "rootCtx" $ "objectData" $secretData) -}}

          {{- else if eq $objectData.static.mode "nfs" -}}
            {{/* Validate NFS CSI */}}
            {{- include "tc.v1.common.lib.storage.nfsCSI.validation" (dict "rootCtx" $ "objectData" $objectData) -}}

            {{- $_ := set $objectData "provisioner" "nfs.csi.k8s.io" -}}
            {{- $_ := set $objectData.static "driver" "nfs.csi.k8s.io" -}}

          {{- else if eq $objectData.static.mode "custom" -}}

            {{- $_ := set $objectData "provisioner" $objectData.static.provisioner -}}
            {{- $_ := set $objectData.static "driver" $objectData.static.driver -}}

          {{- end -}}

          {{/* Create the PV */}}
          {{- include "tc.v1.common.class.pv" (dict "rootCtx" $ "objectData" $objectData) -}}

        {{- else if $objectData.volumeName -}}

          {{- $_ := set $objectData "storageClass" ($objectData.storageClass | default $objectData.name) -}}

        {{- end -}}

        {{/* Call class to create the object */}}
        {{- include "tc.v1.common.class.pvc" (dict "rootCtx" $ "objectData" $objectData) -}}

        {{/* Create VolumeSnapshots */}}
        {{- range $volSnap := $objectData.volumeSnapshots -}}

          {{/* Create a copy of the volumesnapshot */}}
          {{- $volSnapData := (mustDeepCopy $volSnap) -}}
          {{/* PVC FullName - Snapshot Name*/}}
          {{- $snapshotName := printf "%s-%s" $objectData.name $volSnap.name -}}

          {{/* Perform validations */}} {{/* volumesnapshots have a max name length of 253 */}}
          {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $snapshotName "length" 253) -}}
          {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $volSnapData "caller" "PVC - Volume Snapshot") -}}

          {{/* Set the name of the volumesnapshot */}}
          {{- $_ := set $volSnapData "name" $snapshotName -}}
          {{- $_ := set $volSnapData "shortName" $volSnap.name -}}
          {{- $_ := set $volSnapData "source" (dict "persistentVolumeClaimName" $objectData.name) -}}

          {{- include "tc.v1.common.lib.volumesnapshot.validation" (dict "objectData" $volSnapData) -}}

          {{/* Call class to create the object */}}
          {{- include "tc.v1.common.class.volumesnapshot" (dict "rootCtx" $ "objectData" $volSnapData) -}}
        {{- end -}}
      {{- end -}}

      {{- if eq $objectData.type "iscsi" -}}
        {{- if or $objectData.iscsi.authSession $objectData.iscsi.authDiscovery -}}
          {{/* Set the name of the PVC */}}
          {{- $_ := set $objectData "name" (include "tc.v1.common.lib.storage.pvc.name" (dict "rootCtx" $ "objectName" $name "objectData" $objectData)) -}}
          {{- $_ := set $objectData "shortName" $name -}}

          {{- $secretData := (dict
                                "name" $objectData.name
                                "labels" ($objectData.labels | default dict)
                                "annotations" ($objectData.annotations | default dict)
                                "type" "kubernetes.io/iscsi-chap"
                                "data" (include "tc.v1.common.lib.storage.iscsi.chap" (dict "rootCtx" $ "objectData" $objectData) | fromJson)
                              ) -}}
          {{- include "tc.v1.common.class.secret" (dict "rootCtx" $ "objectData" $secretData) -}}
        {{- end -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}
