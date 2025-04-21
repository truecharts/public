{{- define "tc.v1.common.lib.vpa.validation" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $updPolicy := $objectData.updatePolicy -}}
  {{- if $updPolicy -}}
    {{- if not (kindIs "map" $updPolicy) -}}
      {{- fail (printf "Vertical Pod Autoscaler - Expected [updatePolicy] to be a dictionary, but got [%s]" (kindOf $updPolicy)) -}}
    {{- end -}}

    {{- if $updPolicy.updateMode -}}
      {{- $validModes := list "Auto" "Off" "Initial" "Recreate" -}}
      {{- if not (mustHas $updPolicy.updateMode $validModes) -}}
        {{- fail (printf "Vertical Pod Autoscaler - Value [%s] on [vpa.%s.updatePolicy.updateMode] is not valid. Must be one of [%s]" $updPolicy.updateMode $objectData.vpaName (join ", " $validModes)) -}}
      {{- end -}}
    {{- end -}}

    {{- if and $updPolicy.minReplicas (le ($updPolicy.minReplicas | int) 0) -}}
      {{- fail (printf "Vertical Pod Autoscaler - Value [%v] on [vpa.%s.updatePolicy.minReplicas] must be greater than 0." $updPolicy.minReplicas $objectData.vpaName) -}}
    {{- end -}}

    {{- if $updPolicy.evictionRequirements -}}
      {{- if not (kindIs "slice" $updPolicy.evictionRequirements) -}}
        {{- fail (printf "Vertical Pod Autoscaler - Value on [vpa.%s.updatePolicy.evictionRequirements] must be a list, but got [%s]" $objectData.vpaName (kindOf $updPolicy.evictionRequirements)) -}}
      {{- end -}}
      {{- range $idx, $req := $updPolicy.evictionRequirements -}}
        {{- if not (kindIs "map" $req) -}}
          {{- fail (printf "Vertical Pod Autoscaler - Value on [vpa.%s.updatePolicy.evictionRequirements.%d] must be a map, but got [%s]" $objectData.vpaName $idx (kindOf $req)) -}}
        {{- end -}}

        {{- if not $req.resources -}}
          {{- fail (printf "Vertical Pod Autoscaler - Value on [vpa.%s.updatePolicy.evictionRequirements.%d.resources] is required." $objectData.vpaName $idx) -}}
        {{- end -}}

        {{- if not (kindIs "slice" $req.resources) -}}
          {{- fail (printf "Vertical Pod Autoscaler - Value on [vpa.%s.updatePolicy.evictionRequirements.%d.resources] must be a list, but got [%s]" $objectData.vpaName $idx (kindOf $req.resources)) -}}
        {{- end -}}

        {{- $validResources := (list "cpu" "memory") -}}
        {{- range $x, $r := $req.resources -}}
          {{- if not (mustHas $r $validResources) -}}
            {{- fail (printf "Vertical Pod Autoscaler - Value [%s] on [vpa.%s.updatePolicy.evictionRequirements.%d.resources.%d] is not valid. Must be one of [%s]" $r $objectData.vpaName $idx $x (join ", " $validResources)) -}}
          {{- end -}}
        {{- end -}}

        {{- $validReq := (list "TargetHigherThanRequests" "TargetLowerThanRequests") -}}
        {{- if not (mustHas $req.changeRequirement $validReq) -}}
          {{- fail (printf "Vertical Pod Autoscaler - Value [%s] on [vpa.%s.updatePolicy.evictionRequirements.%d.changeRequirement] is not valid. Must be one of [%s]" $req.changeRequirement $objectData.vpaName $idx (join ", " $validReq)) -}}
        {{- end -}}

      {{- end -}}
    {{- end -}}

  {{- end -}}
{{- end -}}
