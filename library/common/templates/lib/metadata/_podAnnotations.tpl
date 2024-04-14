{{/* Annotations that are added to podSpec */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.metadata.podAnnotations" $ }}
*/}}
{{- define "tc.v1.common.lib.metadata.podAnnotations" -}}
checksum/persistence: {{ toJson $.Values.persistence | sha256sum }}
checksum/services: {{ toJson $.Values.service | sha256sum }}
checksum/configmaps: {{ toJson $.Values.configmap | sha256sum }}
checksum/secrets: {{ toJson $.Values.secret | sha256sum }}
checksum/cnpg: {{ toJson $.Values.cnpg | sha256sum }}
checksum/mariadb: {{ toJson $.Values.mariadb | sha256sum }}
checksum/redis: {{ toJson $.Values.redis | sha256sum }}
checksum/solr: {{ toJson $.Values.solr | sha256sum }}
checksum/mongodb: {{ toJson $.Values.mongodb | sha256sum }}
{{- end -}}
