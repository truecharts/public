package valuesYaml

// InterfaceConfiguration represents the configuration for an interface.
type InterfaceConfiguration struct {
    HostInterface string `yaml:"hostInterface,omitempty" schema:"type:string" required:"true" description:"Host Interface"`
}

// IPAMConfiguration represents the configuration for IP Address Management.
type IPAMConfiguration struct {
    Type                   string                     `yaml:"type,omitempty" schema:"type:string" required:"true" enum:"[dhcp, static]" description:"IPAM Type"`
    StaticIPConfigurations []string                   `yaml:"staticIPConfigurations,omitempty" schema:"type:list" show_if:"[['type', '=', 'static']]" items:"type:ipaddr,cidr:true" description:"Static IP Addresses"`
    StaticRoutes           []StaticRouteConfiguration `yaml:"staticRoutes,omitempty" schema:"type:list" show_if:"[['type', '=', 'static']]" description:"Static Routes"`
}

// StaticRouteConfiguration represents the configuration for a static route.
type StaticRouteConfiguration struct {
    Destination string `yaml:"destination,omitempty" schema:"type:ipaddr,cidr:true" required:"true" description:"Destination"`
    Gateway     string `yaml:"gateway,omitempty" schema:"type:ipaddr,cidr:false" required:"true" description:"Gateway"`
}

// NetworkingExpertConfiguration represents the expert configuration for networking.
type NetworkingExpertConfiguration struct {
    ScaleExternalInterface bool                   `yaml:"scaleExternalInterface,omitempty" schema:"type:boolean" default:"false" show_subquestions_if:"true" description:"Add External Interfaces"`
    InterfaceConfiguration InterfaceConfiguration `yaml:"interfaceConfiguration,omitempty" schema:"type:dict" $ref:"normalize/interfaceConfiguration" description:"Interface Configuration"`
    IPAM                   IPAMConfiguration      `yaml:"ipam,omitempty" schema:"type:dict" required:"true" description:"IP Address Management"`
}

// ServiceExpertConfiguration represents the expert configuration for services.
type ServiceExpertConfiguration struct {
    ScaleExternalInterface bool `yaml:"scaleExternalInterface,omitempty" schema:"type:boolean" default:"false" show_subquestions_if:"true" description:"Add External Interfaces"`
}

// NetworkingConfiguration represents the configuration for networking.
type NetworkingConfiguration struct {
    ExpertConfiguration NetworkingExpertConfiguration `yaml:"expertConfiguration,omitempty" schema:"type:boolean" default:"false" show_subquestions_if:"true" description:"Show Expert Config"`
}
