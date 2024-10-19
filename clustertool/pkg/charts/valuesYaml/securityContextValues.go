package valuesYaml

// Container represents the schema for container settings.
type Container struct {
    RunAsUser              int    `yaml:"runAsUser" schema:"type:int,default:568"`
    RunAsGroup             int    `yaml:"runAsGroup" schema:"type:int,default:568"`
    PUID                   int    `yaml:"PUID" schema:"type:int,default:568,show_if:[[runAsUser,=,0]]"`
    UMASK                  string `yaml:"UMASK" schema:"type:string,default:0022"`
    Advanced               bool   `yaml:"advanced" schema:"type:boolean,default:false,show_subquestions_if:true"`
    Privileged             bool   `yaml:"privileged" schema:"type:boolean,default:false,show_if:[[advanced,=,true]]"`
    ReadOnlyRootFilesystem bool   `yaml:"readOnlyRootFilesystem" schema:"type:boolean,default:true,show_if:[[advanced,=,true]]"`
}

// Pod represents the schema for pod settings.
type Pod struct {
    FsGroupChangePolicy string `yaml:"fsGroupChangePolicy" schema:"type:string,default:OnRootMismatch,enum:OnRootMismatch,Always"`
    SupplementalGroups  []int  `yaml:"supplementalGroups" schema:"type:list,default:[],items:type:int"`
    FsGroup             int    `yaml:"fsGroup" schema:"type:int,default:568"`
}

// SecurityContext represents the schema for security context settings.
type SecurityContext struct {
    Container Container `yaml:"container" schema:"additional_attrs:true,type:dict"`
    Pod       Pod       `yaml:"pod" schema:"additional_attrs:true,type:dict"`
}
