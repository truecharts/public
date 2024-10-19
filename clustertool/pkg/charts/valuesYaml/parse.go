package valuesYaml

import (
    "fmt"
    "os"

    "github.com/knadh/koanf/parsers/yaml"
    "github.com/knadh/koanf/providers/file"
    "github.com/knadh/koanf/v2"
)

// TODO: enable validation
// var validate *validator.Validate

// GlobalSettings represents the "Global Settings" section of the schema.
type GlobalSettings struct {
    StopAll bool `yaml:"stopAll" description:"Stops All Running pods and hibernates cnpg" default:"false"`
}

// ImagePullSecretEntry represents an entry in the Image Pull Secrets configuration.
type ImagePullSecretEntry struct {
    Registry string `yaml:"registry" validate:"required" description:"Registry"`
    Username string `yaml:"username" validate:"required" description:"Username"`
    Password string `yaml:"password" validate:"required" description:"Password"`
    Email    string `yaml:"email" validate:"required" description:"Email"`
}

// Values represents the entire configuration.
type Values struct {
    Global              GlobalSettings                   `yaml:"global"`
    Workload            map[string]WorkloadRootReference `yaml:"workload,omitempty" schema:"additional_attrs:true,type:dict"`
    ImagePullSecretList []ImagePullSecretEntry           `yaml:"imagePullSecretList,omitempty" schema:"type:list" items:"type:dict" additional_attrs:"true" description:"Image Pull Secrets"`
    PodOptions          PodOptions                       `yaml:"podOptions,omitempty" description:"Global Pod Options (Advanced)"`
    Service             map[string]ServiceConfiguration  `yaml:"service,omitempty" schema:"additional_attrs:true,type:dict" description:"Service Settings"`
    ServiceExpert       ServiceExpertConfiguration       `yaml:"serviceexpert,omitempty" schema:"type:boolean" default:"false" show_subquestions_if:"true" description:"Show Expert Config"`
    ServiceList         []ServiceConfiguration           `yaml:"serviceList,omitempty" schema:"type:list,default:[]" items:"type:dict" description:"Add Manual Custom Services"`
    Persistence         map[string]Persistence           `yaml:"persistence,omitempty" schema:"type:dict" description:"Integrated Persistent Storage"`
    PersistenceList     []Persistence                    `yaml:"persistenceList,omitempty" schema:"type:list,default:[]" description:"Additional App Storage"`
    Ingress             map[string]IngressConfiguration  `yaml:"ingress,omitempty" schema:"additional_attrs:true,type:dict" description:"Ingress Settings"`
    IngressList         []IngressConfiguration           `yaml:"ingressList,omitempty" schema:"type:list,default:[]"`
    SecurityContext     SecurityContext                  `yaml:"securityContext,omitempty" schema:"additional_attrs:true,type:dict"`
    Resources           Resources                        `yaml:"resources,omitempty" schema:"additional_attrs:true,type:dict"`
    DeviceList          DeviceList                       `yaml:"deviceList,omitempty" schema:"type:list,default:[]"`
    ScaleGPU            ScaleGPU                         `yaml:"scaleGPU,omitempty" schema:"type:list,default:[]"`
    Metrics             map[string]MetricsConfiguration  `yaml:"metrics,omitempty" schema:"additional_attrs:true,type:dict"`
    NetworkPolicy       []NetworkPolicyEntry             `yaml:"networkPolicy,omitempty" schema:"type:list,default:[]"`
    Addons              Addons                           `yaml:"addons,omitempty" schema:"additional_attrs:true,type:dict"`
}

// ValuesFile represents the entire values.yaml structure.
type ValuesFile struct {
    K      *koanf.Koanf
    Values Values `yaml:"metadata" validate:"required,dive"`
}

func NewValuesFile() *ValuesFile {
    return &ValuesFile{
        K: koanf.New("."),
    }
}

// LoadFromFile loads values from a YAML file into the Helmvalues struct.
func (v *ValuesFile) LoadFromFile(filename string) error {
    if v.K == nil {
        v.K = koanf.New(".")
    }

    if err := v.K.Load(file.Provider(filename), yaml.Parser()); err != nil {
        return fmt.Errorf("error loading from file %s: %v", filename, err)
    }

    // Unmarshal the data into the values struct
    if err := v.K.Unmarshal("", &v.Values); err != nil {
        return fmt.Errorf("error unmarshalling data: %v", err)
    }

    // NOTE: Can be uncommented for debugging
    // loadedData, _ := v.K.Marshal(yaml.Parser())
    // log.Info().Msgf("Loaded struct data:\n%s\n", loadedData)

    // Set default values for fields if they are not set or empty
    v.setDefaultValues()

    // TODO: enable validation
    // Validate the loaded data
    // if err := validate.Struct(v.Values); err != nil {
    //  return fmt.Errorf("values.yaml validation error: %v", err)
    // }

    return nil
}

// setDefaultValues sets default values for fields in valuesMetadata if they are not set or empty.
func (v *ValuesFile) setDefaultValues() {
    // Set default values for other fields as needed
}

// SaveToFile saves the Helm values metadata back to the values.yaml file.
func (v *ValuesFile) SaveToFile(filename string) error {
    // Marshal the existing metadata to YAML
    loadedData, err := v.K.Marshal(yaml.Parser())
    if err != nil {
        return fmt.Errorf("error marshalling data: %v", err)
    }

    // Write the configuration to the file using os.WriteFile
    err = os.WriteFile(filename, loadedData, 0644)
    if err != nil {
        return fmt.Errorf("error writing to file %s: %v", filename, err)
    }

    return nil
}
