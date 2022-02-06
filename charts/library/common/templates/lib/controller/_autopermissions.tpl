{{/*
This template serves as the blueprint for the mountPermissions job that is run
before chart installation.
*/}}
{{- define "common.controller.autopermissions" -}}
{{- $group := .Values.podSecurityContext.fsGroup -}}
{{- $hostPathMounts := dict -}}
{{- range $name, $mount := .Values.persistence -}}
  {{- if and $mount.enabled $mount.setPermissions -}}
    {{- $name = default ( $name| toString ) $mount.name -}}
    {{- $_ := set $hostPathMounts $name $mount -}}
  {{- end -}}
{{- end }}
- name: autopermissions
  image: {{ .Values.alpineImage.repository }}:{{ .Values.alpineImage.tag }}
  securityContext:
    runAsUser: 0
    privileged: false
    allowPrivilegeEscalation: false
    capabilities:
      drop:
        - ALL
  resources:
  {{- with .Values.resources }}
    {{- toYaml . | nindent 4 }}
  {{- end }}
  command:
    - "/bin/sh"
    - "-c"
    - "echo 'Automatically correcting permissions...';{{ if and ( .Values.addons.vpn.configFile.enabled ) ( not ( eq .Values.addons.vpn.type "disabled" )) }}chown -R 568:568 /vpn/vpn.conf; chmod -R g+w /vpn/vpn.conf || echo 'chmod failed for vpn config, are you running NFSv4 ACLs?';{{ end }}{{ range $_, $hpm := $hostPathMounts }}chown -R :{{ $group }} {{ $hpm.mountPath | squote }}; chmod -R g+w || echo 'chmod failed for {{ $hpm.mountPath }}, are you running NFSv4 ACLs?' {{ $hpm.mountPath | squote }};{{ end }}"
  volumeMounts:
    {{- if and ( .Values.addons.vpn.configFile.enabled ) ( not ( eq .Values.addons.vpn.type "disabled" )) }}
    - name: vpnconfig
      mountPath: /vpn/vpn.conf
    {{- end }}
    {{- range $name, $hpm := $hostPathMounts }}
    - name: {{ $name }}
      mountPath: {{ $hpm.mountPath }}
      {{- if $hpm.subPath }}
      subPath: {{ $hpm.subPath }}
      {{- end }}
    {{- end }}
{{- end -}}
