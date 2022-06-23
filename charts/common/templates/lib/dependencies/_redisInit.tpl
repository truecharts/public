{{/*
This template ensures pods with redis dependency have a delayed start
*/}}
{{- define "tc.common.dependencies.redis.init" -}}
{{- if .Values.redis.enabled }}
- name: redis-init
  image: "{{ .Values.redisImage.repository}}:{{ .Values.redisImage.tag }}"
  env:
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
  securityContext:
    capabilities:
      drop:
        - ALL
  resources:
  {{- with .Values.resources }}
    {{- tpl ( toYaml . ) $ | nindent 4 }}
  {{- end }}
  command: ["bash", "-ec"]
  args:
    - >
      [[ -n "$REDIS_PASSWORD" ]] && export REDISCLI_AUTH="$REDIS_PASSWORD"
      export LIVE=false
      until $LIVE
      do
        response=$(
            timeout -s 3 2 \
            redis-cli \
              -h $REDIS_HOST \
              -p $REDIS_PORT \
              ping
          )
        if [ "$response" == "PONG" ] || [ "$response" == "LOADING Redis is loading the dataset in memory" ]; then
          LIVE=true
          echo "$response"
          echo "Redis Responded, ending initcontainer and starting main container(s)..."
        else
          echo "$response"
          echo "Redis not respoding... Sleeping for 10 sec..."
          sleep 10
        fi
      done
  imagePullPolicy: IfNotPresent
{{- end }}
{{- end -}}
