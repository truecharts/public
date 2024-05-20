{{/* Define the args */}}
{{- define "traefik.args" -}}
args:
  {{/* merge all ports */}}
  {{- $ports := dict }}
  {{- range $.Values.service }}
  {{- range $name, $value := .ports }}
  {{- $_ := set $ports $name $value }}
  {{- end }}
  {{- end }}
  {{/* start of actual arguments */}}
  {{- with .Values.globalArguments }}
  {{- range . }}
  - {{ . | quote }}
  {{- end }}
  {{- end }}
  {{- range $name, $config := $ports }}
  {{- if $config }}
  {{- if or ( eq $config.protocol "http" ) ( eq $config.protocol "https" ) ( eq $config.protocol "tcp" ) }}
  {{- $_ := set $config "protocol" "tcp" }}
  {{- end }}
  - "--entryPoints.{{$name}}.address=:{{ $config.port }}/{{ default "tcp" $config.protocol | lower }}"
  {{- end }}
  {{- end }}
  - "--api.dashboard=true"
  - "--ping=true"
  {{- if .Values.traefikMetrics }}
  {{- if .Values.traefikMetrics.datadog }}
  - "--metrics.datadog=true"
  - "--metrics.datadog.address={{ .Values.traefikMetrics.datadog.address }}"
  {{- end }}
  {{- if .Values.traefikMetrics.influxdb }}
  - "--metrics.influxdb=true"
  - "--metrics.influxdb.address={{ .Values.traefikMetrics.influxdb.address }}"
  - "--metrics.influxdb.protocol={{ .Values.traefikMetrics.influxdb.protocol }}"
  {{- end }}
  {{- if .Values.traefikMetrics.statsd }}
  - "--metrics.statsd=true"
  - "--metrics.statsd.address={{ .Values.traefikMetrics.statsd.address }}"
  {{- if or .Values.traefikMetrics.prometheus }}
  - "--metrics.prometheus=true"
  - "--metrics.prometheus.entrypoint=metrics"
  {{- end }}
  {{- end }}
  {{- end }}
  {{- if or .Values.metrics.main.enabled }}
  - "--metrics.prometheus=true"
  - "--metrics.prometheus.entrypoint=metrics"
  {{- end }}
  {{- if .Values.providers.kubernetesCRD.enabled }}
  - "--providers.kubernetescrd"
  {{- end }}
  {{- if .Values.providers.kubernetesIngress.enabled }}
  - "--providers.kubernetesingress"
  {{- if .Values.providers.kubernetesIngress.publishedService.enabled }}
  - "--providers.kubernetesingress.ingressendpoint.publishedservice={{ template "providers.kubernetesIngress.publishedServicePath" . }}"
  {{- end }}
  {{- if .Values.providers.kubernetesIngress.labelSelector }}
  - "--providers.kubernetesingress.labelSelector={{ .Values.providers.kubernetesIngress.labelSelector }}"
  {{- end }}
  {{- end }}
  {{- if and .Values.rbac.enabled .Values.rbac.namespaced }}
  {{- if .Values.providers.kubernetesCRD.enabled }}
  - "--providers.kubernetescrd.namespaces={{ template "providers.kubernetesCRD.namespaces" . }}"
  {{- end }}
  {{- if .Values.providers.kubernetesIngress.enabled }}
  - "--providers.kubernetesingress.namespaces={{ template "providers.kubernetesIngress.namespaces" . }}"
  {{- end }}
  {{- end }}
  {{- if $.Values.ingressClass.enabled }}
  - "--providers.kubernetesingress.ingressclass={{ .Release.Name }}"
  {{- end }}
  {{- range $entrypoint, $config := $ports }}
  {{- if $config.transport }}
  {{- if $config.transport.respondingTimeouts }}
  --entryPoints.{{ $entrypoint }}.transport.respondingTimeouts.readTimeout={{ $config.transport.respondingTimeouts.trustedIPs | default 0 }}
  {{- else }}
  --entryPoints.{{ $entrypoint }}.transport.respondingTimeouts.readTimeout=0
  {{- end }}
  {{/* add args for proxyProtocol support */}}
  {{- if $config.proxyProtocol }}
  {{- if $config.proxyProtocol.enabled }}
  {{- if $config.proxyProtocol.insecureMode }}
  - "--entrypoints.{{ $entrypoint }}.proxyProtocol.insecure"
  {{- end }}
  {{- if not ( empty $config.proxyProtocol.trustedIPs ) }}
  - "--entrypoints.{{ $entrypoint }}.proxyProtocol.trustedIPs={{ join "," $config.proxyProtocol.trustedIPs }}"
  {{- end }}
  {{- end }}
  {{- end }}
  {{/* add args for forwardedHeaders support */}}
  {{- if $config.forwardedHeaders.enabled }}
  {{- if not ( empty $config.forwardedHeaders.trustedIPs ) }}
  - "--entrypoints.{{ $entrypoint }}.forwardedHeaders.trustedIPs={{ join "," $config.forwardedHeaders.trustedIPs }}"
  {{- end }}
  {{- if $config.forwardedHeaders.insecureMode }}
  - "--entrypoints.{{ $entrypoint }}.forwardedHeaders.insecure"
  {{- end }}
  {{- end }}
  {{/* end forwardedHeaders configuration */}}
  {{- if $config.redirectTo }}
  {{- $toPort := index $ports $config.redirectTo }}
  - "--entrypoints.{{ $entrypoint }}.http.redirections.entryPoint.to=:{{ $toPort.port }}"
  - "--entrypoints.{{ $entrypoint }}.http.redirections.entryPoint.scheme=https"
  {{- else if $config.redirectPort }}
  {{ if gt $config.redirectPort 0.0 }}
  - "--entrypoints.{{ $entrypoint }}.http.redirections.entryPoint.to=:{{ $config.redirectPort }}"
  - "--entrypoints.{{ $entrypoint }}.http.redirections.entryPoint.scheme=https"
  {{- end }}
  {{- end }}
  {{- if or ( $config.tls ) ( eq $config.protocol "https" ) }}
  {{- if or ( $config.tls.enabled ) ( eq $config.protocol "https" ) }}
  - "--entrypoints.{{ $entrypoint }}.http.tls=true"
  {{- if $config.tls.options }}
  - "--entrypoints.{{ $entrypoint }}.http.tls.options={{ $config.tls.options }}"
  {{- end }}
  {{- if $config.tls.certResolver }}
  - "--entrypoints.{{ $entrypoint }}.http.tls.certResolver={{ $config.tls.certResolver }}"
  {{- end }}
  {{- if $config.tls.domains }}
  {{- range $index, $domain := $config.tls.domains }}
  {{- if $domain.main }}
  - "--entrypoints.{{ $entrypoint }}.http.tls.domains[{{ $index }}].main={{ $domain.main }}"
  {{- end }}
  {{- if $domain.sans }}
  - "--entrypoints.{{ $entrypoint }}.http.tls.domains[{{ $index }}].sans={{ join "," $domain.sans }}"
  {{- end }}
  {{- end }}
  {{- end }}
  {{- end }}
  {{- end }}
  {{- end }}
  {{- with .Values.logs }}
  - "--log.format={{ .general.format }}"
  {{- if ne .general.level "ERROR" }}
  - "--log.level={{ .general.level | upper }}"
  {{- end }}
  {{- if .access.enabled }}
  - "--accesslog=true"
  - "--accesslog.format={{ .access.format }}"
  {{- if .access.bufferingsize }}
  - "--accesslog.bufferingsize={{ .access.bufferingsize }}"
  {{- end }}
  {{- if .access.filters }}
  {{- if .access.filters.statuscodes }}
  - "--accesslog.filters.statuscodes={{ .access.filters.statuscodes }}"
  {{- end }}
  {{- if .access.filters.retryattempts }}
  - "--accesslog.filters.retryattempts"
  {{- end }}
  {{- if .access.filters.minduration }}
  - "--accesslog.filters.minduration={{ .access.filters.minduration }}"
  {{- end }}
  {{- end }}
  - "--accesslog.fields.defaultmode={{ .access.fields.general.defaultmode }}"
  {{- range $fieldname, $fieldaction := .access.fields.general.names }}
  - "--accesslog.fields.names.{{ $fieldname }}={{ $fieldaction }}"
  {{- end }}
  - "--accesslog.fields.headers.defaultmode={{ .access.fields.headers.defaultmode }}"
  {{- range $fieldname, $fieldaction := .access.fields.headers.names }}
  - "--accesslog.fields.headers.names.{{ $fieldname }}={{ $fieldaction }}"
  {{- end }}
  {{- end }}
  {{- end }}
  {{/*
    For new plugins, add them on the container also
    https://github.com/truecharts/containers/blob/master/mirror/traefik/Dockerfile
    moduleName must match on the container and here
  */}}
  {{- if .Values.middlewares.themePark }}
  {{/* theme.park */}}
  - "--experimental.localPlugins.traefik-themepark.modulename=github.com/packruler/traefik-themepark"
  {{- end }}
  {{/* End of theme.park */}}
  {{/* GeoBlock */}}
  {{- if .Values.middlewares.geoBlock }}
  - "--experimental.localPlugins.GeoBlock.modulename=github.com/PascalMinder/geoblock"
  {{- end }}
  {{/* End of GeoBlock */}}
  {{/* RealIP */}}
  {{- if .Values.middlewares.realIP }}
  - "--experimental.localPlugins.traefik-real-ip.modulename=github.com/jramsgz/traefik-real-ip"
  {{- end }}
  {{/* End of RealIP */}}
  {{/* ModSecurity */}}
  {{- if .Values.middlewares.modsecurity }}
  - "--experimental.localPlugins.traefik-modsecurity-plugin.modulename=github.com/acouvreur/traefik-modsecurity-plugin"
  {{- end }}
  {{/* CrowdsecBouncer */}}
  {{- if .Values.middlewares.bouncer }}
  - "--experimental.localPlugins.bouncer.modulename=github.com/maxlerebourg/crowdsec-bouncer-traefik-plugin"
  {{- end }}
  {{/* End of ModSecurity */}}
  {{/* RewriteResponseHeaders */}}
  {{- if .Values.middlewares.rewriteResponseHeaders }}
  - "--experimental.localPlugins.rewriteResponseHeaders.modulename=github.com/XciD/traefik-plugin-rewrite-headers"
  {{- end }}
  {{/* End of RewriteResponseHeaders */}}
  {{- with .Values.additionalArguments }}
  {{- range . }}
  - {{ . | quote }}
  {{- end }}
  {{- end }}
{{- end -}}
