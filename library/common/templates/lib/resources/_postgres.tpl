{{- define "common.resources.postgres" -}}
{{- if .Values.enableDB -}}


{{- $instanceName := ( printf "%v%v" ( include "common.names.fullname" .|lower ) "-postgres" )  -}}
{{- $superuser := ( default (keys .Values.postgresql.users | first ) .Values.dbsuperuser.user ) -}}
{{- $secretName := ( printf "%s.%s.credentials.postgresql.acid.zalan.do" ( $superuser ) ( $instanceName ) ) -}}
{{- $backupPVCSubpath := ( default (printf "%s/%s" .Values.dbBackup.subpathPrefix (include "common.names.fullname" .)) .Values.dbBackup.subpath ) -}}
{{- $storageClass := ( printf "%v-%v"  "ix-storage-class" .Release.Name )  -}}

{{- if not .Values.postgresql.teamId -}}
  {{- $_ := set .Values.postgresql "teamId" (include "common.names.fullname" .) }}
{{- end}}

---

apiVersion: v1
kind: Secret
metadata:
  labels:
    {{- include "common.labels" . | nindent 4 }}
    application: spilo
    team: {{ include "common.names.fullname" . }}
    "helm.sh/hook": "pre-install"
    "helm.sh/hook-delete-policy": "before-hook-creation"
  name: {{ $secretName }}
stringData:
  username: {{ $superuser }}
  password: {{ default (randAlphaNum 50) .Values.dbsuperuser.password }}
type: Opaque

---

apiVersion: "acid.zalan.do/v1"
kind: postgresql
metadata:
  name: {{ $instanceName }}
  labels:
    {{- include "common.labels" . | nindent 4 }}
spec:
  volume:
    size: "100Gi"
    storageClass: {{ $storageClass | quote }}
  {{- .Values.postgresql | toYaml | nindent 2 }}


{{- if .Values.dbBackup.existingClaim -}}
---
# ------------------- CronJob ------------------- #
apiVersion: batch/v1beta1
kind: CronJob
metadata:
  name: {{ include "common.names.fullname" . }}-backup
  labels:
    {{- include "common.labels" . | nindent 4 }}
spec:
  schedule: {{ .Values.dbBackup.schedule | quote }}
  concurrencyPolicy: Replace
  jobTemplate:
    spec:
      template:
        metadata:
          name: {{ include "common.names.fullname" . }}-backup
          labels:
            {{- include "common.labels.selectorLabels" . | nindent 12 }}
        spec:
          containers:
            - name: backup
              image: "{{ .Values.dbBackup.image.repository}}:{{ .Values.dbBackup.image.tag}}"
              imagePullPolicy: {{ .Values.dbBackup.image.imagePullPolicy}}
              command:
              - /bin/sh
              - -ce
              - |
                echo "$(date) - Start dump"
                pg_dumpall > /backup/new && mv /backup/new /backup/backup
                echo "$(date) - End dump"
                ls -lh /backup
              resources:
                {{- .Values.dbBackup.resources | toYaml | nindent 16 }}
              env:
              - name: PGHOST
                value: {{ $instanceName }}
              - name: PGUSER
                valueFrom:
                  secretKeyRef:
                    name: {{ $secretName }}
                    key: username
              - name: PGPASSWORD
                valueFrom:
                  secretKeyRef:
                    name: {{ $secretName }}
                    key: password
              volumeMounts:
              - mountPath: /backup
                name: backup-volume
                subPath: {{ $backupPVCSubpath }}
          restartPolicy: OnFailure
          volumes:
            - name: backup-volume
              persistentVolumeClaim:
                claimName: {{ .Values.dbBackup.existingClaim }}
{{- end -}}



{{- end -}}
{{- end -}}
