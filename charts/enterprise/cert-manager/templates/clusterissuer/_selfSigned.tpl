{{- define "certmanager.clusterissuer.selfsigned" -}}
{{- if .Values.clusterIssuer.selfSigned.enabled }}
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: {{ .Values.clusterIssuer.selfSigned.name }}
spec:
  selfSigned: {}
{{- end }}
{{- end -}}
