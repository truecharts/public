package valuesYaml

// Addons represents the schema for the 'addons' section.
type Addons struct {
    Codeserver Codeserver `yaml:"codeserver,omitempty" schema:"additional_attrs:true,type:dict"`
    Netshoot   Netshoot   `yaml:"netshoot,omitempty" schema:"additional_attrs:true,type:dict"`
    VPN        VPN        `yaml:"vpn,omitempty" schema:"additional_attrs:true,type:dict"`
}

// Codeserver represents the schema for the 'codeserver' addon.
type Codeserver struct {
    Enabled bool                 `yaml:"enabled" schema:"type:boolean,default:false,show_subquestions_if:true"`
    Service ServiceConfiguration `yaml:"service,omitempty" schema:"additional_attrs:true,type:dict"`
    Ingress IngressConfiguration `yaml:"ingress,omitempty" schema:"additional_attrs:true,type:dict"`
    EnvList []EnvList            `yaml:"envList,omitempty" schema:"type:list,default:[],items:type:dict,show_if:[[type,!=,disabled]]"`
}

// Netshoot represents the schema for the 'netshoot' addon.
type Netshoot struct {
    Enabled bool      `yaml:"enabled" schema:"type:boolean,default:false,show_subquestions_if:true"`
    EnvList []EnvList `yaml:"envList,omitempty" schema:"type:list,default:[],items:type:dict,show_if:[['type','!=','disabled']]"`
}

// VPN represents the schema for the 'vpn' addon.
type VPN struct {
    Type                 string            `yaml:"type,omitempty" schema:"type:string,default:disabled,enum:,disabled,gluetun,tailscale,openvpn,wireguard"`
    OpenVPN              OpenVPNSettings   `yaml:"openvpn,omitempty" schema:"additional_attrs:true,type:dict,show_if:[[type,=,openvpn]]"`
    Tailscale            TailscaleSettings `yaml:"tailscale,omitempty" schema:"additional_attrs:true,type:dict,show_if:[[type,=,tailscale]]"`
    KillSwitch           bool              `yaml:"killSwitch" schema:"type:boolean,show_if:[[type,!=,disabled]],default:true"`
    ExcludedNetworksIPv4 []ExcludedNetwork `yaml:"excludedNetworks_IPv4,omitempty" schema:"type:list,default:[],items:type:dict,show_if:[[type,!=,disabled]]"`
    ExcludedNetworksIPv6 []ExcludedNetwork `yaml:"excludedNetworks_IPv6,omitempty" schema:"type:list,default:[],items:type:dict,show_if:[[type,!=,disabled]]"`
    ConfigFile           string            `yaml:"configFile,omitempty" schema:"type:string,show_if:[[type,!=,disabled]]"`
    EnvList              []EnvList         `yaml:"envList,omitempty" schema:"type:list,default:[],items:type:dict,show_if:[['type','!=','disabled']]"`
}

// OpenVPNSettings represents the schema for OpenVPN settings.
type OpenVPNSettings struct {
    Username string `yaml:"username,omitempty" schema:"type:string,default:''"`
    Password string `yaml:"password,omitempty" schema:"type:string,show_if:[[username,!=,]],default:''"`
}

// TailscaleSettings represents the schema for Tailscale settings.
type TailscaleSettings struct {
    AuthKey                 string `yaml:"authkey,omitempty" schema:"type:string,private:true,default:''"`
    AuthOnce                bool   `yaml:"auth_once,omitempty" schema:"type:boolean,default:true"`
    AcceptDNS               bool   `yaml:"accept_dns,omitempty" schema:"type:boolean,default:false"`
    Userspace               bool   `yaml:"userspace,omitempty" schema:"type:boolean,default:false"`
    Routes                  string `yaml:"routes,omitempty" schema:"type:string,default:''"`
    DestIP                  string `yaml:"dest_ip,omitempty" schema:"type:string,default:''"`
    Sock5Server             string `yaml:"sock5_server,omitempty" schema:"type:string,default:''"`
    OutboundHTTPProxyListen string `yaml:"outbound_http_proxy_listen,omitempty" schema:"type:string,default:''"`
    ExtraArgs               string `yaml:"extra_args,omitempty" schema:"type:string,default:''"`
    DaemonExtraArgs         string `yaml:"daemon_extra_args,omitempty" schema:"type:string,default:''"`
}

// ExcludedNetwork represents the schema for an excluded network in the killswitch.
type ExcludedNetwork struct {
    NetworkV4 string `yaml:"networkv4,omitempty" schema:"type:string,required:true"`
    NetworkV6 string `yaml:"networkv6,omitempty" schema:"type:string,required:true"`
}
