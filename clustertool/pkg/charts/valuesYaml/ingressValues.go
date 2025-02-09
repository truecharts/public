package valuesYaml

// MiddlewareEntry represents the schema for a middleware entry.
type MiddlewareEntry struct {
    Name string `yaml:"name" schema:"type:string,default:'',required:true"`
}

// Integration represents the schema for integrations.
type Integration struct {
    Homepage IntegrationHomepage `yaml:"homepage" schema:"additional_attrs:true,type:dict"`
}

// IntegrationHomepage represents the schema for the Homepage integration.
type IntegrationHomepage struct {
    Enabled     bool   `yaml:"enabled" schema:"type:boolean,default:false"`
    Name        string `yaml:"name" schema:"type:string,default:'',show_if:[[enabled,=,true]]"`
    Description string `yaml:"description" schema:"type:string,default:'',show_if:[[enabled,=,true]]"`
    Group       string `yaml:"group" schema:"type:string,default:default,show_if:[[enabled,=,true]]"`
}

// TLSEntry represents the schema for a TLS entry.
type TLSEntry struct {
    Host               []string `yaml:"hosts" schema:"type:list,default:[],items:type:string,required:true"`
    CertificateIssuer  string   `yaml:"certificateIssuer" schema:"type:string,default:''"`
    ClusterCertificate string   `yaml:"clusterCertificate" schema:"type:string,show_if:[[certificateIssuer,=,]]"`
    SecretName         string   `yaml:"secretName" schema:"type:string,show_if:[[certificateIssuer,=,]]"`
    ScaleCert          int      `yaml:"scaleCert" schema:"type:int,show_if:[[certificateIssuer,=,]]"`
}

// IngressConfiguration represents the schema for Ingress settings with variable name.
type IngressConfiguration struct {
    Enabled           bool              `yaml:"enabled" schema:"type:boolean,default:true,hidden:true"`
    Name              string            `yaml:"name" schema:"type:string,default:''"`
    IngressClassName  string            `yaml:"ingressClassName" schema:"type:string,default:''"`
    AllowCors         bool              `yaml:"allowCors" schema:"type:boolean,show_if:[[advanced,=,true]],default:false"`
    Hosts             []HostEntry       `yaml:"hosts" schema:"type:list,default:[],items:type:dict"`
    CertificateIssuer string            `yaml:"certificateIssuer" schema:"type:string,default:''"`
    TLS               []TLSEntry        `yaml:"tls" schema:"type:list,default:[],items:type:dict,show_if:[[certificateIssuer,=,]]"`
    Integration       Integration       `yaml:"integration" schema:"additional_attrs:true,type:dict"`
    Entrypoint        string            `yaml:"entrypoint" schema:"type:string,default:websecure,required:true"`
    Middlewares       []MiddlewareEntry `yaml:"middlewares" schema:"type:list,default:[],items:type:dict"`
}

// HostEntry represents the schema for a host entry.
type HostEntry struct {
    Host  string      `yaml:"host" schema:"type:string,default:'',required:true"`
    Paths []PathEntry `yaml:"paths" schema:"type:list,default:[{path:/,pathType:Prefix}],items:type:dict"`
}

// PathEntry represents the schema for a path entry.
type PathEntry struct {
    Path     string `yaml:"path" schema:"type:string,required:true,default:/"`
    PathType string `yaml:"pathType" schema:"type:string,required:true,default:Prefix"`
}

// RootReference represents the root-level reference for Ingress settings.
type RootReference struct {
    Ingress map[string]IngressConfiguration `yaml:"ingress" schema:"additional_attrs:true,type:dict" description:"Ingress Settings"`
}
