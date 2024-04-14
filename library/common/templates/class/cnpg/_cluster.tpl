{{- define "tc.v1.common.class.cnpg.cluster" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- $fullname := include "tc.v1.common.lib.chart.names.fullname" $rootCtx -}}
  {{- include "tc.v1.common.lib.chart.names.validation" (dict "name" $objectData.clusterName "length" 253) -}}
  {{- include "tc.v1.common.lib.metadata.validation" (dict "objectData" $objectData "caller" "CNPG Cluster") -}}

  {{/* Initialize variables */}}
  {{- $hibernation := "off" -}}
  {{- $instances := 2 -}}
  {{- $mode := "standalone" -}}
  {{- $enableMonitoring := false -}}
  {{- $disableDefaultQueries := false -}}
  {{- $customQueries := list -}}
  {{- $enableSuperUser := true -}}
  {{- $inProgress := false -}}
  {{- $reusePVC := true -}}
  {{- $preloadLibraries := list -}}
  {{- $walSize := $rootCtx.Values.global.fallbackDefaults.vctSize -}}
  {{- $size := $rootCtx.Values.global.fallbackDefaults.vctSize -}}
  {{- $primaryUpdateStrategy := "unsupervised" -}}
  {{- $primaryUpdateMethod := "switchover" -}}
  {{- $logLevel := "info" -}}
  {{- $accessModes := $rootCtx.Values.global.fallbackDefaults.vctAccessModes -}}
  {{- $walAccessModes := $rootCtx.Values.global.fallbackDefaults.vctAccessModes -}}

  {{/* Make sure keys exist before try to access any sub keys */}}
  {{- if not (hasKey $objectData "cluster") -}}
    {{- $_ := set $objectData "cluster" dict -}}
  {{- end -}}
  {{- if not (hasKey $objectData "monitoring") -}}
    {{- $_ := set $objectData "monitoring" dict -}}
  {{- end -}}
  {{- if not (hasKey $objectData "backups") -}}
    {{- $_ := set $objectData "backups" dict -}}
  {{- end -}}
  {{- if not (hasKey $objectData.cluster "storage") -}}
    {{- $_ := set $objectData.cluster "storage" dict -}}
  {{- end -}}
  {{- if not (hasKey $objectData.cluster "walStorage") -}}
    {{- $_ := set $objectData.cluster "walStorage" dict -}}
  {{- end -}}
  {{- if not (hasKey $objectData.cluster "resources") -}}
    {{- $_ := set $objectData.cluster "resources" dict -}}
  {{- end -}}
  {{/* Exclude extra resources */}}
  {{- $_ := set $objectData.cluster.resources "excludeExtra" true -}}

  {{/* Metadata */}}
  {{- $objLabels := $objectData.labels | default dict -}}
  {{- $clusterLabels := $objectData.cluster.labels | default dict -}}
  {{- $clusterLabels = mustMerge $clusterLabels $objLabels -}}

  {{- $objAnnotations := $objectData.annotations | default dict -}}
  {{- $clusterAnnotations := $objectData.cluster.annotations | default dict -}}
  {{- $clusterAnnotations = mustMerge $clusterAnnotations $objAnnotations -}}

  {{- with $objectData.cluster.instances -}}
    {{- $instances = . -}}
  {{- end -}}

  {{/* Stop All */}}
  {{- if or $objectData.hibernate (include "tc.v1.common.lib.util.stopAll" $rootCtx) -}}
    {{- $hibernation = "on" -}}
  {{- end -}}

  {{/* General */}}
  {{- with $objectData.mode -}}
    {{- $mode = . -}}
  {{- end -}}

  {{- with $objectData.cluster.primaryUpdateStrategy -}}
    {{- $primaryUpdateStrategy = . -}}
  {{- end -}}
  {{- with $objectData.cluster.primaryUpdateMethod -}}
    {{- $primaryUpdateMethod = . -}}
  {{- end -}}
  {{- with $objectData.cluster.logLevel -}}
    {{- $logLevel = . -}}
  {{- end -}}

  {{/* Monitoring */}}
  {{- with $objectData.monitoring -}}
    {{- if (kindIs "bool" .enablePodMonitor) -}}
      {{- $enableMonitoring = .enablePodMonitor -}}
    {{- end -}}
    {{- if (kindIs "bool" .disableDefaultQueries) -}}
      {{- $disableDefaultQueries = .disableDefaultQueries -}}
    {{- end -}}
    {{- with .customQueries -}}
      {{- $customQueries = . -}}
    {{- end -}}
  {{- end -}}

  {{/* Superuser */}}
  {{- if (kindIs "bool" $objectData.cluster.enableSuperuserAccess) -}}
    {{- $enableSuperUser = $objectData.cluster.enableSuperuserAccess -}}
  {{- end -}}

  {{/* Node Maintenance Window */}}
  {{- if or $rootCtx.Values.global.ixChartContext $objectData.cluster.singleNode -}}
    {{- $inProgress = true -}}
  {{- end -}}

  {{- with $objectData.cluster.nodeMaintenanceWindow -}}
    {{- if (kindIs "bool" .inProgress) -}}
      {{ $inProgress = .inProgress -}}
    {{- end -}}
    {{- if (kindIs "bool" .reusePVC) -}}
      {{ $reusePVC = .reusePVC -}}
    {{- end -}}
  {{- end -}}

  {{/* Preload Libraries */}}
  {{- if (kindIs "slice" $objectData.cluster.preloadLibraries) -}}
    {{- $preloadLibraries = $objectData.cluster.preloadLibraries -}}
  {{- end -}}
  {{- if eq $objectData.type "timescaledb" -}}
    {{- $preloadLibraries = mustAppend $preloadLibraries "timescaledb" -}}
  {{- end -}}
  {{- if eq $objectData.type "vectors" -}}
    {{- $preloadLibraries = mustAppend $preloadLibraries "vectors.so" -}}
  {{- end -}}

  {{/* Storage */}}
  {{- with $objectData.cluster.storage.size -}}
    {{- $size = . -}}
  {{- end -}}

  {{- with $objectData.cluster.walStorage.size -}}
    {{- $walSize = . -}}
  {{- end -}}

  {{- with $objectData.cluster.storage.accessModes -}}
    {{- $accessModes = . -}}
  {{- end -}}

  {{- with $objectData.cluster.walStorage.accessModes -}}
    {{- $walAccessModes = . -}}
  {{- end -}}

  {{- $imageName := $objectData.cluster.imageName -}}
  {{- if not $imageName -}}
    {{/* Ensure version and container tracking */}}
    {{- $imageType := camelcase ($objectData.type | default "postgres") -}}
    {{- if eq $imageType "Postgres" -}}
      {{- $imageType = "" -}}
    {{- end -}}

    {{/* Format is [postgresCustomNameVersionImage] */}}
    {{- $imageKey := printf "postgres%s%sImage" $imageType $objectData.pgVersion -}}
    {{- $imageValue := fromJson (include "tc.v1.common.lib.container.imageSelector" (dict "rootCtx" $rootCtx "objectData" (dict "imageSelector" $imageKey))) -}}
    {{- $formatImage := printf "%s:%s" $imageValue.repository $imageValue.tag -}}

    {{- $imageName = $formatImage -}}
  {{- end }}

