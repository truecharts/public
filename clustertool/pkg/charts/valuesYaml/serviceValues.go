package valuesYaml

// PortConfiguration represents the configuration for a service port.
type PortConfiguration struct {
    Enabled    bool   `yaml:"enabled" schema:"type:boolean" default:"true" hidden:"true" description:"Enable the Port"`
    Name       string `yaml:"name" schema:"type:string" default:"" description:"Port Name"`
    Protocol   string `yaml:"protocol" schema:"type:string" default:"tcp" enum:"[http, https, tcp, udp]" description:"Port Type"`
    TargetPort int    `yaml:"targetPort" schema:"type:int" required:"true" description:"Target Port"`
    Port       int    `yaml:"port" schema:"type:int" required:"true" description:"Container Port"`
}

// AdvancedServiceSettings represents the advanced settings for a service.
type AdvancedServiceSettings struct {
    ExternalIPs    []string `yaml:"externalIPs" schema:"type:list" default:"[]" items:"type:string" description:"External IP's"`
    IPFamilyPolicy string   `yaml:"ipFamilyPolicy" schema:"type:string" default:"SingleStack" enum:"[SingleStack, PreferDualStack, RequireDualStack]" description:"IP Family Policy"`
    IPFamilies     []string `yaml:"ipFamilies" schema:"type:list" default:"[]" items:"type:string" description:"(Advanced) The IP Families that should be used"`
}

// ServiceConfiguration represents the configuration for a service.
type ServiceConfiguration struct {
    Enabled        bool                    `yaml:"enabled" schema:"type:boolean" default:"true" hidden:"true" description:"Enable the service"`
    Name           string                  `yaml:"name" schema:"type:string" default:"" description:"Name"`
    Type           string                  `yaml:"type" schema:"type:string" default:"LoadBalancer" enum:"[LoadBalancer, ClusterIP, Simple]" description:"Service Type"`
    LoadBalancerIP string                  `yaml:"loadBalancerIP" schema:"type:string" show_if:"[['type', '=', 'LoadBalancer']]" default:"" description:"LoadBalancer IP"`
    AdvancedSvcSet AdvancedServiceSettings `yaml:"advancedsvcset" schema:"type:boolean" default:"false" show_subquestions_if:"true" description:"Show Advanced Service Settings"`
    Ports          PortConfiguration       `yaml:"ports" schema:"type:dict" description:"Service's Port(s) Configuration"`
    PortsList      []PortConfiguration     `yaml:"portsList" schema:"type:list" default:"[]" items:"type:dict" description:"Additional Service Ports"`
}
