{{- define "certmanager.clusterissuer.acme" -}}
{{- if .Values.clusterissuer.selfSigned.enabled }}
---
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: {{ .Values.clusterissuer.selfSigned.name }}
spec:
  selfSigned: {}
{{- end }}
{{- end -}}
