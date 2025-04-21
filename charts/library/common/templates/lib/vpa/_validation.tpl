{{- define "tc.v1.common.lib.vpa.validation" -}}
  {{- $objectData := .objectData -}}
  {{- $rootCtx := .rootCtx -}}

  {{- $updPolicy := $objectData.updatePolicy -}}
  {{- if $updPolicy -}}
    {{- if not (kindIs "map" $updPolicy) -}}
      {{- fail (printf "Vertical Pod Autoscaler - Expected [vpa.%s.updatePolicy] to be a dictionary, but got [%s]" $objectData.vpaName (kindOf $updPolicy)) -}}
    {{- end -}}

    {{- $validModes := list "Auto" "Off" "Initial" "Recreate" -}}
    {{- if and $updPolicy.updateMode (not (mustHas $updPolicy.updateMode $validModes)) -}}
      {{- fail (printf "Vertical Pod Autoscaler - Value [%s] on [vpa.%s.updatePolicy.updateMode] is not valid. Must be one of [%s]" $updPolicy.updateMode $objectData.vpaName (join ", " $validModes)) -}}
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

  {{- $resPolicy := $objectData.resourcePolicy -}}
  {{- if and $resPolicy $resPolicy.containerPolicies -}}
    {{- if not (kindIs "slice" $resPolicy.containerPolicies) -}}
      {{- fail (printf "Vertical Pod Autoscaler - Value on [vpa.%s.resourcePolicy.containerPolicies] must be a list, but got [%s]" $objectData.vpaName (kindOf $resPolicy.containerPolicies)) -}}
    {{- end -}}

    {{- $validModes := (list "Auto" "Off") -}}
    {{- range $idx, $cPol := $resPolicy.containerPolicies -}}
      {{- if not (kindIs "map" $cPol) -}}
        {{- fail (printf "Vertical Pod Autoscaler - Expected [vpa.%s.resourcePolicy.containerPolicies.%d] to be a dictionary, but got [%s]" $objectData.vpaName $idx (kindOf $cPol)) -}}
      {{- end -}}

      {{- $validContainers := mustAppend $objectData.containerNames "*" -}}
      {{- if not (mustHas $cPol.containerName $validContainers) -}}
        {{- fail (printf "Vertical Pod Autoscaler - Value [%s] on [vpa.%s.resourcePolicy.containerPolicies.%d.containerName] is not valid. Must be one of [%s]" $cPol.containerName $objectData.vpaName $idx (join ", " $validContainers)) -}}
      {{- end -}}

      {{- if and $cPol.mode (not (mustHas $cPol.mode $validModes)) -}}
        {{- fail (printf "Vertical Pod Autoscaler - Value [%s] on [vpa.%s.resourcePolicy.containerPolicies.%d.mode] is not valid. Must be one of [%s]" $cPol.mode $objectData.vpaName $idx (join ", " $validModes)) -}}
      {{- end -}}

      {{- if $cPol.controlledResources -}}
        {{- if not (kindIs "slice" $cPol.controlledResources) -}}
          {{- fail (printf "Vertical Pod Autoscaler - Expected [vpa.%s.resourcePolicy.containerPolicies.%d.controlledResources] to be a list, but got [%s]" $objectData.vpaName $idx (kindOf $cPol.controlledResources)) -}}
        {{- end -}}

        {{- $validRes := (list "cpu" "memory") -}}
        {{- range $x, $r := $cPol.controlledResources -}}
          {{- if not (mustHas $r $validRes) -}}
            {{- fail (printf "Vertical Pod Autoscaler - Value [%s] on [vpa.%s.resourcePolicy.containerPolicies.%d.controlledResources.%d] is not valid. Must be one of [%s]" $r $objectData.vpaName $idx $x (join ", " $validRes)) -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}

      {{- if $cPol.controlledValues -}}
        {{- $validVals := (list "RequestsAndLimits" "RequestsOnly") -}}
        {{- if not (mustHas $cPol.controlledValues $validVals) -}}
          {{- fail (printf "Vertical Pod Autoscaler - Value [%s] on [vpa.%s.resourcePolicy.containerPolicies.%d.controlledValues] is not valid. Must be one of [%s]" $cPol.controlledValues $objectData.vpaName $idx (join ", " $validVals)) -}}
        {{- end -}}
      {{- end -}}

      {{- $data := (include "tc.v1.common.lib.resources.validation.data" .) | fromJson -}}
      {{- $regex := $data.regex -}}
      {{- $errorMsg := $data.errorMsg -}}

      {{- $items := (list "minAllowed" "maxAllowed") -}}
      {{- range $item := $items -}}
        {{- if not (get $cPol $item) -}}{{- continue -}}{{- end -}}

        {{- if not (kindIs "map" (get $cPol $item)) -}}
          {{- fail (printf "Vertical Pod Autoscaler - Expected [vpa.%s.resourcePolicy.containerPolicies.%d.%s] to be a dictionary, but got [%s]" $objectData.vpaName $idx $item (kindOf (get $cPol $item))) -}}
        {{- end -}}

        {{- range $k, $v := (get $cPol $item) -}}
          {{- if not (mustRegexMatch (get $regex $k) (toString $v)) -}}
            {{- fail (printf "Vertical Pod Autoscaler - Expected [vpa.%s.resourcePolicy.containerPolicies.%d.%s.%s] to have one of the following formats [%s], but got [%s]" $objectData.vpaName $idx $item $k (get $errorMsg $k) $v) -}}
          {{- end -}}
        {{- end -}}
      {{- end -}}

    {{- end -}}
  {{- end -}}
{{- end -}}
