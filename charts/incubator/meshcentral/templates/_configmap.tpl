{{/* Define the configmap */}}
{{- define "meshcentral.configmap" -}}
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "common.names.fullname" . }}-init
data:
  init.sh: |-
    #!/bin/sh
    if test -f "/opt/meshcentral/meshcentral-data/config.json"; then
      echo "config.json exists."
    else
        cp /opt/meshcentral/config.json.template /opt/meshcentral/meshcentral-data/config.json
        sed -i "s/\"cert\": \"myserver.mydomain.com\"/\"cert\": \"$HOSTNAME\"/" /opt/meshcentral/meshcentral-data/config.json
        sed -i "s/\"NewAccounts\": true/\"NewAccounts\": \"$ALLOW_NEW_ACCOUNTS\"/" /opt/meshcentral/meshcentral-data/config.json
        sed -i "s/\"enabled\": false/\"enabled\": \"$ALLOWPLUGINS\"/" /opt/meshcentral/meshcentral-data/config.json
        sed -i "s/\"localSessionRecording\": false/\"localSessionRecording\": \"$LOCALSESSIONRECORDING\"/" /opt/meshcentral/meshcentral-data/config.json
        sed -i "s/\"minify\": true/\"minify\": \"$MINIFY\"/" /opt/meshcentral/meshcentral-data/config.json
        sed -i "s/\"WebRTC\": false/\"WebRTC\": \"$WEBRTC\"/" /opt/meshcentral/meshcentral-data/config.json
        sed -i "s/\"AllowFraming\": false/\"AllowFraming\": \"$IFRAME\"/" /opt/meshcentral/meshcentral-data/config.json
        if [ "$REVERSE_PROXY" != "false" ]
            then 
                sed -i "s/\"_certUrl\": \"my\.reverse\.proxy\"/\"certUrl\": \"https:\/\/$REVERSE_PROXY:$REVERSE_PROXY_TLS_PORT\"/" /opt/meshcentral/meshcentral-data/config.json
                exit
  config.json.template: |-
      {
      "$schema": "http://info.meshcentral.com/downloads/meshcentral-config-schema.json",
      "settings": {
        "plugins":{"enabled": false},
        "cert": "myserver.mydomain.com",
        "_WANonly": true,
        "_LANonly": true,
        "_sessionKey": "MyReallySecretPassword1",
        "port": 443,
        "_aliasPort": 443,
        "redirPort": 80,
        "_redirAliasPort": 80,
        "AgentPong": 300,
        "TLSOffload": false,
        "SelfUpdate": false,
        "AllowFraming": false,
        "WebRTC": false,
        "mongodbcol": "meshcentral",
        "mongodb": {{ ( printf "%s?client_encoding=utf8" ( .Values.mongodb.url.complete | trimAll "\"" ) ) | quote }}
      },
      "domains": {
      "": {
      "_title": "MyServer",
        "_title2": "Servername",
        "minify": true,
        "NewAccounts": true,
        "localSessionRecording": false,
      "_userNameIsEmail": true,
        "_certUrl": "my.reverse.proxy"
      }
      },
      "_letsencrypt": {
        "__comment__": "Requires NodeJS 8.x or better, Go to https://letsdebug.net/ first before>",
        "_email": "myemail@mydomain.com",
        "_names": "myserver.mydomain.com",
      "production": false
      }
    }

{{- end -}}
