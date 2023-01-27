{{- define "tc.v1.common.class.cnpg.cluster" -}}
  {{- $values := .Values.cnpg -}}

  {{- if hasKey . "ObjectValues" -}}
    {{- with .ObjectValues.cnpg -}}
      {{- $values = . -}}
    {{- end -}}
  {{- end -}}
  {{- $cnpgClusterName := $values.name -}}
  {{- $cnpgClusterLabels := $values.labels -}}
  {{- $cnpgClusterAnnotations := $values.annotations }}

---
apiVersion: {{ include "tc.v1.common.capabilities.cnpg.cluster.apiVersion" $ }}
kind: Cluster
metadata:
  name: {{ $cnpgClusterName }}
  {{- $labels := (mustMerge ($cnpgClusterLabels | default dict) (include "ix.v1.common.labels" $ | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.labels.render" (dict "root" $ "labels" $labels) | trim) }}
  labels:
    {{- . | nindent 4 }}
  {{- end }}
  {{- $annotations := (mustMerge ($cnpgClusterAnnotations | default dict) (include "ix.v1.common.annotations" $ | fromYaml)) -}}
  {{- with (include "ix.v1.common.util.annotations.render" (dict "root" $ "annotations" $annotations) | trim) }}
  annotations:
    {{- . | nindent 4 }}
  {{- end }}
spec:
  instances: {{ $values.instances | default 2  }}

  superuserSecret:
    name: {{ $cnpgClusterName }}-cnpg-superuser

  bootstrap:
    initdb:
      database: {{ $values.database | default "app" }}
      owner: {{ $values.user | default "app" }}
      secret:
        name: {{ $cnpgClusterName }}-cnpg-user

  primaryUpdateStrategy: {{ $values.primaryUpdateStrategy | default "unsupervised" }}

  storage:
    pvcTemplate:
      {{- with (include "ix.v1.common.storage.storageClassName" (dict "persistence" $values.storage "root" . )) | trim }}
      storageClassName: {{ . }}
      {{- end }}
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: {{ tpl ($values.storage.walsize | default $.Values.global.defaults.VCTSize) $ | quote }}

  walStorage:
    pvcTemplate:
      {{- with (include "ix.v1.common.storage.storageClassName" (dict "persistence" $values.storage "root" $ )) | trim }}
      storageClassName: {{ . }}
      {{- end }}
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: {{ tpl ($values.storage.walsize | default $.Values.global.defaults.VCTSize) $ | quote }}

  monitoring:
    enablePodMonitor: {{ $values.monitoring.enablePodMonitor | default true }}

  nodeMaintenanceWindow:
    inProgress: false
    reusePVC: on

---
apiVersion: v1
kind: Secret
metadata:
  name: {{ $cnpgClusterName }}-cnpgcreds
{{- $dbprevious := lookup "v1" "Secret" .Release.Namespace "cnpgcreds" }}
{{- $dbPass := "" }}
{{- $pgPass := "" }}
data:
{{- if $dbprevious }}
  {{- $dbPass = ( index $dbprevious.data "user-password" ) | b64dec  }}
  {{- $pgPass = ( index $dbprevious.data "superuser-password" ) | b64dec  }}
  user-password: {{ ( index $dbprevious.data "user-password" ) }}
  superuser-password: {{ ( index $dbprevious.data "superuser-password" ) }}
{{- else }}
  {{- $dbPass = $values.password | default ( randAlphaNum 62 ) }}
  {{- $pgPass = $values.superUserPassword | default ( randAlphaNum 62 ) }}
  user-password: {{ $dbPass | b64enc | quote }}
  superuser-password: {{ $pgPass | b64enc | quote }}
{{- end }}
  {{- $std := ( ( printf "postgresql://%v:%v@%v-rw:5432/%v" $values.user $dbPass $cnpgClusterName $values.database  ) | b64enc | quote ) }}
  {{- $nossl := ( ( printf "postgresql://%v:%v@%v-rw:5432/%v?sslmode=disable" $values.user $dbPass $cnpgClusterName $values.database  ) | b64enc | quote ) }}
  {{- $porthost := ( ( printf "%s-rw:5432" $cnpgClusterName ) | b64enc | quote ) }}
  {{- $host := ( ( printf "%s-rw" $cnpgClusterName ) | b64enc | quote ) }}
  {{- $jdbc := ( ( printf "jdbc:postgresql://%v-rw:5432/%v" $cnpgClusterName $values.database  ) | b64enc | quote ) }}

  std: {{ $std }}
  nossl: {{ $nossl }}
  porthost: {{ $porthost }}
  host: {{ $host }}
  jdbc: {{ $jdbc }}
type: Opaque
{{- $_ := set $values.creds "password" ( $dbPass | quote ) }}
{{- $_ := set $values.creds "superUserPassword" ( $pgPass | quote ) }}
{{- $_ := set $values.creds "std" $std }}
{{- $_ := set $values.creds "nossl" $nossl }}
{{- $_ := set $values.creds "porthost" $porthost }}
{{- $_ := set $values.creds "host" $host }}
{{- $_ := set $values.creds "jdbc" $jdbc }}
---
apiVersion: v1
data:
  username: {{ "postgres" | b64enc | quote  }}
  password: {{ $pgPass | b64enc | quote }}
kind: Secret
metadata:
  name: {{ $cnpgClusterName }}-cnpg-superuser
type: kubernetes.io/basic-auth
---
apiVersion: v1
data:
  username: {{ $values.user | b64enc | quote }}
  password: {{ $dbPass | b64enc | quote }}
kind: Secret
metadata:
  name: {{ $cnpgClusterName }}-cnpg-user
type: kubernetes.io/basic-auth
{{- end -}}
