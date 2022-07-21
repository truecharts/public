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
  {{- if or ( eq $config.protocol "HTTP" ) ( eq $config.protocol "HTTPS" ) ( eq $config.protocol "TCP" ) }}
  {{- $_ := set $config "protocol" "TCP" }}
  {{- end }}
  - "--entryPoints.{{$name}}.address=:{{ $config.port }}/{{ default "tcp" $config.protocol | lower }}"
  {{- end }}
  {{- end }}
  - "--api.dashboard=true"
  - "--ping=true"
  {{- if .Values.metrics }}
  {{- if .Values.metrics.datadog }}
  - "--metrics.datadog=true"
  - "--metrics.datadog.address={{ .Values.metrics.datadog.address }}"
  {{- end }}
  {{- if .Values.metrics.influxdb }}
  - "--metrics.influxdb=true"
  - "--metrics.influxdb.address={{ .Values.metrics.influxdb.address }}"
  - "--metrics.influxdb.protocol={{ .Values.metrics.influxdb.protocol }}"
  {{- end }}
  {{- if .Values.metrics.prometheus }}
  - "--metrics.prometheus=true"
  - "--metrics.prometheus.entrypoint={{ .Values.metrics.prometheus.entryPoint }}"
  {{- end }}
  {{- if .Values.metrics.statsd }}
  - "--metrics.statsd=true"
  - "--metrics.statsd.address={{ .Values.metrics.statsd.address }}"
  {{- end }}
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
  {{- if .Values.ingressClass.enabled }}
  - "--providers.kubernetesingress.ingressclass={{ .Release.Name }}"
  {{- end }}
  {{- range $entrypoint, $config := $ports }}
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
  {{- if or ( $config.tls ) ( eq $config.protocol "HTTPS" ) }}
  {{- if or ( $config.tls.enabled ) ( eq $config.protocol "HTTPS" ) }}
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
  {{/* theme.park */}}
  {{- if .Values.themePark}}
  - "--experimental.plugins.traefik-themepark.modulename=github.com/packruler/traefik-themepark"
  - "--experimental.plugins.traefik-themepark.version={{ .Values.themeParkVersion }}"
  {{- end }}
  {{/* End of theme.park */}}
  {{- with .Values.additionalArguments }}
  {{- range . }}
  - {{ . | quote }}
  {{- end }}
  {{- end }}
{{- end -}}
