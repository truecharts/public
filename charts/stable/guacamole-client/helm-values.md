# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| api | object | `{}` |  |
| cas | object | `{}` |  |
| duo | object | `{}` |  |
| env.GUACD_HOSTNAME | string | `"localhost"` |  |
| env.GUACD_PORT | int | `4822` |  |
| env.POSTGRES_DATABASE | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| env.POSTGRES_PORT | int | `5432` |  |
| env.POSTGRES_USER | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| envFrom[0].configMapRef.name | string | `"guacamole-client-env"` |  |
| envValueFrom.POSTGRES_HOSTNAME.secretKeyRef.key | string | `"plainhost"` |  |
| envValueFrom.POSTGRES_HOSTNAME.secretKeyRef.name | string | `"dbcreds"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.key | string | `"postgresql-password"` |  |
| envValueFrom.POSTGRES_PASSWORD.secretKeyRef.name | string | `"dbcreds"` |  |
| general | object | `{}` |  |
| header.HEADER_ENABLED | bool | `false` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/guacamole-client"` |  |
| image.tag | string | `"v1.4.0@sha256:43f7b0575173f509b5215a89170dfea80ea07f0b2bfed405882a4bc7ec9dfa52"` |  |
| initContainers.1-creat-initdb-file.args[0] | string | `"echo \"Creating initdb.sql file...\"; /opt/guacamole/bin/initdb.sh --postgres > /initdbdata/initdb.sql; if [ -e /initdbdata/initdb.sql ]; then\n  echo \"Init file created successfully!\";\n  exit 0;\nelse\n  echo \"Init file failed to create.\";\n  exit 1;\nfi;\n"` |  |
| initContainers.1-creat-initdb-file.command[0] | string | `"/bin/sh"` |  |
| initContainers.1-creat-initdb-file.command[1] | string | `"-c"` |  |
| initContainers.1-creat-initdb-file.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| initContainers.1-creat-initdb-file.volumeMounts[0].mountPath | string | `"/initdbdata"` |  |
| initContainers.1-creat-initdb-file.volumeMounts[0].name | string | `"initdbdata"` |  |
| initContainers.2-initdb.args[0] | string | `"psql -h $POSTGRES_HOSTNAME -d $POSTGRES_DATABASE -U $POSTGRES_USER -p $POSTGRES_PORT -o '/dev/null' -c 'SELECT * FROM public.guacamole_user'; if [ $? -eq 0 ];\n  then\n    echo \"DB already initialized. Skipping...\";\n  else\n    echo \"Initializing DB's schema...\";\n    psql -h $POSTGRES_HOSTNAME -d $POSTGRES_DATABASE -U $POSTGRES_USER -p $POSTGRES_PORT -a -w -f /initdbdata/initdb.sql;\n    if [ $? -eq 0 ];\n      then\n        echo \"DB's schema initialized successfully!\";\n        exit 0;\n      else\n        echo \"DB's schema failed to initialize.\";\n        exit 1;\n    fi;\nfi;\n"` |  |
| initContainers.2-initdb.command[0] | string | `"/bin/sh"` |  |
| initContainers.2-initdb.command[1] | string | `"-c"` |  |
| initContainers.2-initdb.env[0].name | string | `"POSTGRES_DATABASE"` |  |
| initContainers.2-initdb.env[0].value | string | `"{{ .Values.postgresql.postgresqlDatabase }}"` |  |
| initContainers.2-initdb.env[1].name | string | `"POSTGRES_USER"` |  |
| initContainers.2-initdb.env[1].value | string | `"{{ .Values.postgresql.postgresqlUsername }}"` |  |
| initContainers.2-initdb.env[2].name | string | `"POSTGRES_PORT"` |  |
| initContainers.2-initdb.env[2].value | string | `"5432"` |  |
| initContainers.2-initdb.env[3].name | string | `"POSTGRES_HOSTNAME"` |  |
| initContainers.2-initdb.env[3].valueFrom.secretKeyRef.key | string | `"plainhost"` |  |
| initContainers.2-initdb.env[3].valueFrom.secretKeyRef.name | string | `"dbcreds"` |  |
| initContainers.2-initdb.env[4].name | string | `"PGPASSWORD"` |  |
| initContainers.2-initdb.env[4].valueFrom.secretKeyRef.key | string | `"postgresql-password"` |  |
| initContainers.2-initdb.env[4].valueFrom.secretKeyRef.name | string | `"dbcreds"` |  |
| initContainers.2-initdb.image | string | `"{{ .Values.postgresqlImage.repository }}:{{ .Values.postgresqlImage.tag }}"` |  |
| initContainers.2-initdb.volumeMounts[0].mountPath | string | `"/initdbdata"` |  |
| initContainers.2-initdb.volumeMounts[0].name | string | `"initdbdata"` |  |
| initContainers.3-temp-hack.args[0] | string | `"echo \"Checing postgresql driver version...\"; if [ -e /opt/guacamole/postgresql/postgresql-42.2.24.jre7.jar ];\n  then\n    echo \"Version found is correct.\";\n    exit 0;\n  else\n    echo \"Old version found. Will try to download a known-to-work version.\";\n    echo \"Downloading (postgresql-42.2.24.jre7.jar)...\";\n    curl -L \"https://jdbc.postgresql.org/download/postgresql-42.2.24.jre7.jar\" > \"/opt/guacamole/postgresql-hack/postgresql-42.2.24.jre7.jar\";\n    if [ -e /opt/guacamole/postgresql-hack/postgresql-42.2.24.jre7.jar ];\n      then\n        echo \"Downloaded successfully!\";\n        cp -r /opt/guacamole/postgresql/* /opt/guacamole/postgresql-hack/;\n        if [ -e /opt/guacamole/postgresql-hack/postgresql-9.4-1201.jdbc41.jar ];\n          then\n            echo \"Removing old version... (postgresql-9.4-1201.jdbc41.jar)\";\n            rm \"/opt/guacamole/postgresql-hack/postgresql-9.4-1201.jdbc41.jar\";\n            if [ $? -eq 0 ];\n              then\n                echo \"Removed successfully!\";\n              else\n                echo \"Failed to remove.\";\n                exit 1;\n            fi;\n        fi;\n      else\n        echo \"Failed to download.\";\n        exit 1;\n    fi;\nfi;\n"` |  |
| initContainers.3-temp-hack.command[0] | string | `"/bin/sh"` |  |
| initContainers.3-temp-hack.command[1] | string | `"-c"` |  |
| initContainers.3-temp-hack.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| initContainers.3-temp-hack.securityContext.runAsGroup | int | `1001` |  |
| initContainers.3-temp-hack.securityContext.runAsUser | int | `1001` |  |
| initContainers.3-temp-hack.volumeMounts[0].mountPath | string | `"/opt/guacamole/postgresql-hack"` |  |
| initContainers.3-temp-hack.volumeMounts[0].name | string | `"temphack"` |  |
| initContainers.4-temp-hack.args[0] | string | `"echo \"Copying postgres driver into the final destination.\"; cp -r /opt/guacamole/postgresql-hack/* /opt/guacamole/postgresql/; if [ -e /opt/guacamole/postgresql/postgresql-42.2.24.jre7.jar ];\n  then\n    echo \"Driver copied successfully!\";\n  else\n    echo \"Failed to copy the driver\";\nfi;\n"` |  |
| initContainers.4-temp-hack.command[0] | string | `"/bin/sh"` |  |
| initContainers.4-temp-hack.command[1] | string | `"-c"` |  |
| initContainers.4-temp-hack.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| initContainers.4-temp-hack.securityContext.runAsGroup | int | `1001` |  |
| initContainers.4-temp-hack.securityContext.runAsUser | int | `1001` |  |
| initContainers.4-temp-hack.volumeMounts[0].mountPath | string | `"/opt/guacamole/postgresql-hack"` |  |
| initContainers.4-temp-hack.volumeMounts[0].name | string | `"temphack"` |  |
| initContainers.4-temp-hack.volumeMounts[1].mountPath | string | `"/opt/guacamole/postgresql"` |  |
| initContainers.4-temp-hack.volumeMounts[1].name | string | `"temphackalso"` |  |
| json | object | `{}` |  |
| ldap | object | `{}` |  |
| openid | object | `{}` |  |
| persistence.initdbdata.enabled | bool | `true` |  |
| persistence.initdbdata.mountPath | string | `"/initdbdata"` |  |
| persistence.temphack.enabled | bool | `true` |  |
| persistence.temphack.mountPath | string | `"/opt/guacamole/postgresql-hack"` |  |
| persistence.temphackalso.enabled | bool | `true` |  |
| persistence.temphackalso.mountPath | string | `"/opt/guacamole/postgresql"` |  |
| podSecurityContext.runAsGroup | int | `1001` |  |
| podSecurityContext.runAsUser | int | `1001` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"guacamole"` |  |
| postgresql.postgresqlUsername | string | `"guacamole"` |  |
| probes.liveness.path | string | `"/guacamole"` |  |
| probes.readiness.path | string | `"/guacamole"` |  |
| probes.startup.path | string | `"/guacamole"` |  |
| radius | object | `{}` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| service.main.ports.main.port | int | `9998` |  |
| service.main.ports.main.targetPort | int | `8080` |  |
| totp.TOTP_ENABLED | bool | `false` |  |

All Rights Reserved - The TrueCharts Project
