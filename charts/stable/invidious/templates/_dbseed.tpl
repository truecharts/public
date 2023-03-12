{{- define "invidious.dbseed" -}}
image: "{{ .Values.ubuntuImage.repository }}:{{ .Values.ubuntuImage.tag }}"
env:
  - name: POSTGRES_DB
    value: {{ .Values.cnpg.main.database }}
  - name: POSTGRES_USER
    value: {{ .Values.cnpg.main.user }}
{{/* PG* variables are for the psql client */}}
  - name: PGPORT
    value: "5432"
  - name: PGHOST
    valueFrom:
      secretKeyRef:
        name: dbcreds
        key: plainhost
  - name: PGPASSWORD
    valueFrom:
      secretKeyRef:
        name: dbcreds
        key: postgresql-password
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
