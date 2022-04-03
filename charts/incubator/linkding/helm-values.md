# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| env.LD_DISABLE_BACKGROUND_TASKS | bool | `false` |  |
| env.LD_DISABLE_URL_VALIDATION | bool | `false` |  |
| env.LD_REQUEST_TIMEOUT | int | `60` |  |
| env.LD_SERVER_PORT | string | `"{{ .Values.service.main.ports.main.port }}"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"tccr.io/truecharts/linkding"` |  |
| image.tag | string | `"v1.8.8@sha256:c5a15b48ef46e409d6d0fe0552280611bcbb148e5311f4ed0e9e12d2360e6578"` |  |
| lifecycle.postStart.exec.command[0] | string | `"/bin/bash"` |  |
| lifecycle.postStart.exec.command[1] | string | `"-c"` |  |
| lifecycle.postStart.exec.command[2] | string | `"if [ -f /etc/linkding/data/.superuser_exists ]; then\n  echo \"Superuser has been created before. Skipping...\";\nelse\n  echo \"Creating superuser...\";\n  export status=99;\n  until [ $status -eq 0 ];\n  do\n    python manage.py createsuperuser --username=${DJANGO_SUPERUSER_USERNAME} --email=${DJANGO_SUPERUSER_EMAIL} --noinput;\n    status=$?;\n    sleep 3;\n  done;\n  echo \"This file is to ensure that init script won't try to create a superuser again and fail because it already exsits\" > /etc/linkding/data/.superuser_exists;\n  echo \"Superuser Created!\";\nfi;\n"` |  |
| persistence.data.enabled | bool | `true` |  |
| persistence.data.mountPath | string | `"/etc/linkding/data"` |  |
| podSecurityContext.runAsGroup | int | `0` |  |
| podSecurityContext.runAsUser | int | `0` |  |
| secret.DJANGO_SUPERUSER_EMAIL | string | `"super@example.com"` |  |
| secret.DJANGO_SUPERUSER_PASSWORD | string | `"somesecret"` |  |
| secret.DJANGO_SUPERUSER_USERNAME | string | `"superuser"` |  |
| securityContext.readOnlyRootFilesystem | bool | `false` |  |
| securityContext.runAsNonRoot | bool | `false` |  |
| service.main.ports.main.port | int | `10210` |  |

All Rights Reserved - The TrueCharts Project
