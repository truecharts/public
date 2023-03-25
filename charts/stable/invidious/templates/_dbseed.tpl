{{- define "invidious.dbseed" -}}
initContainers:
  dbseed:
    enabled: true
    imageSelector: ubuntuImage
    type: install
    env:
      POSTGRES_DB: {{ .Values.cnpg.main.database }}
      POSTGRES_USER: {{ .Values.cnpg.main.user }}
    {{/* PG* variables are for the psql client */}}
      PGPORT: "5432"
      PGHOST:
        secretKeyRef:
            name: dbcreds
            key: host
      PGPASSWORD:
        secretKeyRef:
            name: dbcreds
            key: password
    command:
      - /bin/sh
      - -c
      - |
        echo "Starting DB Seed..."
        mkdir -p invidious && cd invidious

        echo "Fetching seed files..."
        git init && \
        git remote add invidious https://github.com/iv-org/invidious.git && \
        git fetch invidious && \
        # Fetch config and docker dirs
        git checkout invidious/master -- docker config

        # Move config into docker dir
        echo "Preparing directory structure..."
        mv -fv config docker

        echo "Performing the seed..."
        cd docker
        ./init-invidious-db.sh
{{- end -}}
