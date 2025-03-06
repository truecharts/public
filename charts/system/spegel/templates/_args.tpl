{{/* Define the args */}}
{{- define "spegel.args.init" -}}
  args:
    - configuration
    - --log-level={{ .Values.spegel.logLevel }}
    - --containerd-registry-config-path={{ .Values.spegel.containerdRegistryConfigPath }}
    {{- with .Values.spegel.registries }}
    - --registries
    {{- range . }}
    - {{ . | quote }}
    {{- end }}
    {{- end }}
    - --mirror-registries
    - http://$(NODE_IP):{{ .Values.service.main.ports.main.hostPort }}
    - http://$(NODE_IP):{{ .Values.service.main.ports.main.nodePort }}
    {{- with .Values.spegel.additionalMirrorRegistries }}
    {{- range . }}
    - {{ . | quote }}
    {{- end }}
    {{- end }}
    - --resolve-tags={{ .Values.spegel.resolveTags }}
    - --append-mirrors={{ .Values.spegel.appendMirrors }}
{{- end -}}
{{- define "spegel.args.main" -}}
  args:
  - registry
  - --log-level={{ .Values.spegel.logLevel }}
  - --mirror-resolve-retries={{ .Values.spegel.mirrorResolveRetries }}
  - --mirror-resolve-timeout={{ .Values.spegel.mirrorResolveTimeout }}
  - --registry-addr=:{{ .Values.service.main.ports.main.port }}
  - --router-addr=:{{ .Values.service.router.ports.router.port }}
  - --metrics-addr=:{{ .Values.service.metrics.ports.metrics.port}}
  {{- with .Values.spegel.registries }}
  - --registries
  {{- range . }}
  - {{ . | quote }}
  {{- end }}
  {{- end }}
  - --containerd-sock={{ .Values.spegel.containerdSock }}
  - --containerd-namespace={{ .Values.spegel.containerdNamespace }}
  - --containerd-registry-config-path={{ .Values.spegel.containerdRegistryConfigPath }}
  - --bootstrap-kind=dns
  - --dns-bootstrap-domain={{ include "tc.v1.common.lib.chart.names.fullname" $ }}-router.{{ include "tc.v1.common.lib.metadata.namespace" (dict "caller" "spegel" "rootCtx" $ "objectData" .Values) }}.svc.cluster.local.
  - --resolve-latest-tag={{ .Values.spegel.resolveLatestTag }}
  - --local-addr=$(NODE_IP):{{ .Values.service.main.ports.main.hostPort }}
  {{- with .Values.spegel.containerdContentPath }}
  - --containerd-content-path={{ . }}
  {{- end }}
{{- end -}}
