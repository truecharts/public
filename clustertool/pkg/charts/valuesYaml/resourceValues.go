package valuesYaml

// Resources represents the schema for resource settings.
type Resources struct {
    Limits   ResourceLimits `yaml:"limits" schema:"additional_attrs:true,type:dict"`
    Requests ResourceLimits `yaml:"requests" schema:"additional_attrs:true,type:dict,hidden:true"`
}

// ResourceLimits represents the schema for resource limit settings.
type ResourceLimits struct {
    CPU    string `yaml:"cpu" schema:"type:string,default:4000m,valid_chars:^(?!^0(\\.0|m|)$)([0-9]+)(\\.[0-9]|m?)$"`
    Memory string `yaml:"memory" schema:"type:string,default:8Gi,valid_chars:^(?!^0(e[0-9]|[EPTGMK]i?|)$)([0-9]+)(|[EPTGMK]i?|e[0-9]+)$"`
}

// DeviceList represents the schema for the list of devices.
type DeviceList struct {
    DeviceListEntry []DeviceEntry `yaml:"deviceList" schema:"type:list,default:[]"`
}

// DeviceEntry represents the schema for a device entry.
type DeviceEntry struct {
    Enabled   bool   `yaml:"enabled" schema:"type:boolean,default:true"`
    Type      string `yaml:"type" schema:"type:string,default:device,hidden:true"`
    ReadOnly  bool   `yaml:"readOnly" schema:"type:boolean,default:false"`
    HostPath  string `yaml:"hostPath" schema:"type:path"`
    MountPath string `yaml:"mountPath" schema:"type:string,default:/dev/ttyACM0"`
}

// ScaleGPU represents the schema for GPU configuration.
type ScaleGPU struct {
    ScaleGPUEntry []GPUEntry `yaml:"scaleGPU" schema:"type:list,default:[]"`
}

// GPUEntry represents the schema for a GPU entry.
type GPUEntry struct {
    GPU        GPUConfiguration `yaml:"gpu" schema:"additional_attrs:true,type:dict"`
    Workaround string           `yaml:"workaround" schema:"type:string,default:workaround,hidden:true"`
}

// GPUConfiguration represents the schema for GPU configuration.
type GPUConfiguration struct {
    // Specify GPU configuration here
}
