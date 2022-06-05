{{/*
This template serves as the blueprint for the mountPermissions job that is run
before chart installation.
*/}}
{{- define "tc.common.controller.prepare" -}}
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
    privileged: true
  resources:
  {{- with .Values.resources }}
    {{- tpl ( toYaml . ) $ | nindent 4 }}
  {{- end }}
  command:
    - "/bin/sh"
    - "-c"
    - |
      /bin/bash <<'EOF'
      echo "Automatically correcting permissions..."
      {{- if and ( .Values.addons.vpn.configFile.enabled ) ( not ( eq .Values.addons.vpn.type "disabled" )) }}
      echo "Automatically correcting permissions for vpn config file..."
      if nfs4xdr_getfacl && nfs4xdr_getfacl | grep -qv "Failed to get NFSv4 ACL"; then
        echo "NFSv4 ACLs detected, using nfs4_setfacl to set permissions..."
        nfs4_setfacl -a A::568:RWX /vpn/vpn.conf
        nfs4_setfacl -a A:g:568:RWX /vpn/vpn.conf
      else
        echo "No NFSv4 ACLs detected, trying chown/chmod..."
        chown -R 568:568 /vpn/vpn.conf
        chmod -R g+w /vpn/vpn.conf
      fi
      {{- end }}
      {{- range $_, $hpm := $hostPathMounts }}
      echo "Automatically correcting permissions for {{ $hpm.mountPath }}..."
      if nfs4xdr_getfacl && nfs4xdr_getfacl | grep -qv "Failed to get NFSv4 ACL"; then
        echo "NFSv4 ACLs detected, using nfs4_setfacl to set permissions..."
        nfs4_setfacl -R -a A:g:{{ $group }}:RWX {{ tpl $hpm.mountPath $ | squote }}
      else
        echo "No NFSv4 ACLs detected, trying chown/chmod..."
        chown -R :{{ $group }} {{ tpl $hpm.mountPath $ | squote }}
        chmod -R g+rwx {{ tpl $hpm.mountPath $ | squote }}
      fi
      {{- end }}
      {{- if .Values.patchInotify }}
      echo "increasing inotify limits..."
      ( sysctl -w fs.inotify.max_user_watches=524288 || echo "error setting inotify") && ( sysctl -w fs.inotify.max_user_instances=512 || echo "error setting inotify")
      {{- end }}
      EOF

  volumeMounts:
    {{- range $name, $hpm := $hostPathMounts }}
    - name: {{ $name }}
      mountPath: {{ $hpm.mountPath }}
      {{- if $hpm.subPath }}
      subPath: {{ $hpm.subPath }}
      {{- end }}
    {{- end }}
    {{- if and ( .Values.addons.vpn.configFile.enabled ) ( not ( eq .Values.addons.vpn.type "disabled" )) }}
    - name: vpnconfig
      mountPath: /vpn/vpn.conf
    {{- end }}
{{- end -}}
