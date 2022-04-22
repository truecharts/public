{{- define "additionalContainers.geoip" -}}
    name: geoip
    image: "{{ .Values.geopipImage.repository }}:{{ .Values.geopipImage.tag }}"
    volumeMounts:
    - name: geopip
      mountPath: "/usr/share/GeoIP"
    env:
      - name: GEOIPUPDATE_EDITION_IDS
        value: "GeoLite2-City"
      - name: GEOIPUPDATE_FREQUENCY
        value: "8"
{{- end -}}
