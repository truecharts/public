{{/* Name suffixed with operator */}}
{{- define "kube-prometheus.fullname" -}}
{{- printf "%s" (include "tc.v1.common.lib.chart.names.fullname" . ) -}}
{{- end }}

{{/* Name suffixed with operator */}}
{{- define "kube-prometheus.name" -}}
{{- printf "%s" (include "tc.v1.common.lib.chart.names.fullname" . ) -}}
{{- end }}

{{/* Name suffixed with operator */}}
{{- define "kube-prometheus.operator.name" -}}
{{- printf "%s-operator" (include "tc.v1.common.lib.chart.names.fullname" . ) -}}
{{- end }}

{{/* Name suffixed with prometheus */}}
{{- define "kube-prometheus.prometheus.name" -}}
{{- printf "%s-prometheus" (include "tc.v1.common.lib.chart.names.fullname" . ) -}}
{{- end }}

{{/* Name suffixed with alertmanager */}}
{{- define "kube-prometheus.alertmanager.name" -}}
{{- printf "%s-alertmanager" (include "tc.v1.common.lib.chart.names.fullname" . ) -}}
{{- end }}

{{/* Name suffixed with thanos */}}
{{- define "kube-prometheus.thanos.name" -}}
{{- printf "%s-thanos" (include "tc.v1.common.lib.chart.names.fullname" . ) -}}
{{- end }}

{{/* Fullname suffixed with operator */}}
{{- define "kube-prometheus.operator.fullname" -}}
{{- printf "%s-operator" (include "tc.v1.common.lib.chart.names.fullname" . ) -}}
{{- end }}

{{/* Fullname suffixed with prometheus */}}
{{- define "kube-prometheus.prometheus.fullname" -}}
{{- printf "%s-prometheus" (include "tc.v1.common.lib.chart.names.fullname" . ) -}}
{{- end }}

{{/* Fullname suffixed with alertmanager */}}
{{- define "kube-prometheus.alertmanager.fullname" -}}
{{- printf "%s-alertmanager" (include "tc.v1.common.lib.chart.names.fullname" . ) -}}
{{- end }}

{{/* Fullname suffixed with thanos */}}
{{- define "kube-prometheus.thanos.fullname" -}}
{{- printf "%s-thanos" (include "kube-prometheus.prometheus.fullname" .) -}}
{{- end }}

{{- define "kube-prometheus.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common Labels
*/}}
{{- define "kube-prometheus.labels" -}}
  {{- $labels := (include "tc.v1.common.lib.metadata.allLabels" $ | fromYaml) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "labels" $labels) | trim) }}
    {{- . | nindent 0 }}
  {{- end }}
{{- if .Values.global.labels }}
{{ toYaml .Values.global.labels }}
{{- end }}
{{- end -}}

{{/*
Labels for operator
*/}}
{{- define "kube-prometheus.operator.labels" -}}
  {{- $labels := (include "tc.v1.common.lib.metadata.allLabels" $ | fromYaml) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "labels" $labels) | trim) }}
    {{- . | nindent 0 }}
  {{- end }}
app.kubernetes.io/component: operator
{{- end -}}

{{/*
Labels for prometheus
*/}}
{{- define "kube-prometheus.prometheus.labels" -}}
  {{- $labels := (include "tc.v1.common.lib.metadata.allLabels" $ | fromYaml) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "labels" $labels) | trim) }}
    {{- . | nindent 0 }}
  {{- end }}
app.kubernetes.io/component: prometheus
{{- end -}}

{{/*
Labels for alertmanager
*/}}
{{- define "kube-prometheus.alertmanager.labels" -}}
  {{- $labels := (include "tc.v1.common.lib.metadata.allLabels" $ | fromYaml) -}}
  {{- with (include "tc.v1.common.lib.metadata.render" (dict "rootCtx" $ "labels" $labels) | trim) }}
    {{- . | nindent 0 }}
  {{- end }}
app.kubernetes.io/component: alertmanager
{{- end -}}

{{/*
matchLabels for operator
*/}}
{{- define "kube-prometheus.operator.matchLabels" -}}
{{ include "tc.v1.common.lib.metadata.selectorLabels" (dict "rootCtx" $ )}}
app.kubernetes.io/component: operator
{{- end -}}

{{/*
matchLabels for prometheus
*/}}
{{- define "kube-prometheus.prometheus.matchLabels" -}}
{{ include "tc.v1.common.lib.metadata.selectorLabels" (dict "rootCtx" $ )}}
app.kubernetes.io/component: prometheus
{{- end -}}

{{/*
matchLabels for alertmanager
*/}}
{{- define "kube-prometheus.alertmanager.matchLabels" -}}
{{ include "tc.v1.common.lib.metadata.selectorLabels" (dict "rootCtx" $ )}}
app.kubernetes.io/component: alertmanager
{{- end -}}

{{/*
Return the proper Prometheus Operator image name
*/}}
{{- define "kube-prometheus.image" -}}
{{ printf "%s:%s" .Values.image.repository (default .Chart.AppVersion .Values.image.tag) | quote }}
{{- end -}}

{{/*
Return the proper Prometheus Operator Reloader image name
*/}}
{{- define "kube-prometheus.prometheusConfigReloader.image" -}}
{{- include "kube-prometheus.image" . -}}
{{- end -}}

{{/*
Return the proper Prometheus Image name
*/}}
{{- define "kube-prometheus.prometheus.image" -}}
{{ printf "%s:%s" .Values.image.repository (default .Chart.AppVersion .Values.image.tag) | quote }}
{{- end -}}

{{/*
Return the proper Thanos Image name
*/}}
{{- define "kube-prometheus.prometheus.thanosImage" -}}
{{ printf "%s:%s" .Values.thanosImage.repository (default .Chart.AppVersion .Values.thanosImage.tag) | quote }}
{{- end -}}

{{/*
Return the proper Alertmanager Image name
*/}}
{{- define "kube-prometheus.alertmanager.image" -}}
{{ printf "%s:%s" .Values.alertmanagerImage.repository (default .Chart.AppVersion .Values.alertmanagerImage.tag) | quote }}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "kube-prometheus.imagePullSecrets" -}}
{{- end -}}

{{/*
Create the name of the operator service account to use
*/}}
{{- define "kube-prometheus.operator.serviceAccountName" -}}
{{- if .Values.operator.serviceAccount.create -}}
    {{ default (include "kube-prometheus.operator.fullname" .) .Values.operator.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.operator.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the prometheus service account to use
*/}}
{{- define "kube-prometheus.prometheus.serviceAccountName" -}}
{{- if .Values.prometheus.serviceAccount.create -}}
    {{ default (include "kube-prometheus.prometheus.fullname" .) .Values.prometheus.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.prometheus.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Create the name of the alertmanager service account to use
*/}}
{{- define "kube-prometheus.alertmanager.serviceAccountName" -}}
{{- if .Values.alertmanager.serviceAccount.create -}}
    {{ default (include "kube-prometheus.alertmanager.fullname" .) .Values.alertmanager.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.alertmanager.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Compile all warnings into a single message, and call fail.
*/}}
{{- define "kube-prometheus.validateValues" -}}
{{- $messages := list -}}
{{- $messages := without $messages "" -}}
{{- $message := join "\n" $messages -}}

{{- if $message -}}
{{- printf "\nVALUES VALIDATION:\n%s" $message | fail -}}
{{- end -}}
{{- end -}}
