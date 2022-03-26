# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.MAX_UPLOAD | int | `5000` |  |
| env.PHP_MAX_FILE_UPLOAD | int | `200` |  |
| env.PHP_MEMORY_LIMIT | string | `"512M"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/projectsend"` |  |
| image.tag | string | `"v2021.12.10"` |  |
| installContainers.initconfig.args[0] | string | `"export configFile=\"/config/projectsend/sys.config.php\"; if [ ! -f $configFile ]; then\n  echo \"Creating initial config file...\";\n  mkdir -p /config/projectsend\n  touch $configFile;\n  echo \"<?php\" >> $configFile\n  echo \"# This is generated on initial setup of this TrueCharts App\" >> $configFile;\n  echo \"# Do not change below values, or DB connection will fail.\" >> $configFile\n  echo \"define('DB_DRIVER', 'mysql');\" >> $configFile;\n  echo \"define('DB_NAME', '$DBNAME');\" >> $configFile;\n  echo \"define('DB_HOST', '$DBHOST');\" >> $configFile;\n  echo \"define('DB_USER', '$DBUSER');\" >> $configFile;\n  echo \"define('DB_PASSWORD', '$DBPASS');\" >> $configFile;\n  echo \"define('TABLES_PREFIX', 'tbl_');\" >> $configFile;\n  echo \"# You can manually change below values if you like.\" >> $configFile\n  echo \"define('SITE_LANG', 'en');\" >> $configFile;\n  echo \"define('MAX_FILESIZE',2048);\" >> $configFile;\n  echo \"define('EMAIL_ENCODING', 'utf-8');\" >> $configFile;\n  echo \"define('DEBUG', false);\" >> $configFile;\n  echo \"# End of generated config values.\" >> $configFile;\n  echo \"Done!\";\nelse\n  echo \"Initial config file already exists. Skipping...\";\nfi;\n"` |  |
| installContainers.initconfig.command[0] | string | `"/bin/sh"` |  |
| installContainers.initconfig.command[1] | string | `"-c"` |  |
| installContainers.initconfig.env[0].name | string | `"DBNAME"` |  |
| installContainers.initconfig.env[0].value | string | `"{{ .Values.mariadb.mariadbDatabase }}"` |  |
| installContainers.initconfig.env[1].name | string | `"DBUSER"` |  |
| installContainers.initconfig.env[1].value | string | `"{{ .Values.mariadb.mariadbUsername }}"` |  |
| installContainers.initconfig.env[2].name | string | `"DBPASS"` |  |
| installContainers.initconfig.env[2].valueFrom.secretKeyRef.key | string | `"mariadb-password"` |  |
| installContainers.initconfig.env[2].valueFrom.secretKeyRef.name | string | `"mariadbcreds"` |  |
| installContainers.initconfig.env[3].name | string | `"DBHOST"` |  |
| installContainers.initconfig.env[3].valueFrom.secretKeyRef.key | string | `"plainhost"` |  |
| installContainers.initconfig.env[3].valueFrom.secretKeyRef.name | string | `"mariadbcreds"` |  |
| installContainers.initconfig.image | string | `"{{ .Values.image.repository }}:{{ .Values.image.tag }}"` |  |
| installContainers.initconfig.volumeMounts[0].mountPath | string | `"/config"` |  |
| installContainers.initconfig.volumeMounts[0].name | string | `"config"` |  |
| mariadb.enabled | bool | `true` |  |
| mariadb.existingSecret | string | `"mariadbcreds"` |  |
| mariadb.mariadbDatabase | string | `"projectsend"` |  |
| mariadb.mariadbUsername | string | `"projectsend"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/data"` |  |
| persistence.varrun.enabled | bool | `true` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10127` |  |
| service.main.ports.main.targetPort | int | `80` |  |

All Rights Reserved - The TrueCharts Project
