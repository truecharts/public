package valuesYaml

// PrometheusRule represents the schema for Prometheus rule settings.
type PrometheusRule struct {
    Enabled bool `yaml:"enabled" schema:"type:boolean,default:false"`
}

// MetricsConfiguration represents the metrics configuration.
type MetricsConfiguration struct {
    Enabled        bool `yaml:"enabled"`
    PrometheusRule struct {
        Enabled bool `yaml:"enabled"`
        // ... other prometheusRule configuration
    } `yaml:"prometheusRule"`
    // ... other metrics configuration
}
