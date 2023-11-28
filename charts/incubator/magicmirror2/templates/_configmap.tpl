{{/* Define the configmap */}}
{{- define "magicmirror.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}

{{- $magicmirror := .Values.magicmirror -}}

magicmirror-config-env:
  enabled: true
  data:
    config.env: |
      PORT=":{{ .Values.service.main.ports.main.port }}"
      LANG={{ $magicmirror.lang }}
      LOCALE={{ $magicmirror.locale }}
      TIME_FORMAT={{ $magicmirror.time_format }}
      UNITS={{ $magicmirror.units }}

magicmirror-config:
  enabled: true
  data:
    config.js.template: |
      /* MagicMirror² Config Sample
      *
      * By Michael Teeuw https://michaelteeuw.nl
      * MIT Licensed.
      *
      * For more information on how you can configure this file
      * see https://docs.magicmirror.builders/configuration/introduction.html
      * and https://docs.magicmirror.builders/modules/configuration.html
      *
      * You can use environment variables using a `config.js.template` file instead of `config.js`
      * which will be converted to `config.js` while starting. For more information
      * see https://docs.magicmirror.builders/configuration/introduction.html#enviromnent-variables
      */
      let config = {
        address: "0.0.0.0",	// Address to listen on
        port: ${PORT},
        basePath: "/",			// The URL path where MagicMirror² is hosted. If you are using a Reverse proxy
                      // you must set the sub path here. basePath must end with a /
        ipWhitelist: [],	// Set [] to allow all IP addresses
                                    // or add a specific IPv4 of 192.168.1.5 :
                                    // ["127.0.0.1", "::ffff:127.0.0.1", "::1", "::ffff:192.168.1.5"],
                                    // or IPv4 range of 192.168.3.0 --> 192.168.3.15 use CIDR format :
                                    // ["127.0.0.1", "::ffff:127.0.0.1", "::1", "::ffff:192.168.3.0/28"],

        useHttps: false, 		// Support HTTPS or not, default "false" will use HTTP
        httpsPrivateKey: "", 	// HTTPS private key path, only require when useHttps is true
        httpsCertificate: "", 	// HTTPS Certificate path, only require when useHttps is true

        language: "${LANG}",
        locale: "${LOCALE}",
        logLevel: ["INFO", "LOG",, "DEBUG", "WARN", "ERROR"], // Add "DEBUG" for even more logging
        timeFormat: ${TIME_FORMAT},
        units: "${UNITS}",
        modules: [
          {
            module: "alert",
          },
          {
            module: "updatenotification",
            position: "top_bar"
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
                  fetchInterval: 7 * 24 * 60 * 60 * 1000,
                  symbol: "calendar-check",
                  url: "https://ics.calendarlabs.com/76/mm3137/US_Holidays.ics"
                }
              ]
            }
          },
          {
            module: "compliments",
            position: "lower_third"
          }
        ]
      };

      /*************** DO NOT EDIT THE LINE BELOW ***************/
      if (typeof module !== "undefined") {module.exports = config;}

{{- end -}}
