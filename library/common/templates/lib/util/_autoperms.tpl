{{/* contains the auto-permissions job */}}
{{- define "tc.v1.common.lib.util.autoperms" -}}
{{- $autoperms := false -}}
{{- range $name, $mount := .Values.persistence -}}
  {{- if and $mount.enabled $mount.setPermissions -}}
      {{- if $mount.readOnly -}}
        {{- fail (printf "You cannot automatically set Permissions with readOnly enabled") -}}
      {{- end -}}
    {{- $autoperms = true -}}
  {{- end -}}
{{- end }}

{{- if $autoperms }}
{{- $fullName := include "tc.v1.common.lib.chart.names.fullname" . }}
---
apiVersion: batch/v1
kind: Job
metadata:
  namespace: {{ .Release.Namespace }}
  name: {{ $fullName }}-autopermissions
  annotations:
    "helm.sh/hook": pre-install, pre-upgrade
    "helm.sh/hook-weight": "3"
    "helm.sh/hook-delete-policy": hook-succeeded,before-hook-creation,hook-failed
spec:
  template:
    spec:
      restartPolicy: Never
      containers:
        - name: {{ $fullName }}-autopermissions
          image: {{ .Values.alpineImage.repository }}:{{ .Values.alpineImage.tag }}
          securityContext:
            runAsNonRoot: false
            runAsUser: 0
            runAsGroup: 568
            readOnlyRootFilesystem: true
            allowPrivilegeEscalation: false
            privileged: false
            seccompProfile:
              type: RuntimeDefault
            capabilities:
              add: []
              drop:
                - ALL
          resources:
            requests:
              cpu: 10m
              memory: 50Mi
            limits:
              cpu: 4000m
              memory: 8Gi
          livenessProbe:
            exec:
              command:
              - cat
              - /tmp/healthy
            initialDelaySeconds: 10
            failureThreshold: 5
            successThreshold: 1
            timeoutSeconds: 5
            periodSeconds: 10
          readinessProbe:
            exec:
              command:
              - cat
              - /tmp/healthy
            initialDelaySeconds: 10
            failureThreshold: 5
            successThreshold: 2
            timeoutSeconds: 5
            periodSeconds: 10
          startupProbe:
            exec:
              command:
              - cat
              - /tmp/healthy
            initialDelaySeconds: 10
            failureThreshold: 60
            successThreshold: 1
            timeoutSeconds: 2
            periodSeconds: 5
          command:
            - "/bin/sh"
            - "-c"
            - |
              /bin/sh <<'EOF'
              touch /tmp/healthy
              echo "Automatically correcting permissions..."
              {{- $hostPathMounts := dict -}}
              {{- range $name, $mount := .Values.persistence -}}
                {{- if and $mount.enabled $mount.setPermissions -}}
                  {{- $name = default ( $name| toString ) $mount.name -}}
                  {{- $_ := set $hostPathMounts $name $mount -}}
                {{- end -}}
              {{- end }}
              {{- if and ( .Values.addons.vpn.configFile ) ( ne .Values.addons.vpn.type "disabled" ) ( ne .Values.addons.vpn.type "tailscale" ) }}
              echo "Automatically correcting permissions for vpn config file..."
              {{- if $.Values.ixChartContext }}
              /usr/sbin/nfs4xdr_winacl -a chown -O 568 -G 568 -c /vpn/vpn.conf -p /vpn/vpn.conf || echo "Failed setting permissions using winacl..."
              {{- else }}
              chown -f :568 /vpn/vpn.conf || echo "Failed setting permissions using chown..."
              {{- end }}
              {{- end }}
              {{- range $name, $hpm := $hostPathMounts }}
              echo "Automatically correcting permissions for {{ $hpm.mountPath }}..."
              {{- if $.Values.ixChartContext }}
              /usr/sbin/nfs4xdr_winacl -a chown -G {{ .fsGroup | default $.Values.securityContext.pod.fsGroup }} -r -c  "/mounts/{{ $name }}" -p  "/mounts/{{ $name }}" || echo "Failed setting permissions using winacl..."
              {{- else }}
              chown -Rf :{{ .fsGroup | default $.Values.securityContext.pod.fsGroup }}  /mounts/$name || echo "Failed setting permissions using chown..."
              {{- end }}
              {{- end }}
              EOF
          volumeMounts:
          {{- range $name, $hpm := $hostPathMounts }}
            - name: {{ $name }}
              mountPath: /mounts/{{ $name }}
          {{- end }}
            - name: tmp-data
              mountPath: /tmp

      volumes:
      {{- range $name, $hpm := $hostPathMounts }}
        - name: {{ $name }}
          hostPath:
            path: {{ tpl $hpm.hostPath $ | squote }}
            {{- with $hpm.hostPathType }}
            type: {{ $hpm.hostPathType }}
            {{- end }}
      {{- end }}
        - name: tmp-data
          emptyDir: {}
{{- end }}
{{- end -}}
