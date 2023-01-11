{{- define "ix.v1.common.runtimeClassName" -}}
  {{- $root := .root -}}
  {{- $runtime := .runtime -}}
  {{- $isJob := .isJob -}}
  {{/* Override previous if a runtime is passed from global defaults */}}
  {{- $runtimeName := "" -}}
  {{- with $root.Values.global.defaults.runtimeClassName -}}
    {{- $runtimeName = . -}}
  {{- end -}}

  {{/* Override previous if a runtime is passed from values */}}
  {{- with $runtime -}}
    {{- $runtimeName = . -}}
  {{- end -}}

  {{/* Override all previous if running in Scale and it's defined */}}
  {{- if hasKey $root.Values.global "ixChartContext" -}}
    {{- if $root.Values.global.ixChartContext.addNvidiaRuntimeClass -}}

      {{- $nvidiaRunTime := false -}}

      {{- if not $isJob -}}
        {{/* If main container has GPU... */}}
        {{- if $root.Values.scaleGPU -}}
          {{- $nvidiaRunTime = true -}}
        {{- end -}}

        {{- $containers := dict -}}
        {{/* Append containers if exist, to the $containers dict */}}
        {{- range $key := (list "initContainers" "installContainers" "upgradeContainers" "additionalContainers") -}}
          {{- if (get $root.Values $key) -}}
            {{- $containers = mustMerge $containers (get $root.Values $key) -}}
          {{- end -}}
        {{- end -}}

        {{/* Check containers if they have GPU assigned */}}
        {{- range $name, $container := $containers -}}
          {{- if hasKey $container "scaleGPU" -}}
            {{- if $container.scaleGPU -}}
              {{/* If at least 1 container has GPU... */}}
              {{- $nvidiaRunTime = true -}}
            {{- end -}}
          {{- end -}}
        {{- end -}}
      {{- else -}}
        {{- range $jobName, $job := $root.Values.jobs -}}
          {{- if $job.enabled -}}
            {{- range $name, $container := $job.podSpec.containers -}}
              {{- if hasKey $container "scaleGPU" -}}
                {{- if $container.scaleGPU -}}
                  {{/* If at least 1 container has GPU... */}}
                  {{- $nvidiaRunTime = true -}}
                {{- end -}}
              {{- end -}}
            {{- end -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}

      {{- if $nvidiaRunTime -}}
        {{- $runtimeName = $root.Values.global.ixChartContext.nvidiaRuntimeClassName -}}
      {{- end -}}
    {{- end -}}
  {{- end -}}

  {{/* Still check that any of the above applies before returning it */}}
  {{- if $runtimeName -}}
    {{- print $runtimeName -}}
  {{- end -}}
{{- end -}}
