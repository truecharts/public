{{/* Define the configmap */}}
{{- define "magicmirror.config" -}}

{{- $configName := printf "%s-magicmirror-config" (include "tc.common.names.fullname" .) }}
{{- $configEnvName := printf "%s-magicmirror-env" (include "tc.common.names.fullname" .) }}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  config.js: |
    /* Magic Mirror Config Sample
    *
    * By Michael Teeuw http://michaelteeuw.nl
    * MIT Licensed.
    *
    * For more information on how you can configure this file
    * See https://github.com/MichMich/MagicMirror#configuration
    *
    */

    var config = {
      address: "0.0.0.0",
      port: {{ .Values.service.main.ports.main.port }},

      // or add a specific IPv4 of 192.168.1.5 :
      // ["127.0.0.1", "::ffff:127.0.0.1", "::1", "::ffff:192.168.1.5"],
      // or IPv4 range of 192.168.3.0 --> 192.168.3.15 use CIDR format :
      // ["127.0.0.1", "::ffff:127.0.0.1", "::1", "::ffff:192.168.3.0/28"],
      // Set [] to allow all IP addresses
      ipWhitelist: [
        {{- range .Values.magicmirror.ip_whitelist }}
        {{ . | quote }},
        {{- end }}
      ],

      useHttps: false, // Support HTTPS or not, default "false" will use HTTP

      language: {{ .Values.magicmirror.language | quote }},
      timeFormat: {{ .Values.magicmirror.time_format | trimAll "\"" }},
      units: {{ .Values.magicmirror.units | quote }},
      serverOnly: "true",

      modules: [
        {
          module: "alert",
          config: {
            effect: {{ .Values.magicmirror.alert.effect | quote }},
            alert_effect: {{ .Values.magicmirror.alert.alert_effect | quote }},
            display_time: {{ .Values.magicmirror.alert.display_time }},
            position: {{ .Values.magicmirror.alert.position | quote }},
            welcome_message: {{ .Values.magicmirror.alert.welcome_message | quote }}
          }
        },
        {
          module: "updatenotification",
          position: {{ .Values.magicmirror.update_notification.position | quote }},
          config: {
            updateInterval: {{ .Values.magicmirror.update_notification.config.updateInterval }},
            ignoreModules: [
              {{- range  .Values.magicmirror.update_notification.config.ignoreModules }}
              {{ . | quote }},
              {{- end }}
            ]
          }
        },
        {
          module: "clock",
          position: "top_left"
        },
        {
          module: "calendar",
          header: "US Holidays",
          position: "top_left",
          config: {
            calendars: [
              {
                symbol: "calendar-check",
                url: "webcal://www.calendarlabs.com/ical-calendar/ics/76/US_Holidays.ics"
              }
            ]
          }
        },
        {
          module: "compliments",
          position: "lower_third"
        },
        {
          module: "currentweather",
          position: "top_right",
          config: {
            location: "New York",
            locationID: "", //ID from http://bulk.openweathermap.org/sample/city.list.json.gz; unzip the gz file and find your city
            appid: "YOUR_OPENWEATHER_API_KEY"
          }
        },
        {
          module: "weatherforecast",
          position: "top_right",
          header: "Weather Forecast",
          config: {
            location: "New York",
            locationID: "5128581", //ID from http://bulk.openweathermap.org/sample/city.list.json.gz; unzip the gz file and find your city
            appid: "YOUR_OPENWEATHER_API_KEY"
          }
        },
        {
          module: "newsfeed",
          position: "bottom_bar",
          config: {
            feeds: [
              {
                title: "New York Times",
                url: "http://www.nytimes.com/services/xml/rss/nyt/HomePage.xml"
              }
            ],
            showSourceTitle: true,
            showPublishDate: true,
            broadcastNewsFeeds: true,
            broadcastNewsUpdates: true
          }
        },
      ]

    };

    /*************** DO NOT EDIT THE LINE BELOW ***************/
    if (typeof module !== "undefined") {module.exports = config;}

---

apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ $configEnvName }}
  labels:
    {{- include "tc.common.labels" . | nindent 4 }}
data:
  DATA_DIR: /magicmirror2
  UID: {{ .Values.security.PUID | quote }}
  GID: {{ .Values.podSecurityContext.fsGroup | quote }}
  FORCE_UPDATE: {{ .Values.magicmirror.force_update | quote }}
  FORCE_UPDATE_MODULES: {{ .Values.magicmirror.force_update_modules | quote }}
{{- end -}}
