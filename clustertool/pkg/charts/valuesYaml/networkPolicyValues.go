package valuesYaml

// NetworkPolicyEntry represents the schema for a network policy entry.
type NetworkPolicyEntry struct {
    Name    string         `yaml:"name" schema:"type:string,required:true,default:''"`
    Enabled bool           `yaml:"enabled" schema:"type:boolean,default:false,show_subquestions_if:true"`
    Policy  string         `yaml:"policyType" schema:"type:string,default:'',enum:,ingress,egress,ingress-egress"`
    Ingress []IngressEntry `yaml:"ingress" schema:"type:list,default:[],items:type:dict"`
    Egress  []EgressEntry  `yaml:"egress" schema:"type:list,default:[],items:type:dict"`
}

// IngressEntry represents the schema for an ingress entry.
type IngressEntry struct {
    From         []FromEntry  `yaml:"from" schema:"type:list,default:[],items:type:dict"`
    NamespaceSel NamespaceSel `yaml:"namespaceSelector" schema:"additional_attrs:true,type:dict"`
    PodSel       PodSel       `yaml:"podSelector" schema:"additional_attrs:true,type:dict"`
    Ports        []PortsEntry `yaml:"ports" schema:"type:list,default:[],items:type:dict"`
}

// EgressEntry represents the schema for an egress entry.
type EgressEntry struct {
    To           []ToEntry    `yaml:"to" schema:"type:list,default:[],items:type:dict"`
    NamespaceSel NamespaceSel `yaml:"namespaceSelector" schema:"additional_attrs:true,type:dict"`
    PodSel       PodSel       `yaml:"podSelector" schema:"additional_attrs:true,type:dict"`
    Ports        []PortsEntry `yaml:"ports" schema:"type:list,default:[],items:type:dict"`
}

// FromEntry represents the schema for a 'from' entry.
type FromEntry struct {
    IPBlock      IPBlock      `yaml:"ipBlock" schema:"additional_attrs:true,type:dict"`
    NamespaceSel NamespaceSel `yaml:"namespaceSelector" schema:"additional_attrs:true,type:dict"`
    PodSel       PodSel       `yaml:"podSelector" schema:"additional_attrs:true,type:dict"`
}

// ToEntry represents the schema for a 'to' entry.
type ToEntry struct {
    IPBlock      IPBlock      `yaml:"ipBlock" schema:"additional_attrs:true,type:dict"`
    NamespaceSel NamespaceSel `yaml:"namespaceSelector" schema:"additional_attrs:true,type:dict"`
    PodSel       PodSel       `yaml:"podSelector" schema:"additional_attrs:true,type:dict"`
}

// IPBlock represents the schema for an IP block.
type IPBlock struct {
    CIDR   string   `yaml:"cidr" schema:"type:string,default:''"`
    Except []Except `yaml:"except" schema:"type:list,default:[],items:type:dict"`
}

// Except represents the schema for the 'except' field.
type Except struct {
    ExceptInt string `yaml:"exceptint" schema:"type:string"`
}

// NamespaceSel represents the schema for namespace selector.
type NamespaceSel struct {
    MatchExpressions []ExpressionEntry `yaml:"matchExpressions" schema:"type:list,default:[],items:type:dict"`
}

// PodSel represents the schema for pod selector.
type PodSel struct {
    MatchExpressions []ExpressionEntry `yaml:"matchExpressions" schema:"type:list,default:[],items:type:dict"`
}

// ExpressionEntry represents the schema for an expression entry.
type ExpressionEntry struct {
    Key      string  `yaml:"key" schema:"type:string"`
    Operator string  `yaml:"operator" schema:"type:string,default:TCP,enum:TCP,UDP,SCTP,In,NotIn,Exists,DoesNotExist"`
    Values   []Value `yaml:"values" schema:"type:list,default:[],items:type:dict"`
}

// Value represents the schema for a value entry.
type Value struct {
    Value string `yaml:"value" schema:"type:string"`
}

// PortsEntry represents the schema for a ports entry.
type PortsEntry struct {
    Port     int    `yaml:"port" schema:"type:int"`
    EndPort  int    `yaml:"endPort" schema:"type:int"`
    Protocol string `yaml:"protocol" schema:"type:string,default:TCP,enum:TCP,UDP,SCTP"`
}
