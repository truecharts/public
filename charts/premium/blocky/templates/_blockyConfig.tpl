{{/* Define the config */}}
{{- define "blocky.configmap" -}}
{{- $config := mustMerge ( include "blocky.config" . | fromYaml ) ( .Values.blockyConfig ) }}
enabled: true
data:
  config.yml: |
{{ $config | toYaml | indent 4 }}
{{- end -}}

{{- define "blocky.config" -}}
redis:
  address: {{ printf "%v-%v" .Release.Name "redis" }}:6379
  password: {{ .Values.redis.creds.redisPassword | trimAll "\"" }}
  database: 0
  required: true
  connectionAttempts: 10
  connectionCooldown: 3s
prometheus:
  enable: true
  path: /metrics
queryLog:
  # optional one of: postgresql, csv, csv-client. If empty, log to console
  type: {{ .Values.queryLog.type }}
  # directory (should be mounted as volume in docker) for csv, db connection string for mysql/postgresql
  #postgresql target: postgres://user:password@db_host_or_ip:5432/db_name
  {{- if eq .Values.queryLog.type "postgresql" }}
  target: {{ .Values.cnpg.main.creds.std }}
  {{- else }}
  target: {{ .Values.queryLog.target }}
  {{- end }}
  # if > 0, deletes log files which are older than ... days
  logRetentionDays: {{ .Values.queryLog.logRetentionDays | default 0 }}
  # optional: Max attempts to create specific query log writer
  creationAttempts: {{ .Values.queryLog.creationAttempts | default 3 }}
  # optional: Time between the creation attempts
  creationCooldown: {{ .Values.queryLog.creationAttempts | default "2s" }}

upstream:
  default:
{{- .Values.defaultUpstreams | toYaml | nindent 8 }}
{{- range $id, $value := .Values.upstreams }}
  {{ $value.name }}:
{{- $value.dnsservers | toYaml | nindent 8 }}
{{- end }}

upstreamTimeout: {{ .Values.upstreamTimeout | default "1s" }}

ports:
  {{- if .Values.service.dns.enabled }}
  dns: {{ .Values.service.dns.ports.dns.targetPort }}
  {{- end }}
  {{- if .Values.service.dot.enabled }}
  tls: {{ .Values.service.dot.ports.dot.targetPort }}
  {{- end }}
  {{- if .Values.service.main.enabled }}
  http: {{ .Values.service.main.ports.main.targetPort }}
  {{- end }}
  {{- if .Values.service.https.enabled }}
  https: {{ .Values.service.https.ports.https.targetPort }}
  {{- end }}

{{- if .Values.certFile }}
certFile: {{ .Values.certFile }}
{{- end }}

{{- if .Values.keyFile }}
keyFile: {{ .Values.keyFile }}
{{- end }}

log:
  {{- if .Values.logLevel }}
  level: {{ .Values.logLevel }}
  {{- end }}
  {{- if .Values.logTimestamp }}
  timestamp: {{ .Values.logTimestamp }}
  {{- end }}
  {{- if .Values.logPrivacy }}
  privacy: {{ .Values.logPrivacy }}
  {{- end }}

{{- if .Values.dohUserAgent }}
dohUserAgent: {{ .Values.dohUserAgent }}
{{- end }}

{{- if .Values.minTlsServeVersion }}
minTlsServeVersion: {{ .Values.minTlsServeVersion }}
{{- end }}

caching:
{{ toYaml .Values.caching | indent 2 }}

{{- if .Values.hostsFile.enabled }}
{{ $hostsfile := omit .Values.hostsFile "enabled" }}
hostsFile:
{{ toYaml $hostsfile | indent 2 }}
{{- end }}

{{- if or .Values.bootstrapDns.upstream .Values.bootstrapDns.ips }}
bootstrapDns:
  {{- if .Values.bootstrapDns.upstream }}
  - upstream: {{ .Values.bootstrapDns.upstream }}
  {{- end }}
  {{- if .Values.bootstrapDns.ips }}
    ips:
    {{- range $id, $value := .Values.bootstrapDns.ips }}
      - {{ $value }}
    {{- end }}
  {{- end }}
  {{/* Add additional Bootstrap DNS */}}
  {{- range .Values.additionalBootstrapDns }}
  {{- with .upstream }}
  - upstream: {{ . }}
  {{- end }}
  {{- if .ips }}
    ips:
    {{- range $id, $value := .ips }}
      - {{ $value }}
    {{- end }}
  {{- end }}
  {{- end }}
{{- end }}

{{- if .Values.filtering.queryTypes }}
filtering:
  queryTypes:
  {{- range .Values.filtering.queryTypes }}
    - {{ . }}
  {{- end }}
{{- end }}

{{- if or .Values.customDNS.filterUnmappedTypes .Values.customDNS.customTTL .Values.customDNS.rewrite .Values.customDNS.mapping }}
customDNS:
{{- if .Values.customDNS.upstream }}
  upstream: {{ .Values.customDNS.upstream }}
{{- end }}
{{- if .Values.customDNS.customTTL }}
  customTTL: {{ .Values.customDNS.customTTL }}
{{- end }}
{{- if .Values.customDNS.rewrite }}
  rewrite:
{{- range $id, $value := .Values.customDNS.rewrite }}
    {{ $value.in }}: {{ $value.out }}
{{- end }}
{{- end }}

