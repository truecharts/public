# Default Helm-Values

TrueCharts is primarily build to supply TrueNAS SCALE Apps.
However, we also supply all Apps as standard Helm-Charts. In this document we aim to document the default values in our values.yaml file.

Most of our Apps also consume our "common" Helm Chart.
If this is the case, this means that all values.yaml values are set to the common chart values.yaml by default. This values.yaml file will only contain values that deviate from the common chart.
You will, however, be able to use all values referenced in the common chart here, besides the values listed in this document.

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.repository | string | `"ghcr.io/truecharts/sogo"` |  |
| image.tag | string | `"v5.2.0"` |  |
| initContainers | object | `{"init-postgresdb":{"command":["sh","-c","until pg_isready -U sogo -h ${pghost} ; do sleep 2 ; done"],"env":[{"name":"pghost","valueFrom":{"secretKeyRef":{"key":"plainhost","name":"dbcreds"}}}],"image":"postgres:13.1","imagePullPolicy":"IfNotPresent"}}` | initcontainers |
| initContainers.init-postgresdb | object | `{"command":["sh","-c","until pg_isready -U sogo -h ${pghost} ; do sleep 2 ; done"],"env":[{"name":"pghost","valueFrom":{"secretKeyRef":{"key":"plainhost","name":"dbcreds"}}}],"image":"postgres:13.1","imagePullPolicy":"IfNotPresent"}` | wait for database before starting sogo |
| memcached | object | `{"enabled":true}` | memcached dependency settings |
| persistence | object | `{"data":{"accessMode":"ReadWriteOnce","enabled":true,"mountPath":"/data/conf/sogo/","size":"100Gi","type":"pvc"},"drafts":{"accessMode":"ReadWriteOnce","enabled":true,"mountPath":"/var/spool/sogo","size":"100Gi","type":"pvc"},"mimetmp":{"enabled":true,"mountPath":"/mimetmp","type":"emptyDir"}}` | persistence settings |
| postgresql | object | `{"enabled":true,"existingSecret":"dbcreds","postgresqlDatabase":"sogo","postgresqlUsername":"sogo"}` | postgres dependency settings |
| service | object | `{"main":{"ports":{"main":{"port":80}}}}` | services |
| sogo | object | `{"auth":{"SOGoPasswordChangeEnabled":true},"custom":[],"debug":{"ImapDebugEnabled":false,"LDAPDebugEnabled":false,"MySQL4DebugEnabled":false,"PGDebugEnabled":false,"SOGoDebugRequests":false,"SOGoUIxDebugEnabled":false,"SoDebugBaseURL":false,"WODontZipResponse":false,"WOLogFile":"/var/log/sogo/sogo.log"},"general":{"SOGoLanguage":"English","SOGoSuperUsernames":"","SxVMemLimit":"384"},"mail":{"NGMimeBuildMimeTempDirectory":"/mimetmp","SOGoDraftsFolderName":"Drafts","SOGoForceExternalLoginWithEmail":false,"SOGoIMAPServer":"localhost","SOGoMailDomain":"example.com","SOGoMailSpoolPath":"/var/spool/sogo","SOGoMailingMechanism":"smtp","SOGoSMTPServer":"smtp://domain:port","SOGoSentFolderName":"Sent","SOGoSieveServer":"","SOGoTrashFolderName":"Trash"},"notifications":{"SOGoACLsSendEMailNotifications":false,"SOGoAppointmentSendEMailNotifications":false,"SOGoFoldersSendEMailNotifications":false},"usersources":[],"webui":{"SOGoForwardEnabled":true,"SOGoMailAuxiliaryUserAccountsEnabled":true,"SOGoPageTitle":"SOGo","SOGoSieveScriptsEnabled":true,"SOGoTrustProxyAuthentication":false,"SOGoVacationEnabled":true,"SOGoXSRFValidationEnabled":true}}` | Sogo settings |
| sogo.auth | object | `{"SOGoPasswordChangeEnabled":true}` | Pre-configured Sogo authentication settings |
| sogo.custom | list | `[]` | custom Sogo setting arguments |
| sogo.debug | object | `{"ImapDebugEnabled":false,"LDAPDebugEnabled":false,"MySQL4DebugEnabled":false,"PGDebugEnabled":false,"SOGoDebugRequests":false,"SOGoUIxDebugEnabled":false,"SoDebugBaseURL":false,"WODontZipResponse":false,"WOLogFile":"/var/log/sogo/sogo.log"}` | Pre-configured Sogo debug settings |
| sogo.general | object | `{"SOGoLanguage":"English","SOGoSuperUsernames":"","SxVMemLimit":"384"}` | Pre-configured general Sogo settings |
| sogo.mail | object | `{"NGMimeBuildMimeTempDirectory":"/mimetmp","SOGoDraftsFolderName":"Drafts","SOGoForceExternalLoginWithEmail":false,"SOGoIMAPServer":"localhost","SOGoMailDomain":"example.com","SOGoMailSpoolPath":"/var/spool/sogo","SOGoMailingMechanism":"smtp","SOGoSMTPServer":"smtp://domain:port","SOGoSentFolderName":"Sent","SOGoSieveServer":"","SOGoTrashFolderName":"Trash"}` | Pre-configured Sogo mail settings |
| sogo.notifications | object | `{"SOGoACLsSendEMailNotifications":false,"SOGoAppointmentSendEMailNotifications":false,"SOGoFoldersSendEMailNotifications":false}` | Pre-configured Sogo notifications settings |
| sogo.usersources | list | `[]` | Sogo usersources |
| sogo.webui | object | `{"SOGoForwardEnabled":true,"SOGoMailAuxiliaryUserAccountsEnabled":true,"SOGoPageTitle":"SOGo","SOGoSieveScriptsEnabled":true,"SOGoTrustProxyAuthentication":false,"SOGoVacationEnabled":true,"SOGoXSRFValidationEnabled":true}` | Pre-configured Sogo webui settings |

All Rights Reserved - The TrueCharts Project
