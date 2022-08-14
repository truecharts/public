{{/* Define the configmap */}}
{{- define "openkm.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "tc.common.names.fullname" . }}-init
data:
  init.sh: |-
    #!/bin/sh
    mkdir /opt/tomcat/conf || echo "cannot create conf folder, most likely it already exists..."
    if [ ! -f "/config/OpenKM.cfg.default" ]; then
      cp /config/init/OpenKM.cfg.default /opt/tomcat/OpenKM.cfg
    fi
    if [ ! -f "/config/server.xml.default" ]; then
      cp /config/init/server.xml.default /opt/tomcat/conf/server.xml
    fi

  OpenKM.cfg.default: |-
    # OpenKM Hibernate configuration values
    hibernate.dialect=org.hibernate.dialect.PostgreSQLDialect
    hibernate.hbm2ddl=create

    # Logback configuration file
    logback.config=logback.xml
  server.xml.default: |-
    <?xml version='1.0' encoding='utf-8'?>
    <Server port="8005" shutdown="SHUTDOWN">
      <Listener className="org.apache.catalina.startup.VersionLoggerListener" />
      <!--APR library loader. Documentation at /docs/apr.html -->
      <Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />
      <!-- Prevent memory leaks due to use of particular java/javax APIs-->
      <Listener className="org.apache.catalina.core.JreMemoryLeakPreventionListener" />
      <Listener className="org.apache.catalina.mbeans.GlobalResourcesLifecycleListener" />
      <Listener className="org.apache.catalina.core.ThreadLocalLeakPreventionListener" />

      <!-- Global JNDI resources -->
      <GlobalNamingResources>
        <!-- Editable user database that can also be used by
             UserDatabaseRealm to authenticate users
        -->
        <Resource name="UserDatabase" auth="Container"
                  type="org.apache.catalina.UserDatabase"
                  description="User database that can be updated and saved"
                  factory="org.apache.catalina.users.MemoryUserDatabaseFactory"
                  pathname="conf/tomcat-users.xml" />

        <Resource name="jdbc/OpenKMDS" auth="Container" type="javax.sql.DataSource"
                   maxActive="100" maxIdle="30" maxWait="10000" validationQuery="select 1"
                   username="{{ .Values.postgresql.postgresqlDatabase }}" password={{ .Values.postgresql.postgresqlPassword }} driverClassName="org.postgresql.Driver"
                   url="jdbc:postgresql://{{ .Values.postgresql.url.plain | trimAll "\"" }}:5432/{{ .Values.postgresql.postgresqlDatabase }}"/>

        <Resource name="mail/OpenKM" auth="Container" type="javax.mail.Session"
                  mail.smtp.host="localhost" mail.from="noreply@openkm.com"/>

      </GlobalNamingResources>

      <!-- A "Service" is a collection of one or more "Connectors" that share
           a single "Container" Note:  A "Service" is not itself a "Container",
           so you may not define subcomponents such as "Valves" at this level.
           Documentation at /docs/config/service.html
       -->
      <Service name="Catalina">
        <Connector port="8080" address="0.0.0.0" protocol="HTTP/1.1" connectionTimeout="20000" redirectPort="8443" />

        <!-- Define an AJP 1.3 Connector on port 8009 -->
        <Connector port="8009" address="127.0.0.1" protocol="AJP/1.3" redirectPort="8443" />

        <Engine name="Catalina" defaultHost="localhost">
          <!-- Use the LockOutRealm to prevent attempts to guess user passwords via a brute-force attack -->
          <Realm className="org.apache.catalina.realm.LockOutRealm">
            <!-- This Realm uses the UserDatabase configured in the global JNDI
                 resources under the key "UserDatabase".  Any edits
                 that are performed against this UserDatabase are immediately
                 available for use by the Realm.  -->
            <Realm className="org.apache.catalina.realm.UserDatabaseRealm"
                   resourceName="UserDatabase"/>
          </Realm>

          <Host name="localhost"  appBase="webapps" unpackWARs="true" autoDeploy="true">
            <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
                   prefix="localhost_access_log" suffix=".txt"
                   pattern="%h %l %u %t &quot;%r&quot; %s %b" />

            <!-- External resources -->
            <!-- <Context docBase="${catalina.home}/custom" path="/OpenKM/custom" reloadable="true"/> -->
          </Host>
        </Engine>
      </Service>
    </Server>

{{- end -}}
