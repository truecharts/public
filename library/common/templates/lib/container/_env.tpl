{{/* Returns Env */}}
{{/* Call this template:
{{ include "tc.v1.common.lib.container.env" (dict "rootCtx" $ "objectData" $objectData) }}
rootCtx: The root context of the chart.
objectData: The object data to be used to render the container.
*/}}
{{- define "tc.v1.common.lib.container.env" -}}
  {{- $rootCtx := .rootCtx -}}
  {{- $objectData := .objectData -}}

  {{- range $k, $v := $objectData.env -}}
    {{- include "tc.v1.common.helper.container.envDupeCheck" (dict "rootCtx" $rootCtx "objectData" $objectData "source" "env" "key" $k) }}
- name: {{ $k | quote }}
    {{- if not (kindIs "map" $v) -}}
      {{- $value := "" -}}
      {{- if not (kindIs "invalid" $v) -}} {{/* Only tpl non-empty values */}}
        {{- $value = $v -}}
        {{- if kindIs "string" $v -}}
          {{- $value = tpl $v $rootCtx -}}
        {{- end -}}
      {{- end }}
  value: {{ include "tc.v1.common.helper.makeIntOrNoop" $value | quote }}
    {{- else if kindIs "map" $v }}
  valueFrom:
      {{- $refs := (list "configMapKeyRef" "secretKeyRef" "fieldRef") -}}
      {{- if or (ne (len ($v | keys)) 1) (not (mustHas ($v | keys | first) $refs)) -}}
        {{- fail (printf "Container - Expected [env] with a ref to have one of [%s], but got [%s]" (join ", " $refs) (join ", " ($v | keys | sortAlpha))) -}}
      {{- end -}}

      {{- $name := "" -}}


      {{- range $key := (list "configMapKeyRef" "secretKeyRef") -}}
        {{- if hasKey $v $key }}
    {{ $key }}:
          {{- $obj := get $v $key -}}
          {{- if not $obj.name -}}
            {{- fail (printf "Container - Expected non-empty [env.%s.name]" $key) -}}
          {{- end -}}

          {{- if not $obj.key -}}
            {{- fail (printf "Container - Expected non-empty [env.%s.key]" $key) -}}
          {{- end }}
      key: {{ $obj.key | quote }}

          {{- $name = tpl $obj.name $rootCtx -}}

          {{- $expandName := (include "tc.v1.common.lib.util.expandName" (dict
                          "rootCtx" $rootCtx "objectData" $obj
                          "name" $k "caller" "Container"
                          "key" "env")) -}}

          {{- if eq $expandName "true" -}}
            {{- $item := ($key | trimSuffix "KeyRef" | lower) -}}

            {{- $data := (get $rootCtx.Values $item) -}}
            {{- $data = (get $data $name) -}}

            {{- if not $data -}}
              {{- fail (printf "Container - Expected in [env] the referenced %s [%s] to be defined" (camelcase $item) $name) -}}
            {{- end -}}

            {{- $found := false -}}
            {{- range $k, $v := $data.data -}}
              {{- if eq $k $obj.key -}}
                {{- $found = true -}}
              {{- end -}}
            {{- end -}}

            {{- if not $found -}}
              {{- fail (printf "Container - Expected in [env] the referenced key [%s] in %s [%s] to be defined" $obj.key (camelcase $item) $name) -}}
            {{- end -}}

            {{- $name = (printf "%s-%s" (include "tc.v1.common.lib.chart.names.fullname" $rootCtx) $name) -}}
          {{- end }}
      name: {{ $name | quote }}
        {{- end -}}
      {{- end -}}

      {{- if hasKey $v "fieldRef" }}
    fieldRef:
        {{- if not $v.fieldRef.fieldPath -}}
          {{- fail "Container - Expected non-empty [env.fieldRef.fieldPath]" -}}
        {{- end }}
      fieldPath: {{ $v.fieldRef.fieldPath | quote }}
        {{- if $v.fieldRef.apiVersion }}
      apiVersion: {{ $v.fieldRef.apiVersion | quote }}
        {{- end -}}
      {{- end -}}
    {{- end -}}

  {{- end -}}
{{- end -}}
