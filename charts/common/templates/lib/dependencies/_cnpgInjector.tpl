{{/*
This template serves as a blueprint for all cnpg objects that are created
within the common library.
*/}}
{{- define "tc.common.dependencies.cnpg.main" -}}
{{- if .Values.cnpg.enabled }}
{{- $cnpgName := include "tc.common.names.fullname" . }}
{{- $cnpgName = printf "%v-%v" $cnpgName "cnpg" }}
---
apiVersion: postgresql.cnpg.io/v1
kind: Cluster
metadata:
  name: {{ $cnpgName }}
  {{- with (merge (.Values.cnpg.labels | default dict) (include "tc.common.labels" $ | fromYaml)) }}
  labels: {{- tpl ( toYaml . ) $ | nindent 4 }}
  {{- end }}
  annotations:
  {{- with (merge (.Values.cnpg.annotations | default dict) (include "tc.common.annotations" $ | fromYaml)) }}
    {{- tpl ( toYaml . ) $ | nindent 4 }}
  {{- end }}
spec:
  instances: {{ .Values.cnpg.instances | default 2  }}

  bootstrap:
    initdb:
      database: {{ .Values.cnpg.database | default "app" }}
      owner: {{ .Values.cnpg.user | default "app" }}
      secret:
        name: cnpg-user

  superuserSecret:
    name: cnpg-superuser

  primaryUpdateStrategy: {{ .Values.cnpg.primaryUpdateStrategy | default "unsupervised" }}

  storage:
    pvcTemplate:
      {{ include "tc.common.storage.storageClassName" ( dict "persistence" .Values.cnpg.storage "global" $) }}
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: {{ .Values.cnpg.storage.size | default "256Gi" | quote }}

  walStorage:
    pvcTemplate:
      {{ include "tc.common.storage.storageClassName" ( dict "persistence" .Values.cnpg.storage "global" $) }}
      accessModes:
        - ReadWriteOnce
      resources:
        requests:
          storage: {{ .Values.cnpg.storage.walsize | default "256Gi" | quote }}

  monitoring:
    enablePodMonitor: {{ .Values.cnpg.monitoring.enablePodMonitor | default true }}

  nodeMaintenanceWindow:
    inProgress: false
    reusePVC: on
---
apiVersion: postgresql.cnpg.io/v1
kind: Pooler
metadata:
  {{ $poolerrwname := printf "pooler-%s-rw" $cnpgName }}
  name: {{ $poolerrwname }}
spec:
  cluster:
    name: {{ $cnpgName }}

  instances: {{ .Values.cnpg.instances | default 2 }}
  type: rw
  pgbouncer:
    poolMode: session
    parameters:
      max_client_conn: "1000"
      default_pool_size: "10"
{{ if ( .Values.cnpg.monitoring.enablePodMonitor | default true ) }}
---
apiVersion: monitoring.coreos.com/v1
kind: PodMonitor
metadata:
  name: {{ $cnpgName }}-rw
spec:
  selector:
    matchLabels:
      cnpg.io/poolerName: {{ $poolerrwname }}
  podMetricsEndpoints:
  - port: metrics
{{ end }}
{{ if ( .Values.cnpg.acceptRO | default true ) }}
---
apiVersion: postgresql.cnpg.io/v1
kind: Pooler
metadata:
  {{ $poolerroname := printf "pooler-%s-ro" $cnpgName }}
  name: {{ $poolerroname }}
spec:
  cluster:
    name: {{ $cnpgName }}

  instances: {{ .Values.cnpg.instances | default 2 }}
  type: ro
  pgbouncer:
    poolMode: session
    parameters:
      max_client_conn: "1000"
      default_pool_size: "10"
{{ if ( .Values.cnpg.monitoring.enablePodMonitor | default true ) }}
---
apiVersion: monitoring.coreos.com/v1
kind: PodMonitor
metadata:
  name: {{ $cnpgName }}-ro
spec:
  selector:
    matchLabels:
      cnpg.io/poolerName: {{ $poolerroname }}
  podMetricsEndpoints:
  - port: metrics
{{ end }}
{{ end }}
---
apiVersion: v1
kind: Secret
metadata:
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
  name: cnpgcreds
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
  {{- $dbPass = .Values.cnpg.password | default ( randAlphaNum 62 ) }}
  {{- $pgPass = .Values.cnpg.superUserPassword | default ( randAlphaNum 62 ) }}
  user-password: {{ $dbPass | b64enc | quote }}
  superuser-password: {{ $pgPass | b64enc | quote }}
{{- end }}
  {{- $std := ( ( printf "postgresql://%v:%v@%v:5432/%v" .Values.cnpg.user $dbPass $poolerrwname .Values.cnpg.database  ) | b64enc | quote ) }}
  {{- $nossl := ( ( printf "postgresql://%v:%v@%v:5432/%v?sslmode=disable" .Values.cnpg.user $dbPass $poolerrwname .Values.cnpg.database  ) | b64enc | quote ) }}
  {{- $porthost := ( ( printf "%s:5432" $poolerrwname ) | b64enc | quote ) }}
  {{- $host := ( ( printf "%s" $poolerrwname ) | b64enc | quote ) }}
  {{- $jdbc := ( ( printf "jdbc:postgresql://%v:5432/%v" $poolerrwname .Values.cnpg.database  ) | b64enc | quote ) }}

  std: {{ $std }}
  nossl: {{ $nossl }}
  porthost: {{ $porthost }}
  host: {{ $host }}
  jdbc: {{ $jdbc }}
type: Opaque
{{- $_ := set .Values.cnpg.creds "password" ( $dbPass | quote ) }}
{{- $_ := set .Values.cnpg.creds "superUserPassword" ( $pgPass | quote ) }}
{{- $_ := set .Values.cnpg.creds "std" $std }}
{{- $_ := set .Values.cnpg.creds "nossl" $nossl }}
{{- $_ := set .Values.cnpg.creds "porthost" $porthost }}
{{- $_ := set .Values.cnpg.creds "host" $host }}
{{- $_ := set .Values.cnpg.creds "jdbc" $jdbc }}
---
apiVersion: v1
data:
  username: {{ "postgres" | b64enc | quote  }}
  password: {{ $pgPass | b64enc | quote }}
kind: Secret
metadata:
  name: cnpg-superuser
type: kubernetes.io/basic-auth
---
apiVersion: v1
data:
  username: {{ .Values.cnpg.user | b64enc | quote }}
  password: {{ $dbPass | b64enc | quote }}
kind: Secret
metadata:
  name: cnpg-user
type: kubernetes.io/basic-auth

{{- end }}
{{- end -}}
