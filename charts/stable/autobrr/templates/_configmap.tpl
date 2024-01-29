{{/* Define the configmap */}}
{{- define "autobrr.configmaps" -}}
{{- $fullname := (include "tc.v1.common.lib.chart.names.fullname" $) -}}
{{- $secretName := printf "%s-autobrr-secret" (include "tc.v1.common.lib.chart.names.fullname" .) }}

{{- $mainPort := .Values.service.main.ports.main.port -}}
{{- $logLevel := .Values.autobrr.log_level -}}

{{- $sessionSecret := randAlphaNum 32 -}}

 {{- with lookup "v1" "Secret" .Release.Namespace $secretName -}}
   {{- $sessionSecret = index .data "sessionSecret" | b64dec -}}
 {{- end }}

autobrr-config:
  enabled: true
  data:
    config.toml: |
     # config.toml
      # Hostname / IP
      #
      # Default: "localhost"
      #
      host = "0.0.0.0"

      # Port
      #
      # Default: 7474
      #
      port = {{ $mainPort }}

      # Base url
      # Set custom baseUrl eg /autobrr/ to serve in subdirectory.
      # Not needed for subdomain, or by accessing with the :port directly.
      #
      # Optional
      #
      baseUrl = "/"

      # autobrr logs file
      # If not defined, logs to stdout
      #
      # Optional
      #
      #logPath = "log/autobrr.log"

      # Log level
      #
      # Default: "DEBUG"
      #
      # Options: "ERROR", "DEBUG", "INFO", "WARN", "TRACE"
      #
      logLevel = "{{ $logLevel }}"

      # Log Max Size
      #
      # Default: 50
      #
      # Max log size in megabytes
      #
      #logMaxSize = 50

      # Log Max Backups
      #
      # Default: 3
      #
      # Max amount of old log files
      #
      #logMaxBackups = 3

      # Check for updates
      #
      # Default: true
      #
      checkForUpdates = true

      # Session secret
      #
      sessionSecret = "{{ $sessionSecret }}"

      # Custom definitions
      #
      #customDefinitions = "test/definitions"
{{- end -}}
