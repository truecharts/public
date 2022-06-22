{{- define "add.user" -}}
    {{- $user := .Values.es_user -}}
    {{- printf "adduser %s -D;" $user -}}
{{- end -}}


{{- define "change.user.permissions" -}}
    {{- $user := .Values.es_user -}}
    {{- $mountPath := .Values.elasticSearchAppVolumeMounts.esdata.mountPath -}}
    {{- printf "chown -R %s:%s %s;" $user $user $mountPath -}}
{{- end -}}


{{- define "elasticsearch.IP" -}}
    {{ $envList := (default list) }}
    {{ $envList = mustAppend $envList (dict "name" "ES_HOST" "value" (printf "%s" (include "common.names.fullname" .))) }}
    {{ $envList = mustAppend $envList (dict "name" "ES_PORT" "value" "9200") }}
    {{ include "common.containers.environmentVariables" (dict "environmentVariables" $envList) }}
{{- end -}}


{{- define "elasticsearch.credentials" -}}
    {{ $envList := (default list) }}
    {{ $envList = mustAppend $envList (dict "name" "ES_USER" "valueFromSecret" true "secretName" "elastic-search-credentials" "secretKey" "es-username") }}
    {{ $envList = mustAppend $envList (dict "name" "ES_PASS" "valueFromSecret" true "secretName" "elastic-search-credentials" "secretKey" "es-password") }}
    {{ include "common.containers.environmentVariables" (dict "environmentVariables" $envList) }}
{{- end -}}


{{- define "config.file.path" -}}
    {{ $envList := (default list) }}
    {{ $envList = mustAppend $envList (dict "name" "DEST" "value" .mountPath) }}
    {{ $envList = mustAppend $envList (dict "name" "FILE" "value" .configFile) }}
    {{ include "common.containers.environmentVariables" (dict "environmentVariables" $envList) }}
{{- end -}}
