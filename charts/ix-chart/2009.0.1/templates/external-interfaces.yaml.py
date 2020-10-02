{{- range $index, $iface := .Values.externalInterfaces }}
apiVersion: "k8s.cni.cncf.io/v1"
kind: NetworkAttachmentDefinition
metadata:
  name: {{ include "externalInterfaceName" . }}-{{ $index }}
spec:
  config: '{{ $iface }}'
----------------------------------------------------------
{{- end }}
