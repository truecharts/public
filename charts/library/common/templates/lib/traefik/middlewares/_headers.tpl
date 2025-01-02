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

    {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "addVaryHeader" "value" $mw.addVaryHeader) | nindent 4 }}

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

    {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "stsIncludeSubdomains" "value" $mw.stsIncludeSubdomains) | nindent 4 }}
    {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "stsPreload" "value" $mw.stsPreload) | nindent 4 }}
    {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "forceSTSHeader" "value" $mw.forceSTSHeader) | nindent 4 }}
    {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "frameDeny" "value" $mw.frameDeny) | nindent 4 }}

    {{- if $mw.customFrameOptionsValue }}
    customFrameOptionsValue: {{ $mw.customFrameOptionsValue }}
    {{- end -}}

    {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "contentTypeNosniff" "value" $mw.contentTypeNosniff) | nindent 4 }}
    {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "browserXssFilter" "value" $mw.browserXssFilter) | nindent 4 }}

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

    {{- include "tc.v1.common.class.traefik.middleware.helper.bool" (dict "key" "isDevelopment" "value" $mw.isDevelopment) | nindent 4 }}
{{- end -}}