---
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: {{ $objectData.clusterName }}
  namespace: {{ include "tc.v1.common.lib.metadata.namespace" (dict "rootCtx" $rootCtx "objectData" $objectData "caller" "CNPG Cluster") }}
  labels:
    cnpg.io/reload: "on"
  {{- $labels := (mustMerge $clusterLabels (include "tc.v1.common.lib.metadata.allLabels" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "labels" $labels) | trim) }}
    {{- . | nindent 4 }}
  {{- end }}
  annotations:
    cnpg.io/hibernation: {{ $hibernation | quote }}
    checksum/secrets: {{ toJson $rootCtx.Values.secret | sha256sum }}
  {{- $annotations := (mustMerge $clusterAnnotations (include "tc.v1.common.lib.metadata.allAnnotations" $rootCtx | fromYaml)) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $rootCtx "annotations" $annotations) | trim) }}
    {{- . | nindent 4 }}
  {{- end }}
spec:
  imageName: {{ $imageName }}
  enableSuperuserAccess: {{ $enableSuperUser }}
  primaryUpdateStrategy: {{ $primaryUpdateStrategy }}
  primaryUpdateMethod: {{ $primaryUpdateMethod }}
  logLevel: {{ $logLevel }}
  instances: {{ $instances }}
  {{- if or $objectData.cluster.postgresql $preloadLibraries }}
  postgresql:
    {{- with $objectData.cluster.postgresql }}
    parameters:
      {{- range $k, $v := . }}
      {{ $k }}: {{ tpl $v $rootCtx | quote }}
      {{- end -}}
    {{- end -}}
    {{- with $preloadLibraries }}
    shared_preload_libraries:
      {{- range $lib := (. | mustUniq) }}
      - {{ $lib | quote }}
      {{- end -}}
    {{- end -}}
  {{- end }}
  nodeMaintenanceWindow:
    inProgress: {{ $inProgress }}
    reusePVC: {{ $reusePVC }}
  {{- with (include "tc.v1.common.lib.container.resources" (dict "rootCtx" $rootCtx "objectData" $objectData.cluster) | trim) }}
  resources:
    {{- . | nindent 4 }}
  {{- end }}
  storage:
    pvcTemplate:
      {{- $_ := set $objectData.cluster.storage "size" $size -}}
      {{- $_ := set $objectData.cluster.storage "accessModes" $accessModes -}}

      {{- include "tc.v1.common.lib.storage.pvc.spec" (dict "rootCtx" $rootCtx "objectData" $objectData.cluster.storage) | trim | nindent 6 }}
  walStorage:
    pvcTemplate:
      {{- $_ := set $objectData.cluster.walStorage "size" $walSize -}}
      {{- $_ := set $objectData.cluster.walStorage "accessModes" $walAccessModes -}}

      {{- include "tc.v1.common.lib.storage.pvc.spec" (dict "rootCtx" $rootCtx "objectData" $objectData.cluster.walStorage) | trim | nindent 6 }}
  {{- if $enableMonitoring }}
  monitoring:
    enablePodMonitor: {{ $enableMonitoring }}
    disableDefaultQueries: {{ $disableDefaultQueries }}
    {{- if $customQueries }}
    customQueriesConfigMap:
      {{- range $q := $customQueries }}
        {{- $name := $q.name -}}
        {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
                        "rootCtx" $rootCtx "objectData" $q
                        "name" $q.name "caller" "CNPG Cluster"
                        "key" "monitoring.customQueries")) -}}

        {{- if eq $expandName "true" -}}
          {{- $name = (printf "%s-cnpg-%s-%s" $fullname $objectData.shortName $q.name) -}}
        {{- end }}
      - name: {{ $name }}
        key: {{ $q.key | default "custom-queries" }}
      {{- end -}}
    {{- end -}}
  {{- end }}
  bootstrap:
  {{- if eq $mode "standalone" -}}
    {{- include "tc.v1.common.lib.cnpg.cluster.bootstrap.standalone" (dict "rootCtx" $rootCtx "objectData" $objectData) | nindent 4 -}}
  {{- else if eq $mode "recovery" -}}
    {{- include "tc.v1.common.lib.cnpg.cluster.bootstrap.recovery" (dict "objectData" $objectData) | nindent 4 -}}
    {{- include "tc.v1.common.lib.cnpg.cluster.bootstrap.recovery.externalCluster" (dict "rootCtx" $rootCtx "objectData" $objectData) | nindent 2 -}}
  {{- end -}}
  {{- if $objectData.backups.enabled }}
    {{- include "tc.v1.common.lib.cnpg.cluster.backup" (dict "rootCtx" $rootCtx "objectData" $objectData) | nindent 2 -}}
  {{- end -}}
{{- end -}}
