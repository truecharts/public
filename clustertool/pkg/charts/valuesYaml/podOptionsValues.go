package valuesYaml

// DNSConfigEntry represents an entry in the DNS configuration.
type DNSConfigEntry struct {
    Name  string `yaml:"name,omitempty" validate:"required" description:"Name"`
    Value string `yaml:"value,omitempty" validate:"required" description:"Value"`
}

// PodOptions represents the "Global Pod Options (Advanced)" section of the schema.
type PodOptions struct {
    ExpertPodOpts struct {
        Type        bool      `yaml:"expertPodOpts" description:"Expert - Pod Options" default:"false" show_subquestions_if:"true"`
        HostNetwork bool      `yaml:"hostNetwork,omitempty" description:"Host Networking" default:"false"`
        DNSConfig   DNSConfig `yaml:"dnsConfig,omitempty" description:"DNS Configuration"`
    } `yaml:"podOptions,omitempty" description:"Global Pod Options (Advanced)"`
}

// DNSConfig represents the DNS configuration.
type DNSConfig struct {
    Options     []DNSConfigEntry `yaml:"options,omitempty" validate:"dive" description:"Options"`
    Nameservers []string         `yaml:"nameservers,omitempty" validate:"dive,required" description:"Nameservers"`
    Searches    []string         `yaml:"searches,omitempty" validate:"dive,required" description:"Searches"`
}
