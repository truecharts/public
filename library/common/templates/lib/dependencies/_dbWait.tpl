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
resources:
  excludeExtra: true
  requests:
    cpu: 10m
    memory: 50Mi
  limits:
    cpu: 500m
    memory: 512Mi
env:
  REDIS_HOST:
    secretKeyRef:
      expandObjectName: false
      name: '{{ printf "%s-%s" .Release.Name "rediscreds" }}'
      key: plainhost
  REDIS_PASSWORD: "{{ .Values.redis.password }}"
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
  excludeExtra: true
  requests:
    cpu: 10m
    memory: 50Mi
  limits:
    cpu: 500m
    memory: 512Mi
env:
  MARIADB_HOST:
    secretKeyRef:
      expandObjectName: false
      name: '{{ printf "%s-%s" .Release.Name "mariadbcreds" }}'
      key: plainhost
  MARIADB_ROOT_PASSWORD: "{{ .Values.mariadb.rootPassword }}"
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
  excludeExtra: true
  requests:
    cpu: 10m
    memory: 50Mi
  limits:
    cpu: 500m
    memory: 512Mi
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
  excludeExtra: true
  requests:
    cpu: 10m
    memory: 50Mi
  limits:
    cpu: 500m
    memory: 512Mi
env:
  CLICKHOUSE_PING:
    secretKeyRef:
      expandObjectName: false
      name: '{{ printf "%s-%s" .Release.Name "clickhousecreds" }}'
      key: ping
command:
  - "/bin/sh"
args:
  - "-c"
  - |
    echo "Executing DB waits..."
    until wget --quiet --tries=1 --spider "${CLICKHOUSE_PING}"; do
      echo "ClickHouse - no response. Sleeping 2 seconds..."
      sleep 2
    done
    echo "ClickHouse - accepting connections"
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
  excludeExtra: true
  requests:
    cpu: 10m
    memory: 50Mi
  limits:
    cpu: 500m
    memory: 512Mi
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
args:
  - "-c"
  - |
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
    fi
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
  excludeExtra: true
  requests:
    cpu: 10m
    memory: 50Mi
  limits:
    cpu: 500m
    memory: 512Mi
command:
  - "/bin/sh"
  - "-c"
  - |
    /bin/sh <<'EOF'
{{- range $name, $cnpg := .Values.cnpg -}}
  {{- if $cnpg.enabled }}
    echo "Executing DB waits..."
    {{- $cnpgName := include "tc.v1.common.lib.chart.names.fullname" $ -}}
    {{- $cnpgName = printf "%v-cnpg-%v" $cnpgName $name -}}

    {{/* Wait RW CNPG */}}
    {{- include "cnpg.wait.script" (dict "url" (printf "%s-rw" $cnpgName) "user" .user "db" .database "on" "CNPG RW") | nindent 4 -}}

    {{- if and $cnpg.pooler $cnpg.pooler.enabled -}}
      {{/* Wait RW Pooler */}}
      {{- include "cnpg.wait.script" (dict "url" (printf "%s-pooler-rw" $cnpgName) "user" .user "db" .database "on" "CNPG Pooler RW") | nindent 4 -}}

      {{/* Wait RO Pooler */}}
      {{- if $cnpg.pooler.createRO -}}
        {{- include "cnpg.wait.script" (dict "url" (printf "%s-pooler-ro" $cnpgName) "user" .user "db" .database "on" "CNPG Pooler RO") | nindent 4 -}}
      {{- end -}}

    {{- end -}}
  {{- end -}}
{{- end }}
    echo "Done executing DB waits..."
    EOF
{{- end -}}

{{- define "cnpg.wait.script" -}}
  {{- $url := .url -}}
  {{- $user := .user -}}
  {{- $db := .db -}}
  {{- $on := .on -}}
echo "Testing Database availability on [{{ $on }}]"
until
  echo "Testing database on url: [{{ $url }}]"
  pg_isready -U {{ $user }} -d {{ $db }} -h {{ $url }}
  do sleep 5
done
echo "Database available on url: [{{ $url }}]"
{{- end -}}
