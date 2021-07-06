{{/* Define the configmap */}}
{{- define "openldap.configmap" -}}

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: openldapconfig
data:
  LDAP_TLS_CRT_FILENAME: "tls.crt"
  LDAP_TLS_KEY_FILENAME: "tls.key"
  LDAP_TLS_DH_PARAM_FILENAME: "dhparam.pem"
  LDAP_TLS_CA_CRT_FILENAME: "ca.crt"
{{- if .Values.replication.enabled }}
  LDAP_REPLICATION: "true"
  LDAP_REPLICATION_CONFIG_SYNCPROV: "binddn=\"cn=admin,cn=config\" bindmethod=simple credentials=$LDAP_CONFIG_PASSWORD searchbase=\"cn=config\" type=refreshAndPersist retry=\"{{.Values.replication.retry }} +\" timeout={{.Values.replication.timeout }} starttls={{.Values.replication.starttls }} tls_reqcert={{.Values.replication.tls_reqcert }}"
  LDAP_REPLICATION_DB_SYNCPROV: "binddn=\"cn=admin,$LDAP_BASE_DN\" bindmethod=simple credentials=$LDAP_ADMIN_PASSWORD searchbase=\"$LDAP_BASE_DN\" type=refreshAndPersist interval={{.Values.replication.interval }} retry=\"{{.Values.replication.retry }} +\" timeout={{.Values.replication.timeout }} starttls={{.Values.replication.starttls }} tls_reqcert={{.Values.replication.tls_reqcert }}"
  LDAP_REPLICATION_HOSTS: "#PYTHON2BASH:[{{ template "replicalist" . }}]"
{{- end }}

{{- end -}}
