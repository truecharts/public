# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| access_control.default_policy | string | `"deny"` |  |
| access_control.networks | list | `[]` |  |
| access_control.rules | list | `[]` |  |
| args[0] | string | `"--config=/configuration.yaml"` |  |
| authentication_backend.disable_reset_password | bool | `false` |  |
| authentication_backend.file.enabled | bool | `true` |  |
| authentication_backend.file.password.algorithm | string | `"argon2id"` |  |
| authentication_backend.file.password.iterations | int | `1` |  |
| authentication_backend.file.password.key_length | int | `32` |  |
| authentication_backend.file.password.memory | int | `1024` |  |
| authentication_backend.file.password.parallelism | int | `8` |  |
| authentication_backend.file.password.salt_length | int | `16` |  |
| authentication_backend.file.path | string | `"/config/users_database.yml"` |  |
| authentication_backend.ldap.additional_groups_dn | string | `"OU=Groups"` |  |
| authentication_backend.ldap.additional_users_dn | string | `"OU=Users"` |  |
| authentication_backend.ldap.base_dn | string | `"DC=example,DC=com"` |  |
| authentication_backend.ldap.display_name_attribute | string | `""` |  |
| authentication_backend.ldap.enabled | bool | `false` |  |
| authentication_backend.ldap.group_name_attribute | string | `""` |  |
| authentication_backend.ldap.groups_filter | string | `""` |  |
| authentication_backend.ldap.implementation | string | `"activedirectory"` |  |
| authentication_backend.ldap.mail_attribute | string | `""` |  |
| authentication_backend.ldap.plain_password | string | `""` |  |
| authentication_backend.ldap.start_tls | bool | `false` |  |
| authentication_backend.ldap.timeout | string | `"5s"` |  |
| authentication_backend.ldap.tls.minimum_version | string | `"TLS1.2"` |  |
| authentication_backend.ldap.tls.server_name | string | `""` |  |
| authentication_backend.ldap.tls.skip_verify | bool | `false` |  |
| authentication_backend.ldap.url | string | `"ldap://openldap.default.svc.cluster.local"` |  |
| authentication_backend.ldap.user | string | `"CN=Authelia,DC=example,DC=com"` |  |
| authentication_backend.ldap.username_attribute | string | `""` |  |
| authentication_backend.ldap.users_filter | string | `""` |  |
| authentication_backend.refresh_interval | string | `"5m"` |  |
| command[0] | string | `"authelia"` |  |
| default_redirection_url | string | `""` |  |
| domain | string | `"example.com"` |  |
| duo_api.enabled | bool | `false` |  |
| duo_api.hostname | string | `"api-123456789.example.com"` |  |
| duo_api.integration_key | string | `"ABCDEF"` |  |
| duo_api.plain_api_key | string | `""` |  |
| enableServiceLinks | bool | `false` |  |
| envFrom[0].configMapRef.name | string | `"authelia-paths"` |  |
| identity_providers.oidc.access_token_lifespan | string | `"1h"` |  |
| identity_providers.oidc.authorize_code_lifespan | string | `"1m"` |  |
| identity_providers.oidc.clients | list | `[]` |  |
| identity_providers.oidc.enable_client_debug_messages | bool | `false` |  |
| identity_providers.oidc.enabled | bool | `false` |  |
| identity_providers.oidc.id_token_lifespan | string | `"1h"` |  |
| identity_providers.oidc.minimum_parameter_entropy | int | `8` |  |
| identity_providers.oidc.refresh_token_lifespan | string | `"90m"` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/authelia/authelia"` |  |
| image.tag | string | `"4.32.2@sha256:4c46e56d219424542349fee05b643d854ab74df7a10207dc247dd36366ecfc25"` |  |
| log.format | string | `"text"` |  |
| log.level | string | `"trace"` |  |
| notifier.disable_startup_check | bool | `false` |  |
| notifier.filesystem.enabled | bool | `true` |  |
| notifier.filesystem.filename | string | `"/config/notification.txt"` |  |
| notifier.smtp.disable_html_emails | bool | `false` |  |
| notifier.smtp.disable_require_tls | bool | `false` |  |
| notifier.smtp.enabled | bool | `false` |  |
| notifier.smtp.enabledSecret | bool | `false` |  |
| notifier.smtp.host | string | `"smtp.mail.svc.cluster.local"` |  |
| notifier.smtp.identifier | string | `"localhost"` |  |
| notifier.smtp.plain_password | string | `"test"` |  |
| notifier.smtp.port | int | `25` |  |
| notifier.smtp.sender | string | `"admin@example.com"` |  |
| notifier.smtp.startup_check_address | string | `"test@authelia.com"` |  |
| notifier.smtp.subject | string | `"[Authelia] {title}"` |  |
| notifier.smtp.timeout | string | `"5s"` |  |
| notifier.smtp.tls.minimum_version | string | `"TLS1.2"` |  |
| notifier.smtp.tls.server_name | string | `""` |  |
| notifier.smtp.tls.skip_verify | bool | `false` |  |
| notifier.smtp.username | string | `"test"` |  |
| persistence.config.enabled | bool | `true` |  |
| persistence.config.mountPath | string | `"/config"` |  |
| postgresql.enabled | bool | `true` |  |
| postgresql.existingSecret | string | `"dbcreds"` |  |
| postgresql.postgresqlDatabase | string | `"authelia"` |  |
| postgresql.postgresqlUsername | string | `"authelia"` |  |
| probes.liveness.path | string | `"/api/health\""` |  |
| probes.liveness.type | string | `"HTTP"` |  |
| probes.readiness.path | string | `"/api/health"` |  |
| probes.readiness.type | string | `"HTTP"` |  |
| probes.startup.path | string | `"/api/health"` |  |
| probes.startup.type | string | `"HTTP"` |  |
| redis.enabled | bool | `true` |  |
| redis.existingSecret | string | `"rediscreds"` |  |
| redisProvider.database_index | int | `0` |  |
| redisProvider.high_availability.enabled | bool | `false` |  |
| redisProvider.high_availability.enabledSecret | bool | `false` |  |
| redisProvider.high_availability.nodes | list | `[]` |  |
| redisProvider.high_availability.route_by_latency | bool | `false` |  |
| redisProvider.high_availability.route_randomly | bool | `false` |  |
| redisProvider.high_availability.sentinel_name | string | `"mysentinel"` |  |
| redisProvider.maximum_active_connections | int | `8` |  |
| redisProvider.minimum_idle_connections | int | `0` |  |
| redisProvider.port | int | `6379` |  |
| redisProvider.tls.enabled | bool | `false` |  |
| redisProvider.tls.minimum_version | string | `"TLS1.2"` |  |
| redisProvider.tls.server_name | string | `""` |  |
| redisProvider.tls.skip_verify | bool | `false` |  |
| redisProvider.username | string | `""` |  |
| regulation.ban_time | string | `"5m"` |  |
| regulation.find_time | string | `"2m"` |  |
| regulation.max_retries | int | `3` |  |
| resources.limits | object | `{}` |  |
| resources.requests | object | `{}` |  |
| server.path | string | `""` |  |
| server.port | int | `9091` |  |
| server.read_buffer_size | int | `4096` |  |
| server.write_buffer_size | int | `4096` |  |
| service.main.ports.main.port | int | `9091` |  |
| service.main.ports.main.targetPort | int | `9091` |  |
| session.expiration | string | `"1h"` |  |
| session.inactivity | string | `"5m"` |  |
| session.name | string | `"authelia_session"` |  |
| session.remember_me_duration | string | `"1M"` |  |
| session.same_site | string | `"lax"` |  |
| storage.postgres.database | string | `"authelia"` |  |
| storage.postgres.port | int | `5432` |  |
| storage.postgres.sslmode | string | `"disable"` |  |
| storage.postgres.timeout | string | `"5s"` |  |
| storage.postgres.username | string | `"authelia"` |  |
| theme | string | `"light"` |  |
| totp.issuer | string | `""` |  |
| totp.period | int | `30` |  |
| totp.skew | int | `1` |  |

All Rights Reserved - The TrueCharts Project
