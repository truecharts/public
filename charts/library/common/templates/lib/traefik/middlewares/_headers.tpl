{{- define "tc.v1.common.class.traefik.middleware.headers" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $mw := $objectData.data }}
  headers:
    {{- if $mw.customRequestHeaders }}
    customRequestHeaders:
      {{- range $k, $v := $mw.customRequestHeaders }}
      {{ $k }}: {{ $v }}
      {{- end }}
    {{- end -}}

    {{- if $mw.customResponseHeaders }}
    customResponseHeaders:
      {{- range $k, $v := $mw.customResponseHeaders }}
      {{ $k }}: {{ $v }}
      {{- end }}
    {{- end -}}

    {{- if hasKey $mw "accessControlAllowCredentials" }}
    accessControlAllowCredentials: {{ $mw.accessControlAllowCredentials }}
    {{- end -}}

    {{- if $mw.accessControlAllowHeaders }}
    accessControlAllowHeaders:
      {{- range $mw.accessControlAllowHeaders }}
      - {{ . | quote }}
      {{- end }}
    {{- end -}}

    {{- if $mw.accessControlAllowMethods }}
    accessControlAllowMethods:
      {{- range $mw.accessControlAllowMethods }}
      - {{ . | quote }}
      {{- end }}
    {{- end -}}

    {{- if $mw.accessControlAllowOriginList }}
    accessControlAllowOriginList:
      {{- range $mw.accessControlAllowOriginList }}
      - {{ . | quote }}
      {{- end }}
    {{- end -}}

    {{- if $mw.accessControlAllowOriginListRegex }}
    accessControlAllowOriginListRegex:
      {{- range $mw.accessControlAllowOriginListRegex }}
      - {{ . | quote }}
      {{- end }}
    {{- end -}}

    {{- if $mw.accessControlExposeHeaders }}
    accessControlExposeHeaders:
      {{- range $mw.accessControlExposeHeaders }}
      - {{ . | quote }}
      {{- end }}
    {{- end -}}

    {{- if $mw.accessControlMaxAge }}
    accessControlMaxAge: {{ $mw.accessControlMaxAge }}
    {{- end -}}

    {{- if hasKey $mw "addVaryHeader" }}
    addVaryHeader: {{ $mw.addVaryHeader }}
    {{- end -}}

    {{- if $mw.allowedHosts }}
    allowedHosts:
      {{- range $mw.allowedHosts }}
      - {{ . | quote }}
      {{- end }}
    {{- end -}}

    {{- if $mw.hostsProxyHeaders }}
    hostsProxyHeaders:
      {{- range $mw.hostsProxyHeaders }}
      - {{ . | quote }}
      {{- end }}
    {{- end -}}

    {{- if $mw.sslProxyHeaders }}
    sslProxyHeaders:
      {{- range $k, $v := $mw.sslProxyHeaders }}
      {{ $k }}: {{ $v }}
      {{- end }}
    {{- end -}}

    {{- if $mw.stsSeconds }}
    stsSeconds: {{ $mw.stsSeconds }}
    {{- end -}}

    {{- if hasKey $mw "stsIncludeSubdomains" }}
    stsIncludeSubdomains: {{ $mw.stsIncludeSubdomains }}
    {{- end -}}

    {{- if hasKey $mw "stsPreload" }}
    stsPreload: {{ $mw.stsPreload }}
    {{- end -}}

    {{- if hasKey $mw "forceSTSHeader" }}
    forceSTSHeader: {{ $mw.forceSTSHeader }}
    {{- end -}}

    {{- if hasKey $mw "frameDeny" }}
    frameDeny: {{ $mw.frameDeny }}
    {{- end -}}

    {{- if $mw.customFrameOptionsValue }}
    customFrameOptionsValue: {{ $mw.customFrameOptionsValue }}
    {{- end -}}

    {{- if hasKey $mw "contentTypeNosniff" }}
    contentTypeNosniff: {{ $mw.contentTypeNosniff }}
    {{- end -}}

    {{- if hasKey $mw "browserXssFilter" }}
    browserXssFilter: {{ $mw.browserXssFilter }}
    {{- end -}}

    {{- if $mw.customBrowserXSSValue }}
    customBrowserXSSValue: {{ $mw.customBrowserXSSValue }}
    {{- end -}}

    {{- if $mw.contentSecurityPolicy }}
    contentSecurityPolicy: {{ $mw.contentSecurityPolicy }}
    {{- end -}}

    {{- if $mw.contentSecurityPolicyReportOnly }}
    contentSecurityPolicyReportOnly: {{ $mw.contentSecurityPolicyReportOnly }}
    {{- end -}}

    {{- if $mw.publicKey }}
    publicKey: {{ $mw.publicKey }}
    {{- end -}}

    {{- if $mw.referrerPolicy }}
    referrerPolicy: {{ $mw.referrerPolicy }}
    {{- end -}}

    {{- if $mw.permissionsPolicy }}
    permissionsPolicy: {{ $mw.permissionsPolicy }}
    {{- end -}}

    {{- if hasKey $mw "isDevelopment" }}
    isDevelopment: {{ $mw.isDevelopment }}
    {{- end -}}
{{- end -}}
