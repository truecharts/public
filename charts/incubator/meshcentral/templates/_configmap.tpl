{{/* Define the configmap */}}
{{- define "meshcentral.configmap" -}}

{{- $settings_mongoDB := .Values.mongodb.url }}
{{- $settings_port := .Values.service.main.ports.main.port }}

{{- $settings_cert := .Values.mesh.settings_cert }}
{{- $settings_webRTC := .Values.mesh.settings_webRTC }}
{{- $settings_plugins_enabled := .Values.mesh.settings_plugins_enabled }}
{{- $settings_allowFraming := .Values.mesh.settings_allowFraming }}

{{- $settings_domains_title := .Values.mesh.settings_domains_title }}
{{- $settings_domains_title2 := .Values.mesh.settings_domains_title2 }}
{{- $settings_domains_newAccounts := .Values.mesh.settings_domains_newAccounts }}
{{- $settings_domains_minify := .Values.mesh.settings_domains_minify }}
{{- $settings_domains_localSessionRecording := .Values.mesh.settings_domains_localSessionRecording }}
{{- if .Values.mesh.settings_domains_certUrl }}
  {{- $settings_domains_certUrl := "\"certUrl\": \"%v\"" .Values.mesh.settings_domains_certUrl }}
{{- else }}
  {{- $settings_domains_certUrl := "\"_certUrl\": \"https://localhost:443/\"" }}
{{- end -}}

---
apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ include "common.names.fullname" . }}-init
  labels:
    {{- include "common.labels" . | nindent 4 }}
data:
  config.json.template: |-
      {
        "$schema": "http://info.meshcentral.com/downloads/meshcentral-config-schema.json",
        "__comment__": "This is a sample configuration file, all values and sections that start with underscore (_) are ignored. Edit a section and remove the _ in front of the name. Refer to the user's guide for details.",
        "settings": {
          "cert": "$settings_cert",
          "mongoDb": "$settings_mongoDB",
          "port": $settings_port,
          "allowFraming": $settings_allowFraming,
          "webRTC": $settings_webRTC,
          "watchDog": { "interval": 100, "timeout": 400 },
          "plugins": { "enabled": $settings_plugins_enabled }
        },
        "domains": {
          "": {
            "_siteStyle": 2,
            "title": "$settings_domains_title",
            "title2": "$settings_domains_title2",
            "minify": $settings_domains_minify,
            "newAccounts": $settings_domains_newAccounts,
            "$settings_domains_certUrl",
            "PreconfiguredRemoteInput": [
              {
                "name": "CompagnyUrl",
                "value": "https://help.mycompany.com/"
              },
              {
                "name": "Any Text",
                "value": "Any text\r"
              },
              {
                "name": "Welcome",
                "value": "Default welcome text"
              }
            ],
            "myServer": {
              "Backup": false,
              "Restore": false,
              "Upgrade": false,
              "ErrorLog": false,
              "Console": false,
              "Trace": false
            },
            "userConsentFlags": {
              "desktopnotify": true,
              "terminalnotify": true,
              "filenotify": true,
              "desktopprompt": true,
              "terminalprompt": true,
              "fileprompt": true,
              "desktopprivacybar": true
            },
            "localSessionRecording": $settings_domains_localSessionRecording,
          },
        },
      }
  init.sh: |-
    #!/bin/sh
    export configfile=/opt/meshcentral/meshcentral-data/config.json;
    if test -f $configfile; then
      echo "config.json exists.";
    else
      cp /init/meshcentral/config.json.template $configfile;
      echo Copied config file;
    fi

{{- end -}}
