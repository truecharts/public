{{- define "tc.v1.common.lib.deps.wait.init" -}}
{{ $fullname := include "tc.v1.common.lib.chart.names.fullname" $ }}
{{ if .Values.redis.enabled }}
redis-wait:
{{- $redissecret := ( printf "%s-rediscreds" $fullname ) }}
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
    requests:
      cpu: 10m
      memory: 50Mi
    limits:
      cpu: 4000m
      memory: 8Gi
  env:
    REDIS_HOST:
      secretKeyRef:
        name: rediscreds
        key: plainhost
    REDIS_PASSWORD:
      secretKeyRef:
        name: rediscreds
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
{{ end }}
{{ if .Values.mariadb.enabled  }}
mariadb-wait:
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
        name: mariadbcreds
        key: plainhost
    MARIADB_ROOT_PASSWORD:
      secretKeyRef:
        name: mariadbcreds
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
{{ end }}
{{ if .Values.mongodb.enabled }}
mongodb-wait:
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
        name: mongodbcreds
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
{{ end }}
{{ if .Values.clickhouse.enabled }}
clickhouse-wait:
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
        name: "clickhousecreds"
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
{{ end }}
{{ if .Values.solr.enabled }}
solr-wait:
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
        name: solrcreds
        key: plainhost
    SOLR_CORES: "{{ .Values.solr.solrCores }}"
    SOLR_ENABLE_AUTHENTICATION: "{{ .Values.solr.solrEnableAuthentication }}"
    SOLR_ADMIN_USERNAME: "{{ .Values.solr.solrUsername }}"
    SOLR_ADMIN_PASSWORD:
      secretKeyRef:
        name: solrcreds
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
{{ end }}
{{ if .Values.postgresql.enabled }}
postgresql-wait:
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
      echo "Executing DB waits..."
      {{- $pghost := printf "%v-%v" .Release.Name "postgresql" }}
      until
        pg_isready -U {{ .Values.postgresql.postgresqlUsername }} -h {{ $pghost }}
        do sleep 2
      done
      EOF
{{ end }}
{{ $result := false }}{{ range .Values.cnpg }}{{ if .enabled }}{{ $result = true }}{{ end }}{{ end }}
{{ if $result }}
cnpg-wait:
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
      {{ $nameOverride := $cnpg.nameOverride }}
      {{ if and (not $cnpg.nameOverride ) (ne $name (include "tc.v1.common.lib.util.cnpg.primary" $)) }}
        {{ $_ := set $cnpg.nameOverride $name }}
      {{ end }}
      {{ if $cnpg.nameOverride }}
        {{ $cnpgName = printf "%v-%v" $cnpgName $nameOverride }}
      {{ end }}
      until
        pg_isready -U {{ .user }} -h cnpg-{{ $cnpgName }}-rw
        pg_isready -U {{ .user }} -h cnpg-{{ $fullname }}-rw
        do sleep 2
      done
      until
        pg_isready -U {{ .user }} -h cnpg-pooler-{{ $cnpgName }}-rw
        do sleep 2
      done
      {{ if $cnpg.acceptRO }}
      until
        pg_isready -U {{ .user }} -h cnpg-{{ $cnpgName }}-ro
        do sleep 2
      done
      until
        pg_isready -U {{ .user }} -h cnpg-pooler-{{ $cnpgName }}-ro
        do sleep 2
      done
      {{ end }}
      {{ end }}
      {{ end }}
      EOF
{{ end }}
{{- end -}}