{{- if .Values.customDNS.mapping }}
  mapping:
{{- range $id, $value := .Values.customDNS.mapping }}
    {{ $value.domain }}: {{ $value.dnsserver }}
{{- end }}
{{- end }}
{{- end }}

{{- if or .Values.clientLookup.upstream .Values.clientLookup.ips }}
clientLookup:
{{- if .Values.clientLookup.upstream }}
  upstream: {{ .Values.clientLookup.upstream }}
{{- end }}
{{- if .Values.clientLookup.ips }}
  singleNameOrder:
{{- range $id, $value := .Values.clientLookup.ips }}
    - {{ $value }}
{{- end }}
{{- end }}
{{- if .Values.clientLookup.clients }}
  clients:
{{- range $id, $value := .Values.clientLookup.clients }}
    {{ $value.domain }}:
      {{- range $id, $value := .ips }}
      - {{ $value }}
      {{- end }}
{{- end }}
{{- end }}
{{- end }}

{{- if or .Values.conditional.rewrite .Values.conditional.mapping ( and .Values.k8sgateway.enabled .Values.k8sgateway.domains ) }}
conditional:
{{- if .Values.conditional.rewrite }}
  rewrite:
{{- range $id, $value := .Values.conditional.rewrite }}
    {{ $value.in }}: {{ $value.out }}
{{- end }}
{{- end }}

{{- if or .Values.conditional.mapping ( and .Values.k8sgateway.enabled .Values.k8sgateway.domains ) }}
  mapping:
{{- if and .Values.k8sgateway.enabled .Values.k8sgateway.domains }}
{{- range $id, $value := .Values.k8sgateway.domains }}
    {{ .domain }}: 127.0.0.1:{{ $.Values.service.k8sgateway.ports.k8sgateway.targetPort }}
{{- end }}
{{- end }}
{{- range $id, $value := .Values.conditional.mapping }}
    {{ $value.domain }}: {{ $value.dnsserver }}
{{- end }}
{{- end }}
{{- end }}

blocking:
  blockType: {{ .Values.blocking.blockType }}
  blockTTL: {{ .Values.blocking.blockTTL }}
  refreshPeriod: {{ .Values.blocking.refreshPeriod }}
  downloadTimeout: {{ .Values.blocking.downloadTimeout }}
  downloadAttempts: {{ .Values.blocking.downloadAttempts }}
  downloadCooldown: {{ .Values.blocking.downloadCooldown }}
  startStrategy: {{ .Values.blocking.startStrategy }}
  processingConcurrency: {{ .Values.blocking.processingConcurrency }}

  whiteLists:
    default:
      - https://raw.githubusercontent.com/anudeepND/whitelist/master/domains/optional-list.txt
      - https://raw.githubusercontent.com/anudeepND/whitelist/master/domains/whitelist.txt
      - https://raw.githubusercontent.com/rahilpathan/pihole-whitelist/main/1.LowWL.txt
{{- range $id, $value := .Values.blocking.whitelist }}
    {{ $value.name }}:
{{- $value.lists | toYaml | nindent 10 }}
{{- end }}


  blackLists:
    default:
      - https://big.oisd.nl/domainswild
      - https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts
    default-ads:
      - https://adaway.org/hosts.txt
      - https://v.firebog.net/hosts/AdguardDNS.txt
      - https://v.firebog.net/hosts/Admiral.txt
      - https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt
      - https://v.firebog.net/hosts/Easylist.txt
      - https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext
      - https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts
      - https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts
    default-tracking:
      - https://v.firebog.net/hosts/Easyprivacy.txt
      - https://v.firebog.net/hosts/Prigent-Ads.txt
      - https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts
      - https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt
      - https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt
    default-malicious:
      - https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt
      - https://v.firebog.net/hosts/Prigent-Crypto.txt
      - https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts
      - https://bitbucket.org/ethanr/dns-blacklists/raw/8575c9f96e5b4a1308f2f12394abd86d0927a4a0/bad_lists/Mandiant_APT1_Report_Appendix_D.txt
      - https://phishing.army/download/phishing_army_blocklist_extended.txt
      - https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt
      - https://v.firebog.net/hosts/Prigent-Malware.txt
      # - https://v.firebog.net/hosts/RPiList-Malware.txt (see: https://github.com/0xERR0R/blocky/issues/1718 )
      # - https://v.firebog.net/hosts/RPiList-Phishing.txt (see: https://github.com/0xERR0R/blocky/issues/1718 )
      - https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt
      - https://raw.githubusercontent.com/AssoEchap/stalkerware-indicators/master/generated/hosts
      - https://urlhaus.abuse.ch/downloads/hostfile/
      # - https://lists.cyberhost.uk/malware.txt (see: https://github.com/0xERR0R/blocky/issues/950)
    default-suspicious:
      - https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt
      - https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts
      - https://v.firebog.net/hosts/static/w3kbl.txt

{{- range $id, $value := .Values.blocking.blacklist }}
    {{ $value.name }}:
{{- $value.lists | toYaml | nindent 10 }}
{{- end }}

{{- if .Values.blocking.clientGroupsBlock }}
  clientGroupsBlock:
{{- range $id, $value := .Values.blocking.clientGroupsBlock }}
    {{ $value.name }}:
{{- $value.groups | toYaml | nindent 10 }}
{{- end }}
{{- end }}

{{- end -}}
