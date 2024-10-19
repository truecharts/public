package valuesYaml

// WorkloadRootReference represents the schema for the root reference in workload settings.
type WorkloadRootReference struct {
    Type           string          `yaml:"type,omitempty" schema:"type:string,default:Deployment,enum:,Deployment,DaemonSet"`
    Replicas       int             `yaml:"replicas,omitempty" schema:"type:int,show_if:[[type,!=,DaemonSet]],default:1"`
    PodSpec        WorkloadPodSpec `yaml:"podSpec,omitempty" schema:"additional_attrs:true,type:dict"`
    UpdateStrategy string          `yaml:"updateStrategy,omitempty"`
}

// WorkloadPodSpec represents the schema for the pod spec in workload settings.
type WorkloadPodSpec struct {
    Containers WorkloadContainers `yaml:"containers,omitempty" schema:"additional_attrs:true,type:dict"`
}

// WorkloadContainers represents the schema for containers in workload settings.
type WorkloadContainers struct {
    ContainerItem WorkloadContainerItem `yaml:"containerItem,omitempty" schema:"additional_attrs:true,type:dict"`
}

// WorkloadContainerItem represents the schema for a container item in workload settings.
type WorkloadContainerItem struct {
    Env            map[string]string         `yaml:"env,omitempty" schema:"additional_attrs:true,type:dict"`
    EnvList        []EnvList                 `yaml:"envList,omitempty" schema:"type:list,default:[],items:type:dict"`
    ExtraArgs      []string                  `yaml:"extraArgs,omitempty" schema:"type:list,default:[]"`
    Advanced       WorkloadContainerAdvanced `yaml:"advanced,omitempty" schema:"type:boolean,default:false,show_subquestions_if:true"`
    Probes         WorkloadProbes            `yaml:"probes,omitempty"`
    UpdateStrategy string                    `yaml:"updateStrategy,omitempty"`
}

// EnvList represents the schema for an environment variable list item in workload settings.
type EnvList struct {
    Name  string `yaml:"name,omitempty" schema:"type:string"`
    Value string `yaml:"value,omitempty" schema:"type:string"`
}

// WorkloadContainerAdvanced represents the schema for advanced settings in the workload container settings.
type WorkloadContainerAdvanced struct {
    Command       []string          `yaml:"command,omitempty" schema:"type:list,default:[],items:type:string"`
    ExtraSettings map[string]string `yaml:"extraSettings,omitempty" schema:"type:dict"`
}

// WorkloadProbes represents the schema for probes in workload container settings.
type WorkloadProbes struct {
    Liveness  Probe `yaml:"liveness,omitempty"`
    Readiness Probe `yaml:"readiness,omitempty"`
    Startup   Probe `yaml:"startup,omitempty"`
}

// Probe represents the schema for a probe in workload container settings.
type Probe struct {
    Path string `yaml:"path,omitempty"`
}
