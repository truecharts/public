{{- define "tc.v1.common.lib.deps.wait" -}}
  {{- if .Values.redis.enabled -}}
    {{- $container := include "tc.v1.common.lib.deps.wait.redis" $ | fromYaml -}}
    {{- if $container -}}
      {{- range .Values.workload -}}
        {{- if not (hasKey .podSpec "initContainers") -}}
          {{- $_ := set .podSpec "initContainers" dict -}}
        {{- end -}}
      {{- $_ := set .podSpec.initContainers "redis-wait" $container -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if .Values.mariadb.enabled -}}
    {{- $container := include "tc.v1.common.lib.deps.wait.mariadb" $ | fromYaml -}}
    {{- if $container -}}
      {{- range .Values.workload -}}
        {{- if not (hasKey .podSpec "initContainers") -}}
          {{- $_ := set .podSpec "initContainers" dict -}}
        {{- end -}}
      {{- $_ := set .podSpec.initContainers "mariadb-wait" $container -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if .Values.mongodb.enabled -}}
    {{- $container := include "tc.v1.common.lib.deps.wait.mongodb" $ | fromYaml -}}
    {{- if $container -}}
      {{- range .Values.workload -}}
        {{- if not (hasKey .podSpec "initContainers") -}}
          {{- $_ := set .podSpec "initContainers" dict -}}
        {{- end -}}
      {{- $_ := set .podSpec.initContainers "mongodb-wait" $container -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if .Values.clickhouse.enabled -}}
    {{- $container := include "tc.v1.common.lib.deps.wait.clickhouse" $ | fromYaml -}}
    {{- if $container -}}
      {{- range .Values.workload -}}
        {{- if not (hasKey .podSpec "initContainers") -}}
          {{- $_ := set .podSpec "initContainers" dict -}}
        {{- end -}}
        {{- $_ := set .podSpec.initContainers "clickhouse-wait" $container -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- if .Values.solr.enabled -}}
    {{- $container := include "tc.v1.common.lib.deps.wait.solr" $ | fromYaml -}}
    {{- if $container -}}
      {{- range .Values.workload -}}
        {{- if not (hasKey .podSpec "initContainers") -}}
          {{- $_ := set .podSpec "initContainers" dict -}}
        {{- end -}}
      {{- $_ := set .podSpec.initContainers "solr-wait" $container -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{- $result := false -}}
  {{- range .Values.cnpg -}}
    {{- if .enabled -}}
      {{- $result = true -}}
    {{- end -}}
  {{- end -}}

  {{- if $result -}}
    {{- $container := include "tc.v1.common.lib.deps.wait.cnpg" $ | fromYaml -}}
    {{- if $container -}}
      {{- range $.Values.workload -}}
        {{- if not (hasKey .podSpec "initContainers") -}}
          {{- $_ := set .podSpec "initContainers" dict -}}
        {{- end -}}
        {{- $_ := set .podSpec.initContainers "cnpg-wait" $container -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}
{{- end -}}

{{- define "tc.v1.common.lib.deps.wait.redis" -}}
enabled: true
type: system
imageSelector: redisClientImage
securityContext:
  runAsUser: 568
  runAsGroup: 568
  readOnlyRootFilesystem: true
  runAsNonRoot: true
  allowPrivilegeEscalation: false
  privileged: false
  seccompProfile:
    type: RuntimeDefault
  capabilities:
    add: []
    drop:
      - ALL
env:
  REDIS_HOST:
    secretKeyRef:
      expandObjectName: false
      name: '{{ printf "%s-%s" .Release.Name "rediscreds" }}'
      key: plainhost
  REDIS_PASSWORD:
    secretKeyRef:
      expandObjectName: false
      name: '{{ printf "%s-%s" .Release.Name "rediscreds" }}'
      key: redis-password
  REDIS_PORT: "6379"
command:
  - "/bin/sh"
  - "-c"
  - |
    /bin/bash <<'EOF'
    echo "Executing DB waits..."
    [[ -n "$REDIS_PASSWORD" ]] && export REDISCLI_AUTH="$REDIS_PASSWORD";
    export LIVE=false;
    until "$LIVE";
    do
      response=$(
          timeout -s 3 2 \
          redis-cli \
            -h "$REDIS_HOST" \
            -p "$REDIS_PORT" \
            ping
        )
      if [ "$response" == "PONG" ] || [ "$response" == "LOADING Redis is loading the dataset in memory" ]; then
        LIVE=true
        echo "$response"
        echo "Redis Responded, ending initcontainer and starting main container(s)..."
      else
        echo "$response"
        echo "Redis not responding... Sleeping for 10 sec..."
        sleep 10
      fi;
    done
    EOF
{{- end -}}

{{- define "tc.v1.common.lib.deps.wait.mariadb" -}}
enabled: true
type: system
imageSelector: mariadbClientImage
securityContext:
  runAsUser: 568
  runAsGroup: 568
  readOnlyRootFilesystem: true
  runAsNonRoot: true
  allowPrivilegeEscalation: false
  privileged: false
  seccompProfile:
    type: RuntimeDefault
  capabilities:
    add: []
    drop:
      - ALL
resources:
  requests:
    cpu: 10m
    memory: 50Mi
  limits:
    cpu: 4000m
    memory: 8Gi
env:
  MARIADB_HOST:
    secretKeyRef:
      expandObjectName: false
      name: '{{ printf "%s-%s" .Release.Name "mariadbcreds" }}'
      key: plainhost
  MARIADB_ROOT_PASSWORD:
    secretKeyRef:
      expandObjectName: false
      name: '{{ printf "%s-%s" .Release.Name "mariadbcreds" }}'
      key: mariadb-root-password
command:
  - "/bin/sh"
  - "-c"
  - |
    /bin/bash <<'EOF'
    echo "Executing DB waits..."
    until
      mysqladmin -uroot -h"${MARIADB_HOST}" -p"${MARIADB_ROOT_PASSWORD}" ping \
      && mysqladmin -uroot -h"${MARIADB_HOST}" -p"${MARIADB_ROOT_PASSWORD}" status;
      do sleep 2;
    done
    EOF
{{- end -}}

{{- define "tc.v1.common.lib.deps.wait.mongodb" -}}
enabled: true
type: system
imageSelector: mongodbClientImage
securityContext:
  runAsUser: 568
  runAsGroup: 568
  readOnlyRootFilesystem: true
  runAsNonRoot: true
  allowPrivilegeEscalation: false
  privileged: false
  seccompProfile:
    type: RuntimeDefault
  capabilities:
    add: []
    drop:
      - ALL
resources:
  requests:
    cpu: 10m
    memory: 50Mi
  limits:
    cpu: 4000m
    memory: 8Gi
env:
  MONGODB_HOST:
    secretKeyRef:
      expandObjectName: false
      name: '{{ printf "%s-%s" .Release.Name "mongodbcreds" }}'
      key: plainhost
  MONGODB_DATABASE: "{{ .Values.mongodb.mongodbDatabase }}"
command:
  - "/bin/sh"
  - "-c"
  - |
    /bin/bash <<'EOF'
    echo "Executing DB waits..."
    until
      HOME=/config && echo "db.runCommand(\"ping\")" | mongosh --host ${MONGODB_HOST} --port 27017 ${MONGODB_DATABASE} --quiet;
      do sleep 2;
    done
    EOF
{{- end -}}

{{- define "tc.v1.common.lib.deps.wait.clickhouse" -}}
enabled: true
type: system
imageSelector: alpineImage
securityContext:
  runAsUser: 568
  runAsGroup: 568
  readOnlyRootFilesystem: true
  runAsNonRoot: true
  allowPrivilegeEscalation: false
  privileged: false
  seccompProfile:
    type: RuntimeDefault
  capabilities:
    add: []
    drop:
      - ALL
resources:
  requests:
    cpu: 10m
    memory: 50Mi
  limits:
    cpu: 4000m
    memory: 8Gi
env:
  CLICKHOUSE_PING:
    secretKeyRef:
      expandObjectName: false
      name: '{{ printf "%s-%s" .Release.Name "clickhousecreds" }}'
      key: ping
command:
  - "/bin/sh"
  - "-c"
  - |
    /bin/bash <<'EOF'
    echo "Executing DB waits..."
    until wget --quiet --tries=1 --spider "${CLICKHOUSE_PING}"; do
      echo "ClickHouse - no response. Sleeping 2 seconds..."
      sleep 2
    done
    echo "ClickHouse - accepting connections"
    EOF
{{- end -}}

{{- define "tc.v1.common.lib.deps.wait.solr" -}}
enabled: true
type: system
imageSelector: wgetImage
securityContext:
  runAsUser: 568
  runAsGroup: 568
  readOnlyRootFilesystem: true
  runAsNonRoot: true
  allowPrivilegeEscalation: false
  privileged: false
  seccompProfile:
    type: RuntimeDefault
  capabilities:
    add: []
    drop:
      - ALL
resources:
  requests:
    cpu: 10m
    memory: 50Mi
  limits:
    cpu: 4000m
    memory: 8Gi
env:
  SOLR_HOST:
    secretKeyRef:
      expandObjectName: false
      name: '{{ printf "%s-%s" .Release.Name "solrcreds" }}'
      key: plainhost
  SOLR_CORES: "{{ .Values.solr.solrCores }}"
  SOLR_ENABLE_AUTHENTICATION: "{{ .Values.solr.solrEnableAuthentication }}"
  SOLR_ADMIN_USERNAME: "{{ .Values.solr.solrUsername }}"
  SOLR_ADMIN_PASSWORD:
    secretKeyRef:
      expandObjectName: false
      name: '{{ printf "%s-%s" .Release.Name "solrcreds" }}'
      key: solr-password

command:
  - "/bin/sh"
  - "-c"
  - |
    /bin/bash <<'EOF'
    echo "Executing DB waits..."
    if [ "$SOLR_ENABLE_AUTHENTICATION" == "yes" ]; then
      until curl --fail --user "${SOLR_ADMIN_USERNAME}":"${SOLR_ADMIN_PASSWORD}" "${SOLR_HOST}":8983/solr/"${SOLR_CORES}"/admin/ping; do
        echo "Solr is not responding... Sleeping 2 seconds..."
        sleep 2
      done
    else
      until curl --fail "${SOLR_HOST}":8983/solr/"${SOLR_CORES}"/admin/ping; do
        echo "Solr is not responding... Sleeping 2 seconds..."
        sleep 2
      done
    fi;
    EOF
{{- end -}}

{{- define "tc.v1.common.lib.deps.wait.cnpg" -}}
enabled: true
type: system
imageSelector: postgresClientImage
securityContext:
  runAsUser: 568
  runAsGroup: 568
  readOnlyRootFilesystem: true
  runAsNonRoot: true
  allowPrivilegeEscalation: false
  privileged: false
  seccompProfile:
    type: RuntimeDefault
  capabilities:
    add: []
    drop:
      - ALL
resources:
  requests:
    cpu: 10m
    memory: 50Mi
  limits:
    cpu: 4000m
    memory: 8Gi
command:
  - "/bin/sh"
  - "-c"
  - |
    /bin/sh <<'EOF'
    {{ range $name, $cnpg := .Values.cnpg }}
    {{ if $cnpg.enabled }}
    echo "Executing DB waits..."
    {{ $cnpgName := include "tc.v1.common.lib.chart.names.fullname" $ }}
    {{ $cnpgName = printf "%v-cnpg-%v" $cnpgName $name }}
    echo "Detected RW pooler, testing RW pooler availability..."
    until
      echo "Testing database on url:  {{ $cnpgName }}-rw"
      pg_isready -U {{ .user }} -d {{ .database }} -h {{ $cnpgName }}-rw
      do sleep 5
    done
    {{ if $cnpg.acceptRO }}
    echo "Detected RO pooler, testing RO pooler availability..."
    until
      echo "Testing database on url:  {{ $cnpgName }}-ro"
      pg_isready -U {{ .user }} -d {{ .database }} -h {{ $cnpgName }}-ro
      do sleep 5
    done
    {{ end }}
    {{ end }}
    {{ end }}
    sleep 5
    EOF
{{- end -}}
