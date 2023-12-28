{{- define "plik.secret" -}}

{{- $secretName := printf "%s-plik-secret" (include "tc.v1.common.names.fullname" .) }}
enabled: true
data:
  plikd.cfg: |
    ListenPort            = {{ .Values.service.main.ports.main.port }}
    ListenAddress         = "0.0.0.0"
    Path                  = ""
    SslEnabled            = false
    SslCert               = "plik.crt"
    SslKey                = "plik.key"
    NoWebInterface        = false
    WebappDirectory       = "../webapp/dist"
    ClientsDirectory      = "../clients"
    ChangelogDirectory    = "../changelog"
    Debug                 = {{ .Values.plik.general.debug }}
    DebugRequests         = {{ .Values.plik.general.debug_requests }}
    LogLevel              = {{ .Values.plik.general.log_level | quote }}
    AbuseContact          = {{ .Values.plik.general.abuse_contact | quote }}
    DownloadDomain        = {{ .Values.plik.network.download_domain | quote }}
    {{- with .Values.plik.network.download_domain_alias }}
    DownloadDomainAlias   = [
      {{- range $alias := initial . }}
        {{- $alias | quote | nindent 6 }},
      {{- end -}}
      {{- last . | quote | nindent 6 }}
    ]
    {{- else }}
    DownloadDomainAlias   = []
    {{- end }}
    EnhancedWebSecurity   = {{ .Values.plik.network.enhanced_web_security }}
    SessionTimeout        = {{ .Values.plik.network.session_timeout | quote }}
    SourceIpHeader        = {{ .Values.plik.network.source_ip_header | quote }}
    {{- with .Values.plik.network.upload_whitelist  }}
    UploadWhitelist       = [
      {{- range $ip := initial . }}
        {{- $ip | quote | nindent 6 }},
      {{- end -}}
      {{- last . | quote | nindent 6 }}
    ]
    {{- else }}
    UploadWhitelist       = []
    {{- end }}
    MaxFileSizeStr        = {{ .Values.plik.files.max_file_size | quote }}
    MaxFilePerUpload      = {{ .Values.plik.files.max_files_per_upload }}
    DefaultTTLStr         = {{ .Values.plik.files.default_ttl | quote }}
    MaxTTLStr             = {{ .Values.plik.files.max_ttl | quote }}

    FeatureAuthentication = {{ .Values.plik.features.authentication | quote }}
    FeatureOneShot        = {{ .Values.plik.features.one_shot | quote }}
    FeatureRemovable      = {{ .Values.plik.features.removable | quote }}
    FeatureStream         = {{ .Values.plik.features.stream | quote }}
    FeaturePassword       = {{ .Values.plik.features.password | quote }}
    FeatureComments       = {{ .Values.plik.features.comments | quote }}
    FeatureSetTTL         = {{ .Values.plik.features.set_ttl | quote }}
    FeatureExtendTTL      = {{ .Values.plik.features.extend_ttl | quote }}
    FeatureClients        = {{ .Values.plik.features.clients | quote }}
    FeatureGithub         = {{ .Values.plik.features.github | quote }}
    GoogleApiClientID     = {{ .Values.plik.third_party.google_api_client_id | quote }}
    GoogleApiSecret       = {{ .Values.plik.third_party.google_api_secret | quote }}
    {{- with .Values.plik.third_party.google_valid_domains }}
    GoogleValidDomains    = [
      {{- range $domain := initial . }}
        {{- $domain | quote | nindent 6 }},
      {{- end -}}
      {{- last . | quote | nindent 6 }}
    ]
    {{- else }}
    GoogleValidDomains    = []
    {{- end }}
    OvhApiKey             = {{ .Values.plik.third_party.ovh_api_key | quote }}
    OvhApiSecret            = {{ .Values.plik.third_party.ovh_api_secret | quote }}
    OvhApiEndpoint        = {{ .Values.plik.third_party.ovh_api_endpoint | quote }}

    {{- $backend := .Values.plik.files.data_backend }}
    DataBackend           = {{ $backend | quote }}
    [MetadataBackendConfig]
        Driver            = "postgres"
        ConnectionString  = {{ .Values.cnpg.main.url.complete | trimAll "\"" | quote }}
        Debug             = {{ .Values.plik.general.debug }}
    [DataBackendConfig]
    {{- if eq $backend "file" }}
        Directory         = {{ .Values.persistence.data.mountPath | quote }}
    {{- else if eq $backend "gcs" }}
        Bucket            = {{ .Values.plik.files.gcs.bucket | quote }}
        Folder            = {{ .Values.plik.files.gcs.folder | quote }}
    {{- else if eq $backend "s3" }}
        Endpoint          = {{ .Values.plik.files.s3.endpoint | quote }}
        AccessKeyID       = {{ .Values.plik.files.s3.access_key_id | quote }}
        SecretAccessKey   = {{ .Values.plik.files.s3.secret_access_key | quote }}
        Bucket            = {{ .Values.plik.files.s3.bucket | quote }}
        Location          = {{ .Values.plik.files.s3.location | quote }}
        Prefix            = {{ .Values.plik.files.s3.prefix | quote }}
        UseSSL            = {{ .Values.plik.files.s3.use_ssl }}
        PartSize          = {{ .Values.plik.files.s3.part_size | int }}
        SSE               = {{ .Values.plik.files.s3.sse | quote }}
    {{- else if eq $backend "swift" }}
        Container         = {{ .Values.plik.files.swift.container | quote }}
        AuthUrl           = {{ .Values.plik.files.swift.auth_url | quote }}
        UserName          = {{ .Values.plik.files.swift.username | quote }}
        ApiKey            = {{ .Values.plik.files.swift.api_key | quote }}
        Domain            = {{ .Values.plik.files.swift.domain | quote }}
        Tenant            = {{ .Values.plik.files.swift.tenant | quote }}
    {{- end -}}
{{- end -}}
