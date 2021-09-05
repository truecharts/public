{{/* Define the configmap */}}
{{- define "sogo.config" -}}
---

apiVersion: v1
kind: Secret
metadata:
  labels:
    {{- include "common.labels" . | nindent 4 }}
  name: dbcreds
{{- $dbprevious := lookup "v1" "Secret" .Release.Namespace "dbcreds" }}
{{- $dbPass := "" }}
data:
{{- if $dbprevious }}
  {{- $dbPass = ( index $dbprevious.data "postgresql-password" ) | b64dec  }}
  postgresql-password: {{ ( index $dbprevious.data "postgresql-password" ) }}
  postgresql-postgres-password: {{ ( index $dbprevious.data "postgresql-postgres-password" ) }}
{{- else }}
  {{- $dbPass = randAlphaNum 50 }}
  postgresql-password: {{ $dbPass | b64enc | quote }}
  postgresql-postgres-password: {{ randAlphaNum 50 | b64enc | quote }}
{{- end }}
  {{- $url := printf "%v%v:%v@%v-%v:%v/%v" "postgresql://" .Values.postgresql.postgresqlUsername $dbPass .Release.Name "postgresql" "5432" .Values.postgresql.postgresqlDatabase  }}
  url: {{ $url | b64enc | quote }}
  plainhost: {{ ( printf "%v-%v" .Release.Name "postgresql" ) | b64enc | quote }}
