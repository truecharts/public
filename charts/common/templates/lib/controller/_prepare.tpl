{{/*
This template serves as the blueprint for the mountPermissions job that is run
before chart installation.
*/}}
{{- define "tc.common.controller.prepare" -}}
{{- $group := .Values.podSecurityContext.fsGroup -}}
{{- $hostPathMounts := dict -}}
{{- range $name, $mount := .Values.persistence -}}
  {{- if and $mount.enabled $mount.setPermissions -}}
    {{- $name = default ( $name| toString ) $mount.name -}}
    {{- $_ := set $hostPathMounts $name $mount -}}
  {{- end -}}
{{- end }}
- name: prepare
  image: {{ .Values.multiinitImage.repository }}:{{ .Values.multiinitImage.tag }}
  securityContext:
    runAsUser: 0
  resources:
  {{- with .Values.resources }}
    {{- tpl ( toYaml . ) $ | nindent 4 }}
  {{- end }}
  env:
    {{- if .Values.mariadb.enabled }}
    - name: MARIADB_HOST
      valueFrom:
        secretKeyRef:
          name: mariadbcreds
          key: plainhost
    - name: MARIADB_ROOT_PASSWORD
      valueFrom:
        secretKeyRef:
          name: mariadbcreds
          key: mariadb-root-password
    {{- end }}
    {{- if .Values.redis.enabled }}
    - name: REDIS_HOST
      valueFrom:
        secretKeyRef:
          name: rediscreds
          key: plainhost
    - name: REDIS_PASSWORD
      valueFrom:
        secretKeyRef:
          name: rediscreds
          key: redis-password
    - name: REDIS_PORT
      value: "6379"
    {{- end }}
    {{- if .Values.mongodb.enabled }}
    - name: MONGODB_HOST
      valueFrom:
        secretKeyRef:
          name: mongodbcreds
          key: plainhost
    - name: MONGODB_DATABASE
      value: "{{ .Values.mongodb.mongoDatabase }}"
    {{- end }}
    {{- if .Values.clickhouse.enabled }}
    - name: CLICKHOUSE_PING
      valueFrom:
        secretKeyRef:
          name: clickhousecreds
          key: ping
    {{- end }}
    {{- if .Values.solr.enabled }}
    - name: SOLR_HOST
      valueFrom:
        secretKeyRef:
          name: solrcreds
          key: plainhost
    - name: SOLR_CORES
      value: "{{ .Values.solr.solrCores }}"
    - name: SOLR_ENABLE_AUTHENTICATION
      value: "{{ .Values.solr.solrEnableAuthentication }}"
    {{- if eq .Values.solr.solrEnableAuthentication "yes" }}
    - name: SOLR_ADMIN_USERNAME
      value: "{{ .Values.solr.solrUsername }}"
    - name: SOLR_ADMIN_PASSWORD
      valueFrom:
        secretKeyRef:
          name: solrcreds
          key: solr-password
    {{- end }}
    {{- end }}
  command:
    - "/bin/sh"
    - "-c"
    - |
      /bin/bash <<'EOF'
      echo "Automatically correcting permissions..."
      {{- if and ( .Values.addons.vpn.configFile.enabled ) ( ne .Values.addons.vpn.type "disabled" ) ( ne .Values.addons.vpn.type "tailscale" ) }}
      echo "Automatically correcting permissions for vpn config file..."
      if nfs4xdr_getfacl && nfs4xdr_getfacl | grep -qv "Failed to get NFSv4 ACL"; then
        echo "NFSv4 ACLs detected, using nfs4_setfacl to set permissions..."
        nfs4_setfacl -a A::568:RWX /vpn/vpn.conf || echo "Setting user permissions failed..."
        nfs4_setfacl -a A:g:568:RWX /vpn/vpn.conf || echo "Setting group permissions failed..."
      else
        echo "No NFSv4 ACLs detected, trying chown/chmod..."
        chown -R 568:568 /vpn/vpn.conf || echo "Setting ownership failed..."
        chmod -R g+w /vpn/vpn.conf || echo "Setting group permissions failed..."
      fi
      {{- end }}
      {{- range $_, $hpm := $hostPathMounts }}
      echo "Automatically correcting permissions for {{ $hpm.mountPath }}..."
      if nfs4xdr_getfacl && nfs4xdr_getfacl | grep -qv "Failed to get NFSv4 ACL"; then
        echo "NFSv4 ACLs detected, using nfs4_setfacl to set permissions..."
        nfs4_setfacl -R -a A:g:{{ $group }}:RWX {{ tpl $hpm.mountPath $ | squote }} || echo "Setting group permissions failed..."
      else
        echo "No NFSv4 ACLs detected, trying chown/chmod..."
        chown -R :{{ $group }} {{ tpl $hpm.mountPath $ | squote }} || echo "Setting group ownership failed..."
        chmod -R g+rwx {{ tpl $hpm.mountPath $ | squote }} || echo "Setting group permissions failed..."
      fi
      {{- end }}
      {{- if .Values.postgresql.enabled }}
      {{- $pghost := printf "%v-%v" .Release.Name "postgresql" }}
      until
        pg_isready -U {{ .Values.postgresql.postgresqlUsername }} -h {{ $pghost }}
        do sleep 2
      done
      {{- end }}
      {{- if .Values.mongodb.enabled }}
      until
        echo "db.runCommand(\"ping\")" | mongosh --host ${MONGODB_HOST} --port 27017 ${MONGODB_DATABASE} --quiet;
        do sleep 2;
      done
      {{- end }}
      {{- if .Values.mariadb.enabled }}
      until
        mysqladmin -uroot -h"${MARIADB_HOST}" -p"${MARIADB_ROOT_PASSWORD}" ping \
        && mysqladmin -uroot -h"${MARIADB_HOST}" -p"${MARIADB_ROOT_PASSWORD}" status;
        do sleep 2;
      done
      {{- end }}
      {{- if .Values.redis.enabled }}
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
      {{- end }}
      {{- if .Values.clickhouse.enabled }}
      until wget --quiet --tries=1 --spider "${CLICKHOUSE_PING}"; do
        echo "ClickHouse - no response. Sleeping 2 seconds..."
        sleep 2
      done
      echo "ClickHouse - accepting connections"
      {{- end }}
      {{- if .Values.solr.enabled }}
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
      {{- end }}

      EOF

  volumeMounts:
    {{- range $name, $hpm := $hostPathMounts }}
    - name: {{ $name }}
      mountPath: {{ $hpm.mountPath }}
      {{- if $hpm.subPath }}
      subPath: {{ $hpm.subPath }}
      {{- end }}
    {{- end }}
    {{- if and ( .Values.addons.vpn.configFile.enabled ) ( ne .Values.addons.vpn.type "disabled" ) ( ne .Values.addons.vpn.type "tailscale" ) }}
    - name: vpnconfig
      mountPath: /vpn/vpn.conf
    {{- end }}
{{- end -}}
