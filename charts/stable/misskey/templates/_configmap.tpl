{{/* Define the configmap */}}
{{- define "misskey.configmap" -}}
enabled: true
data:
  default.yml: |-
    #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    # Misskey configuration
    #━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    #   ┌─────┐
    #───┘ URL └─────────────────────────────────────────────────────

    # Final accessible URL seen by a user.
    url: {{ .Values.misskey.url }}

    # ONCE YOU HAVE STARTED THE INSTANCE, DO NOT CHANGE THE
    # URL SETTINGS AFTER THAT!

    #   ┌───────────────────────┐
    #───┘ Port and TLS settings └───────────────────────────────────

    port: {{ .Values.service.main.ports.main.port }} # A port that your Misskey server should listen.


    #   ┌──────────────────────────┐
    #───┘ PostgreSQL configuration └────────────────────────────────

    db:
      host: {{ .Values.cnpg.main.creds.host | trimAll "\"" }}
      port: 5432

      # Database name
      db: {{ .Values.cnpg.main.database }}

      # Auth
      user: {{ .Values.cnpg.main.user }}
      pass: {{ .Values.cnpg.main.creds.password | trimAll "\"" }}

      # Whether disable Caching queries
      #disableCache: true

      # Extra Connection options
      #extra:
      #  ssl: true

    #   ┌─────────────────────┐
    #───┘ Redis configuration └─────────────────────────────────────
    {{- $redisHost := .Values.redis.creds.plainhost | trimAll "\"" }}
    {{- $redisPass := .Values.redis.creds.redisPassword | trimAll "\"" }}
    redis:
      host: {{ $redisHost }}
      port: 6379
      pass: {{ $redisPass }}
      prefix: main
      db: 0

    redisForPubsub:
      host: {{ $redisHost }}
      port: 6379
      #family: 0  # 0=Both, 4=IPv4, 6=IPv6
      pass: {{ $redisPass }}
      prefix: pub-sub
      db: 0

    redisForJobQueue:
      host: {{ $redisHost }}
      port: 6379
      #family: 0  # 0=Both, 4=IPv4, 6=IPv6
      pass: {{ $redisPass }}
      prefix: job-queue
      db: 0

    #   ┌─────────────────────────────┐
    #───┘ Elasticsearch configuration └─────────────────────────────

    #elasticsearch:
    #  host: localhost
    #  port: 9200
    #  ssl: false
    #  user:
    #  pass:

    #   ┌───────────────┐
    #───┘ ID generation └───────────────────────────────────────────

    # ONCE YOU HAVE STARTED THE INSTANCE, DO NOT CHANGE THE
    # ID SETTINGS AFTER THAT!

    id: {{ .Values.misskey.id }}

    #   ┌─────────────────────┐
    #───┘ Other configuration └─────────────────────────────────────

    # Whether disable HSTS
    disableHsts: {{ .Values.misskey.other.disableHSTS }}

    # Number of worker processes
    clusterLimit: {{ .Values.misskey.other.clusterLimit }}

    # Job concurrency per worker
    deliverJobConcurrency: {{ .Values.misskey.other.deliverJobConcurrency }}
    inboxJobConcurrency: {{ .Values.misskey.other.inboxJobConcurrency }}
    relashionshipJobConcurrency: {{ .Values.misskey.other.relashionshipJobConcurrency }}

    # Job rate limiter
    deliverJobPerSec: {{ .Values.misskey.other.deliverJobPerSec }}
    inboxJobPerSec: {{ .Values.misskey.other.inboxJobPerSec }}
    relashionshipJobPerSec: {{ .Values.misskey.other.relashionshipJobPerSec }}

    # Job attempts
    deliverJobMaxAttempts: {{ .Values.misskey.other.deliverJobMaxAttempts }}
    inboxJobMaxAttempts: {{ .Values.misskey.other.inboxJobMaxAttempts }}

    # IP address family used for outgoing request (ipv4, ipv6 or dual)
    #outgoingAddressFamily: ipv4

    # Proxy for HTTP/HTTPS
    #proxy: http://127.0.0.1:3128

    {{- with $hosts := .Values.misskey.other.proxyBypassHosts }}
    proxyBypassHosts:
      {{- range $item := $hosts }}
      - {{ $item }}
      {{- end }}
    {{- end }}

    # Proxy for SMTP/SMTPS
    #proxySmtp: http://127.0.0.1:3128   # use HTTP/1.1 CONNECT
    #proxySmtp: socks4://127.0.0.1:1080 # use SOCKS4
    #proxySmtp: socks5://127.0.0.1:1080 # use SOCKS5

    # Media Proxy
    #mediaProxy: https://example.com/proxy

    # Sign to ActivityPub GET request (default: false)
    signToActivityPubGet: {{ .Values.misskey.other.signToActivityPubGet }}

    allowedPrivateNetworks: [
      '127.0.0.1/32',
    {{- range .Values.misskey.other.allowedPrivateNetworks }}
      {{ . | squote }},
    {{- end }}
    ]

    # Upload or download file size limits (bytes)
    maxFileSize: {{ .Values.misskey.other.maxFileSize }}
{{- end -}}