type: Opaque

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: sogo-config
data:
  sogo.conf: |
    {
      /* *********************  Main SOGo configuration file  **********************
       *                                                                           *
       * Since the content of this file is a dictionary in OpenStep plist format,  *
       * the curly braces enclosing the body of the configuration are mandatory.   *
       * See the Installation Guide for details on the format.                     *
       *                                                                           *
       * C and C++ style comments are supported.                                   *
       *                                                                           *
       * This example configuration contains only a subset of all available        *
       * configuration parameters. Please see the installation guide more details. *
       *                                                                           *
       * ~sogo/GNUstep/Defaults/.GNUstepDefaults has precedence over this file,    *
       * make sure to move it away to avoid unwanted parameter overrides.          *
       *                                                                           *
       * **************************************************************************/

      /* Database configuration (mysql:// or postgresql://) */
      SOGoProfileURL = "{{ $url }}/sogo_user_profile";
      OCSFolderInfoURL = "{{ $url }}/sogo_folder_info";
      OCSSessionsFolderURL = "{{ $url }}/sogo_sessions_folder";

      /* Mail */
      SOGoDraftsFolderName = {{ .Values.sogo.mail.SOGoDraftsFolderName | default "Drafts" }};
      SOGoSentFolderName = {{ .Values.sogo.mail.SOGoSentFolderName | default "Sent" }};
      SOGoTrashFolderName = {{ .Values.sogo.mail.SOGoTrashFolderName | default "Trash" }};
      SOGoIMAPServer = {{ .Values.sogo.mail.SOGoIMAPServer | default "localhost" }};
{{- if .Values.sogo.mail.SOGoSieveServer}}
      SOGoSieveServer = {{ .Values.sogo.mail.SOGoSieveServer | default "sieve://127.0.0.1:4190" }};
{{- end }}
      SOGoMailDomain = {{ .Values.sogo.mail.SOGoMailDomain | default "acme.com" }};
      SOGoMailingMechanism = {{ .Values.sogo.mail.SOGoMailingMechanism | default "smtp" }};
{{- if eq .Values.sogo.mail.SOGoMailingMechanism "smtp" }}
      SOGoSMTPServer = {{ .Values.sogo.mail.SOGoSMTPServer | default "smtp://domain:port/?tls=YES" }};
{{- end }}
      SOGoForceExternalLoginWithEmail = {{ if .Values.sogo.mail.SOGoForceExternalLoginWithEmail }}"YES"{{ else }}"NO"{{ end }};
      SOGoMailSpoolPath = {{ ( .Values.sogo.mail.SOGoMailSpoolPath | default "/var/spool/sogo") | quote }};
      NGMimeBuildMimeTempDirectory = {{ ( .Values.sogo.mail.NGMimeBuildMimeTempDirectory | default "/mimetmp") | quote }};

      /* Notifications */
      SOGoAppointmentSendEMailNotifications = {{ if .Values.sogo.notifications.SOGoAppointmentSendEMailNotifications }}"YES"{{ else }}"NO"{{ end }};
      SOGoACLsSendEMailNotifications = {{ if .Values.sogo.notifications.SOGoACLsSendEMailNotifications }}"YES"{{ else }}"NO"{{ end }};
      SOGoFoldersSendEMailNotifications = {{ if .Values.sogo.notifications.SOGoFoldersSendEMailNotifications }}"YES"{{ else }}"NO"{{ end }};

      /* Authentication */
      SOGoPasswordChangeEnabled = {{ if .Values.sogo.auth.SOGoPasswordChangeEnabled }}"YES"{{ else }}"NO"{{ end }};

      /* User Sources */
{{- if .Values.sogo.usersources }}
      SOGoUserSources = (
  {{- range $index, $value := .Values.sogo.usersources }}
        {
      type = {{ $value.type | default "ldap" }};
    {{- if eq $value.type "ldap" }}
      CNFieldName = {{ $value.CNFieldName | default "cn" }};
      UIDFieldName = {{ $value.UIDFieldName | default "uid" }};
      IDFieldName = {{ $value.IDFieldName | default "uid" }}; // first field of the DN for direct binds
      bindFields = {{ $value.bindFields | default "(uid, mail)" }}; // array of fields to use for indirect binds
      baseDN = {{ ( $value.baseDN | default "ou=users,dc=acme,dc=com" ) | quote }};
      bindDN = {{ ( $value.bindDN | default "uid=sogo,ou=users,dc=acme,dc=com" ) | quote }};
      bindPassword = {{ $value.bindPassword | default "qwerty" }};
      canAuthenticate = {{ if $value.canAuthenticate }}"YES"{{ else }}"NO"{{ end }};
      displayName = {{ ( $value.displayName | default "Shared Addresses" ) | quote }};
      hostname = {{ $value.hostname | default "ldap://127.0.0.1:389" }};
      id = {{ $value.id | default "public" }};
      isAddressBook = {{ if $value.isAddressBook }}"YES"{{ else }}"NO"{{ end }};
    {{- else if eq $value.type "sql"  }}
      id = {{ $value.sql.id | default "directory" }};
      viewURL = {{ ( $value.sql.viewURL | default "postgresql://sogo:sogo@127.0.0.1:5432/sogo/sogo_view" ) | quote }};
      canAuthenticate = {{ if $value.sql.canAuthenticate }}"YES"{{ else }}"NO"{{ end }};
      isAddressBook = {{ if $value.sql.isAddressBook }}"YES"{{ else }}"NO"{{ end }};
      userPasswordAlgorithm = {{ $value.sql.userPasswordAlgorithm | default "md5" }};
    {{- end }}
    {{- range $value.custom }}
      {{ .name }} = {{ .value }};
    {{- end }}
    {{- if $index }}
      }
    {{- else }}
      },
    {{- end }}
  {{- end }}
      );
{{- end }}

      /* Web Interface */
      SOGoPageTitle = {{ .Values.sogo.webui.SOGoPageTitle | default "SOGo" }};
      SOGoVacationEnabled = {{ if .Values.sogo.webui.SOGoVacationEnabled }}"YES"{{ else }}"NO"{{ end }};
      SOGoForwardEnabled = {{ if .Values.sogo.webui.SOGoForwardEnabled }}"YES"{{ else }}"NO"{{ end }};
      SOGoSieveScriptsEnabled = {{ if .Values.sogo.webui.SOGoSieveScriptsEnabled }}"YES"{{ else }}"NO"{{ end }};
      SOGoMailAuxiliaryUserAccountsEnabled = {{ if .Values.sogo.webui.SOGoMailAuxiliaryUserAccountsEnabled }}"YES"{{ else }}"NO"{{ end }};
      SOGoTrustProxyAuthentication = {{ if .Values.sogo.webui.SOGoTrustProxyAuthentication }}"YES"{{ else }}"NO"{{ end }};
      SOGoXSRFValidationEnabled = {{ if .Values.sogo.webui.SOGoXSRFValidationEnabled }}"YES"{{ else }}"NO"{{ end }};

      /* General - SOGoTimeZone *MUST* be defined */
      SOGoLanguage = {{ .Values.sogo.general.SOGoLanguage | default "English" }};
      SOGoTimeZone = {{ .Values.env.TZ | default "America/Montreal" }};
      SOGoSuperUsernames = ({{ .Values.sogo.general.SOGoSuperUsernames | default "" }}); // This is an array - keep the parens!
      SxVMemLimit = {{ .Values.sogo.general.SxVMemLimit | default "384" }};
      SOGoMemcachedHost = {{ ( printf "%v-%v" .Release.Name "memcached" ) | quote }};

      /* Debug */
      SOGoDebugRequests = {{ if .Values.sogo.debug.SOGoDebugRequests }}"YES"{{ else }}"NO"{{ end }};
      SoDebugBaseURL = {{ if .Values.sogo.debug.SoDebugBaseURL }}"YES"{{ else }}"NO"{{ end }};
      ImapDebugEnabled = {{ if .Values.sogo.debug.ImapDebugEnabled }}"YES"{{ else }}"NO"{{ end }};
      LDAPDebugEnabled = {{ if .Values.sogo.debug.LDAPDebugEnabled }}"YES"{{ else }}"NO"{{ end }};
      PGDebugEnabled = {{ if .Values.sogo.debug.PGDebugEnabled }}"YES"{{ else }}"NO"{{ end }};
      MySQL4DebugEnabled = {{ if .Values.sogo.debug.MySQL4DebugEnabled }}"YES"{{ else }}"NO"{{ end }};
      SOGoUIxDebugEnabled = {{ if .Values.sogo.debug.SOGoUIxDebugEnabled }}"YES"{{ else }}"NO"{{ end }};
      WODontZipResponse = {{ if .Values.sogo.debug.WODontZipResponse }}"YES"{{ else }}"NO"{{ end }};
      WOLogFile = {{ ( .Values.sogo.debug.WOLogFile | default "/var/log/sogo/sogo.log" ) | quote }};
    }

    /* Custom Arguments added by user */
    {{- range .Values.sogo.custom }}
      {{ .name }} = {{ .value }};
    {{- end }}

{{- end -}}
